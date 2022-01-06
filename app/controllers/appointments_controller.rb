class AppointmentsController < ApplicationController
    before_action :require_user
    before_action :require_assistant, only: [ :complete, :claim ]

    def show
        @appointment = Appointment.find_by_uuid params[:uuid]
    end

    def cancel
        appointment = Appointment.find_by_uuid params[:appointment_uuid]
        appointment.status = 1
        appointment.save!
        redirect_back fallback_location: '/'
    end

    def complete
        appointment = Appointment.find_by_uuid params[:appointment_uuid]
        appointment.status = 2
        appointment.save!
        redirect_back fallback_location: '/'
    end

    def claim
        appointment = Appointment.find_by uuid:params[:appointment_uuid], helper:nil
        if appointment.present? && appointment.update(helper: current_user)
            redirect_back fallback_location: '/', notice: "Yes, go ahead!"
        else
            redirect_back fallback_location: '/', alert: "Someone already claimed this!"
        end
    end

    def create
        course = Course.find params[:course_id]
        date = Time.at(filter_params[:slot].to_i).to_datetime

        # catch nonsensical times
        if filter_params[:slot].to_i < 1
            raise ActionController::RoutingError.new('Invalid Time')
        end

        slot = date.min / (60/4) + 1
        hour = date.hour
        day = date.wday
        week = date.cweek
        year = date.year

        # check if this choice is available, or find next slot
        best_match_hour, best_match_slot =
            course.first_available_slot_starting_from year, week, day, hour, slot

        # in case radio buttons are offered for the location,
        # user-entered location will be in the :other_location field
        location =
            filter_params[:location] == "Other" && params[:other_location] ||
            filter_params[:location]

        # anything's still available for chosen day?
        if best_match_hour
            @a = Appointment.create! user: current_user,
                                     course: course,
                                     slot: best_match_slot,
                                     hour: best_match_hour,
                                     day: day,
                                     week: week,
                                     year: year,
                                     subject: filter_params[:subject],
                                     location: location,
                                     uuid: Digest::UUID.uuid_v4

            AppointmentMailer.with(appointment: @a).confirmation_mail.deliver_later
            redirect_to @a, notice: "Your appointment was made!"
        else
            redirect_to planner_path(course),
                alert: "Unfortunately, timeslots are full for the day. Please select a new time below."
        end
    end

    def filter_params
        params.require(:appointment).permit(:slot, :subject, :location)
    end
end
