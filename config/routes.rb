Rails.application.routes.draw do
    resources 'live', only: [ :index ]
    resources 'planner', only: [ :index, :show ]
    resources 'courses', only: [ :index, :new, :create, :edit, :update ] do
        resources 'appointments', only: [ :create ]
        post 'bulk', to: 'courses#bulk'
    end
    resources 'appointments', only: [ :show ]
    resources 'users', only: [ :new, :create ]
    post 'logout', to: 'users#logout'
    post '/appointments/:appointment_id/complete', to: 'appointments#complete'
    root to: "home#index"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
