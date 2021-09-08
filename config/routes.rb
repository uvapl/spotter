Rails.application.routes.draw do
    resources 'live', only: [ :index ]
    resources 'planner', only: [ :index, :show ]
    resources 'courses', only: [ :index, :new, :create, :edit, :update ] do
        resources 'appointments', only: [ :create ]
        post 'bulk', to: 'courses#bulk'
        resources 'year', param: 'number', only: [] do
            resources 'week', param: 'number', only: [] do
                resource 'schedule', only: [ :show, :edit, :update ]
            end
        end
    end
    get  '/appointments/:appointment_uuid', to: 'appointments#show', as: 'appointment'
    resources 'users', only: [ :new, :create ]
    post 'logout', to: 'users#logout'
    post '/appointments/:appointment_id/complete', to: 'appointments#complete'
    root to: "home#index"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
