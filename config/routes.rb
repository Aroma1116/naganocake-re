Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :items, only: [:index, :show]
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :create, :update, :destroy]
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/thanks' => 'orders#thanks'
  resources :orders, only: [:new, :create, :index, :show]
end

namespace :admin do
  root to: 'orders#index'
  resources :genres, only: [:index, :create, :edit, :update]
  get "items/search" => 'items#search'
  resources :items
  resources :customers
  resources :orders, only: [:index, :show, :update]
  resources :order_details, only: [:update]
end
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
