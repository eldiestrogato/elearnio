Rails.application.routes.draw do
  #root 'orders_admin/admin#index'
  namespace 'api' do
    namespace 'v1' do
      resources :courses
      resources :learning_paths
      resources :authors
      resources :talents do
        resources :study_units, except: :index
        resources :study_learning_paths, except: :index
      end
      resources :study_units, only: :index
      resources :study_learning_paths, only: :index
    end
  end
end
