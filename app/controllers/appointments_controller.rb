class AppointmentsController < ApplicationController
    before_action :require_user

    def complete
        head :no_content

        appointment = Appointment.find params[:appointment_id]
        appointment.status = 2
        appointment.save!
    end

    def create
        course = Course.find params[:course_id]
        date = Time.at(filter_params[:slot].to_i).to_datetime

        # catch nonsensical times
        if filter_params[:slot].to_i < 1
            raise ActionController::RoutingError.new('Invalid Time')
        end

        a = Appointment.create!  user: current_user,
                                 course: course,
                                 slot: date.min / (60/4) + 1,
                                 hour: date.hour,
                                 day: date.wday,
                                 week: date.cweek,
                                 year: date.year,
                                 subject: filter_params[:subject],
                                 location: filter_params[:location],
                                 uuid: Digest::UUID.uuid_v4

        AppointmentMailer.with(appointment: a).confirmation_mail.deliver_later
    end
    
    def filter_params
        params.require(:appointment).permit(:slot, :subject, :location)
    end
end
