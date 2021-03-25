Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :topics, only: [:create, :index, :show, :update, :destroy] do
        patch :publish, on: :member
        patch :unpublish, on: :member
      end

      controller :parsers do
        post :parse_guests
        post :parse_agendas
      end

    end
  end

end
