class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :course
    belongs_to :helper, class_name: 'User', optional: true
    delegate :name, to: :helper, prefix: true

    # see https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
    enum status: { active: 0, cancelled: 1, done: 2 }

    after_create_commit  { broadcast_prepend_to 'appointments' }
    after_save do
        case status_previous_change
        in [*, 'cancelled']
            broadcast_remove_to 'appointments'
        in ['active', 'done']
            broadcast_replace_to 'appointments'
        else
        end
    end

    scope :all_remaining_for_today, -> do
        date = Date.today
        where(day: date.wday, week: date.cweek, year: date.year).
        where(status: [:active]).
        where("hour >= ?", DateTime.now.hour-1)
    end

    scope :grouped_by_start_time, -> do
        group_by(&:starting_time).
        sort {|a,b| a[0] <=> b[0]}
    end
    
    scope :ordered_by_start_time, -> do
        sort_by { |a| a.starting_time }
    end

    def starting_time
        # exactly the library function we need
        CommercialTime.create(year, week, day, hour, (slot-1).to_f/course.slots*60)
    end

    def formatted_starting_time(format=:datetime)
        case format
        when :time
            starting_time.strftime '%-H:%M'
        when :datetime
            starting_time.strftime '%A %-d %B %Y, %-H:%M'
        end
    end

    def self.booked_per_slot(year, week, day)
        where(year: year, week: week, day: day, status: :active).group(:hour, :slot).count
    end

    def to_param
        uuid
    end
end
