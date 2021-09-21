class FeedsController < ApplicationController
    skip_before_action :require_authentication

    def show
        course = Course.find params[:course_id]
        user = User.find_by! feed_token: params[:token]

        appointment_duration = 60 / course.slots
        cal = Icalendar::Calendar.new
        cal.append_custom_property("X-WR-CALNAME", "#{course.name} Appointments")
        cal.append_custom_property("REFRESH-INTERVAL;VALUE=DURATION","P1H")

        course.appointments.each do |ap|
            cal.event do |e|
              e.dtstart     = Icalendar::Values::DateTime.new(ap.starting_time)
              e.duration    = Icalendar::Values::Duration.new("#{appointment_duration}M")
              e.summary     = ap.user.name
              e.ip_class    = "PRIVATE"
            end
        end

        cal.publish
        render body: cal.to_ical, mime_type: Mime::Type.lookup("text/calendar")
    end
end
