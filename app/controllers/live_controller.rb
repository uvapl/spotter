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
        group_by(&:starting_time).
        sort {|a,b| a[0] <=> b[0]}
    end
end
