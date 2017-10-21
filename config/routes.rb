Rails.application.routes.draw do
  root to: "games#new"

  get '/auth/:provider/callback', :to => 'sessions#create'

  resources :games, only: [:new, :create] do
    put :resign
  end
  get "/:parent_id", :to => "games#new", as: "short_new_game"
end
