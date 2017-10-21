document.addEventListener "DOMContentLoaded", ->
  setUpChessBoard = (form) ->
    return if form.querySelector(".chessboard[data-over='true']")

    getMoves = (current) ->
      JSON.parse(current.getAttribute('data-moves'))

    getMovePositions = (current) ->
      form.querySelector(".chessboard-position[data-position=#{move.slice(-2)}]") for move in getMoves(current)

    showPageLoader = ->
      form.querySelector(".pageloader").className += " is-active"

    hidePageLoader = ->
      form.querySelector(".pageloader").className = "pageloader"

    isFormDisabled = ->
      form.getAttribute("data-disabled") == "true"

    disableForm = ->
      form.setAttribute("data-disabled", true)

    moveTo = (newPositionElement) ->
      disableForm()
      showPageLoader()

      currentPosition = selectedPosition().getAttribute('data-position')
      newPosition = newPositionElement.getAttribute('data-position')
      moveField = form.querySelector("[name='game[move]']")

      if !currentPosition || !newPosition || !moveField
        location.reload()

      moveField.value = "#{currentPosition}#{newPosition}"
      form.submit()

    toggleMoves = (current, set) ->
      return if isFormDisabled()

      positions = getMovePositions(current)
      for position in positions when position
        position.setAttribute('data-possible-move', String(set))
        if set
          position.addEventListener 'click', -> moveTo(this)
        else
          position.removeEventListener 'click', -> moveTo(this)

      current.setAttribute('data-hover', String(set))

    allPositions = ->
      form.querySelectorAll(".chessboard-position")

    selectedPosition = ->
      form.querySelector('.chessboard-position[data-selected="true"]')

    showMoves = (current) ->
      toggleMoves(current, true)

    hideMoves = (current) ->
      return if isFormDisabled()

      toggleMoves(current, false)
      selected = selectedPosition()
      if selected
        toggleMoves(selected, true)

    selectPosition = (current) ->
      return if isFormDisabled()

      selected = selectedPosition()
      if selected
        selected.setAttribute('data-selected', "false")
        toggleMoves(selected, false)

      if current != selected
        toggleMoves(current, true)
        current.setAttribute('data-selected', "true")

    setEvents = ->
      for position in allPositions() when getMoves(position).length > 0
        position.setAttribute('data-selectable', "true")
        position.addEventListener 'mouseenter', -> showMoves(this, "true")
        position.addEventListener 'mouseleave', -> hideMoves(this, "false")
        position.addEventListener 'click', -> selectPosition(this)

    setEvents()

  setUpChessBoard(document.querySelector("form.new_game"))
