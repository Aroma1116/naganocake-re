Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'customers/my_page' => 'customers#show'
  resources :items, only: [:index, :show]
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :create, :update, :destroy]
end

namespace :admin do
  root to: 'homes#top'
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items
end
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
