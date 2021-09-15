class LiveController < ApplicationController
    before_action :require_assistant

    def index
        date = Date.today
        @appointments = Appointment.where(
            day: date.wday,
            week: date.cweek,
            year: date.year
        ).
        where("hour >= ?", DateTime.now.hour-1).
        order(:hour, :slot).
        group_by &:starting_time
    end
end
