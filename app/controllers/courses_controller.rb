class CoursesController < ApplicationController
	before_action :require_admin

	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
	end

	def create
		course = Course.create! course_params
		redirect_to edit_course_path(course)
	end

	def edit
		@course = Course.find params[:id]

	end

	def update
		course = Course.find params[:id]
		course.update(course_params)
		redirect_to edit_course_path(course)
	end

	def bulk
		course = Course.find params[:course_id]
		slots = {}

		for day in 0..6 do
			day_slots = {}
			for hour in 9..17 do
				amount = params[day.to_s + "-" + hour.to_s].to_i
				day_slots[hour] = amount unless amount == 0
			end
			slots[day] = day_slots
		end
		
		for week in params[:start].to_i..params[:end].to_i do
			schedule = Schedule.find_or_create_by(course: course, week: week, year: Date.current.year)
			schedule.slots = slots
			schedule.save!
		end

		redirect_to edit_course_path(course)
	end

	def course_params
		params.require(:course).permit(:name, :slots, :minimum, :location)
	end
end
