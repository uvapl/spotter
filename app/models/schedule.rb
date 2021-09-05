class Schedule < ApplicationRecord
    belongs_to :course

    serialize :slots, default: {}

    def slots
        # encapsulate data in a specialized object
        Slots.new super
    end
end

class Slots
    def initialize(slots)
        @slots = slots
    end

    def today
        day, slots = get Date.current.wday
        return day, slots.select{|hour,count| hour > Time.now.hour}
    end

    def tomorrow
        get Date.current.wday + 1
    end

    def monday
        get 1
    end

    def get(day)
        return day, (@slots[day] || {})
    end
end
