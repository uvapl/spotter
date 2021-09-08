# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
    resources 'users', only: [ :new, :create ]
    resources 'planner', only: [ :show ]

    get  '/appointments/:appointment_uuid', to: 'appointments#show', as: 'appointment'
    post '/appointments/:appointment_id/complete', to: 'appointments#complete'

    # appointments overview
    resources 'live', only: [ :index ]

    # change hours etc
    resources 'courses', only: [ :index, :new, :create, :edit, :update ] do
        resources 'appointments', only: [ :create ]
        post 'bulk', to: 'courses#bulk'
        resources 'year', param: 'number', only: [] do
            resources 'week', param: 'number', only: [] do
                resource 'schedule', only: [ :show, :edit, :update ]
            end
        end
    end

    post 'logout', to: 'users#logout'

    namespace 'home' do
        get 'index'
        get 'register'
    end

    root to: "home#index"
end
