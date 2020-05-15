Rails.application.routes.draw do
  devise_for :admins
  devise_for :members

  #ECサイト用ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

  root 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  get '/members/exit', to: 'members#exit', as: 'exit_member'
  patch '/members/exit/:id', to: 'members#is_deleted', as: 'exit_members'
  post '/members/orders/confirm', to: 'orders#confirm', as: 'confirm_order'
  get '/members/orders/thanks', to: 'orders#thanks', as: 'thanks_order'
  delete '/members/cart_items', to: 'car_items#clean', as: 'clean_car_items'
  #get '/genres/:id/items', to: 'items#genre_index', as: 'genre_items'

  namespace :member do
      resources :members, only: [:show, :edit, :update]
      resources :orders, only: [:new, :show, :index, :create]
      resources :cart_items, only: [:index, :create, :update, :destroy]
      resources :ships, only: [:index, :edit, :create, :update, :destroy]
      resources :items, only: [:show, :index]
  end


  #Adminサイト用ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

  get 'admin/', to: 'homes#top', as: 'admin_top'
  # get 'admin/orders_today', to: 'orders#index_today', as: 'admin_today_orders'
  #get 'admin/members/:id/orders', to: 'orders#index_member',
  #                                                    as: 'admin_member_orders'

  namespace :admin do
      resources :members, only: [:show, :index, :edit, :update]
      resources :items, only: [:new, :show, :index, :edit, :create, :update]
      resources :orders, only: [:show, :index, :update] do
        resources :order_items, only: [:update]
      end
      resources :genres, only: [:index, :edit, :create, :update]
  end
end
