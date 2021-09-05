class LiveController < ApplicationController
    before_action :require_admin

    def index
        date = Date.today
        @appointments = Appointment.where(
            day: date.wday,
            week: date.cweek,
            year: date.year,
            status: 0
        ).order(:hour, :slot)
    end
end
