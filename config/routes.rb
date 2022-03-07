Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update]

  get "tone", to: "users#tone"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
