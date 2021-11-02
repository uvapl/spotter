class CommercialTime
    def self.create(year, week, day, hour, minutes)
        DateTime.commercial(
                    year, week, day, hour, minutes, 0, DateTime.now.offset)
    end
end
