# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
    # appointment planning for students
    resources 'planner', only: [ :show ]

    # appointments overview for TA's
    resources 'live', only: [ :index ]
    resources 'appointments', param: 'uuid', only: [ :show ] do
        put 'complete'
        put 'claim'
    end

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

    # welcome and bumper page
    namespace 'home' do
        get 'index'
        get 'register'
    end

    # user registration
    resources 'users', only: [ :new, :create ]

    root to: "home#index"
end
