Rails.application.routes.draw do
  resources :peer_teacher_logins
  resources :administrators
  ActiveAdmin.routes(self)
  
  devise_for :users, skip: :registrations, controllers: {
      :sessions => 'users/sessions',
      :passwords => 'users/passwords',
      :registrations => 'users/registrations'
  }
  
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'users/registrations',
      as: :user_registration do
        get :cancel
    end
      
    
    get 'users/sign_out' => 'users/sessions#destroy'
    get 'users/sign_in'  => 'home#index'
    get 'users/password/edit' => 'users/password#edit'
  end
  
  get 'login_hub/index'                 #the index is for the regular user 
  get 'login_hub/admin'                 #for the admin page 
  
  get 'home/index'
  get 'home/populate_db'
  get 'home/availables'
  
  get '/ptc', to: 'ptc#ptc'
  get '/admin', to: 'admin#admin'
  get '/pt', to: 'pt#pt'

  root 'home#index' 

      resources :peer_teachers
      resources :office_hours
      resources :updates

end
