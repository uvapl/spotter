class LiveController < ApplicationController
    before_action do
        redirect_to :root if not signed_in?
    end

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
