Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about' => 'pages#about'

  resources 'articles'

  get 'signup', to: 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # post 'users', to: 'users#create'
  resources 'users', except: [:new]


  resources :categories, except: [:destroy]
end
