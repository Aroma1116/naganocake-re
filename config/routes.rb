Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'customers/my_page' => 'customers#show'
  get 'customers/infomation/edit' => 'customers#edit'
  patch 'customers/infomation' => 'customers#update'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end

namespace :admin do
  root to: 'homes#top'
  resources :customers
end
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
