Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      # Authentication routes
      get '/login', to: 'sessions#new'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'

      # # Resource routes
      # resources :students 
      # resources :mentors 
      # resources :enrollments
      # resources :mentor_enrollment_assignments
      # resources :lessons
      # resources :courses do 
      #   resources :submissions
      # end 
      # resources :coding_classes
      # resources :trimesters 

      get '/students', to: 'students#index'
      get '/mentors', to: 'mentors#index'
      get '/enrollments', to: 'enrollments#index'
      get '/mentor_enrollment_assignments', to: 'mentor_enrollment_assignments#index'
      get '/lessons', to: 'lessons#index'
      get '/courses/:course_id/submissions', to: 'submissions#index'
      get '/coding_classes', to: 'coding_classes#index'
      get '/trimesters', to: 'trimesters#index'

      # Admin dashboard route
      get '/dashboard', to: "admin_dashboard#index"
    end 
  end 
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
