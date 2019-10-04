Rails.application.routes.draw do
  namespace :api, as: nil, defaults: { format: 'json' } do
    namespace :v1, as: nil do
      resources :merchants do
        collection do
          post :upload_users
        end

        resources :transactions
      end
    end
  end
end
