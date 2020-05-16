Rails.application.routes.draw do
#devise gem
  devise_for :admins
  devise_for :members

#管理者側
  namespace :admin do
  	resources :members, only:[:index, :show, :edit, :update]
  	resources :items, only:[:new, :index, :create, :show, :edit, :update]
  	resources :orders, only:[:index, :show, :update] do
  		resources :order_items, only:[:update]
  	end
  	resources :genres, only:[:index, :edit, :create, :update]
  end

#会員側
  namespace :member do
  	resources :members, only:[:show, :edit, :update]
  	get 'exit' => 'members#exit', as: 'exit'
  	patch 'exit/:id' => 'members#is_deleted', as: 'exit_member'

  	resources :items, only:[:index, :show]
  	resources :ships, only:[:index, :create, :edit, :update, :destroy]
  	resources :cart_items, only:[:index, :create, :update, :destroy]
  	delete 'clean' => 'cart_items#clean', as: 'clean_cart_item'

  	resources :orders, only:[:new, :index, :show, :create]
  	post 'confirm' => 'orders#confirm', as: 'confirm_order'
  	get 'thanks' => 'orders#thanks', as: 'thanks_order'
  end

  root 'homes#top'
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
