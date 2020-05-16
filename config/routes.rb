Rails.application.routes.draw do
  # 一般公開URL
  root 'homes#top'
  get '/about' => 'homes#about'
  resources :items,only:[:index,:show]

  # 会員限定URL
  scope module: :member do
    devise_for :members
    # , controllers: {
      # sessions:      'members/sessions'
      # passwords:     'members/passwords'
      # registrations: 'members/registrations'
    # }
  	resource :members,only:[:show,:edit,:update] do
      collection do
        get :exit
        patch :exit
      end
      resources :ships,only:[:index,:create,:edit,:update,:destroy]
      resources :cart_items,only:[:index,:create,:update,:destroy] do
        collection do
          delete :clear
        end
      end
      resources :orders,only:[:index,:show,:new,:create] do
        collection do
          get :thanks
          post :confirm
        end
      end
    end
  end

  # 管理者用URL
  scope module: :admin do
    get "/admin" => "homes#top"
    devise_for :admins
    # , controllers: {
      # sessions:      'admins/sessions',
      # passwords:     'admins/passwords',
      # registrations: 'admins/registrations'
    # }
  end
  namespace :admin do
  	resources :items,only:[:index,:show,:new,:create,:edit,:update]
    resources :members, only:[:index,:show,:edit,:update]
    resources :orders, only:[:index,:show,:update] do
      member do
        resource :order_items, only: [:update]
      end
    end
    resources :genres,only:[:index,:create,:edit,:update]
  end
end
