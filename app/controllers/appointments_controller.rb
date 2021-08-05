class AppointmentsController < ApplicationController
    def create
        course = Course.find params[:course_id]
        date = Time.at(filter_params[:slot].to_i).to_datetime

        a = Appointment.create!  user: current_user,
                                 course: course,
                                 slot: date.min / (60/4) + 1,
                                 hour: date.hour,
                                 day: date.wday,
                                 week: date.cweek,
                                 year: date.year,
                                 subject: filter_params[:subject]
        redirect_to :root
    end
    
    def filter_params
        params.require(:appointment).permit(:course, :slot, :hour, :day, :week, :year, :subject)
    end
end
