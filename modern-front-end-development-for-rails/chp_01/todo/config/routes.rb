Rails.application.routes.draw do
  
    
  resources :todo_lists do
    resources :todo_items
  end
  resources :todo_items do
    member do
      get :toggle_completed
    end
  end
  
  root controller: :todo_lists, action: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
