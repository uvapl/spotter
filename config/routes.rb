Rails.application.routes.draw do
    resources 'planner', only: [ :index, :show ]
    resources 'courses', only: [] do
        resources 'appointments', only: [ :create ]
    end
    resources 'users', only: [ :new, :create ]
    get 'logout', to: 'users#logout'
    root to: "home#index"

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
