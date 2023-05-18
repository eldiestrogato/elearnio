Rails.application.routes.draw do
  #root 'orders_admin/admin#index'
  namespace 'api' do
    namespace 'v1' do
      resources :courses
      resources :learning_paths
      resources :authors
      resources :talents do
        resources :study_units
        resources :study_lps
      end

    end
  end
end
