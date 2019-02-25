Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
  get 'reset_score', to: 'games#reset_score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
