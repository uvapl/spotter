class LiveController < ApplicationController
    before_action :require_assistant

    def index
        # @appointments = Appointment.all_remaining_for_today.grouped_by_start_time
        @appointments = Appointment.all_remaining_for_today.ordered_by_start_time
    end
end
