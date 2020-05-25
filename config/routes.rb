Rails.application.routes.draw do
  # 一般公開URL
  root 'homes#top'
  get '/about' => 'homes#about'
  resources :items,only:[:index,:show] do
    member do
      get :search
    end
  end

  # 会員限定URL
  scope module: :member do
  	resource :members,only:[:show,:edit,:update] do
      collection do
        get :exit
        patch :is_deleted
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
  devise_for :member, skip: :all
  devise_scope :member do
    get '/member/sign_up', to: 'members/registrations#new', as: :new_member_registration
    post '/member/sign_up', to: 'members/registrations#create', as: :member_registration
    get '/member/sign_in', to: 'members/sessions#new', as: :new_member_session
    post '/member/sign_in', to: 'members/sessions#create', as: :member_session
    delete '/member/sign_out', to: 'members/sessions#destroy', as: :destroy_member_session
    get '/member/logout', to: 'members/sessions#destroy', as: :logout_member
    get '/member/password/new', to: 'members/passwords#new', as: :new_member_password
    get '/member/password/edit', to: 'members/passwords#edit', as: :edit_member_password
  end

  # 管理者用URL
  devise_for :admin, skip: :all
  devise_scope :admin do
    get '/admin/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post '/admin/sign_in', to: 'admins/sessions#create', as: :admin_session
    delete '/admin/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  scope module: :admin do
    get "/admin" => "homes#top"
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
