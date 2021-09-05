class AppointmentMailer < ApplicationMailer
    def confirmation_mail
        @appointment = params[:appointment]
        @user = @appointment.user
        mail to: @user.email, subject: 'Bevestiging afspraak programmeren'
    end
end
