class AddMinutes
    def add_minutes(time_string, minutes)
        temp_arr = time_string.split(" ")
        hrs_mins_array = temp_arr[0].split(":").map{ |item| item.to_i}
        am_pm = temp_arr[1]

        hrs_mins_to_add_array = hours_mins_to_add(minutes)
        hours,mins,am_pm = calculate_new_time(hrs_mins_array, hrs_mins_to_add_array, am_pm)

        return "#{hours}:#{mins.to_s.rjust(2,"0")} #{am_pm}"
    end

    # Had a hard time finding an appropriate name for this
    def minute_boundary_helper(hours,minutes)
        if minutes > 59
            hours += minutes / 60
            minutes = minutes % 60
        elsif minutes < 0
            hours += (minutes / 60)
            minutes = minutes % 60
        end 

        [hours,minutes]
    end

    def calculate_new_time(time_array, add_time_array, am_pm_flag)
        is_noon_or_midnight = time_array[0] % 12 == 0 
        
        # convert to 24hr format to make it easier to calc am/pm switch
        if !is_noon_or_midnight
            hours = time_array[0] + 12
        else
            hours = time_array[0]
        end

        minutes = time_array[1] + add_time_array[1]
        hours += add_time_array[0]

        hours,minutes = minute_boundary_helper(hours,minutes)
        hours_24hr_diff = hours % 24

        hours -= 12 if hours_24hr_diff > 12  
        hours = 12 if hours_24hr_diff == 0
        hours = hours % 24 if hours > 24

        if am_pm_flag == "PM"   
            am_pm_flag = "AM" if hours_24hr_diff < 12
        else
            am_pm_flag = "PM" if hours_24hr_diff < 12
        end

        return [hours,minutes,am_pm_flag]
    end

    def hours_mins_to_add(minutes)
        hours_to_add = minutes / 60 unless minutes < 0
        hours_to_add = minutes < 0 ? (-1 * minutes) / 60 : minutes / 60

        if minutes < 0
            # I want to do the math with positive integers
            hours_to_subtract = -((-1 * minutes) / 60)
            mins_to_subtract = -((-1 * minutes) + hours_to_subtract * 60) if hours_to_subtract != 0
            mins_to_subtract = minutes if hours_to_subtract == 0
            [hours_to_subtract,mins_to_subtract]
        else
            hours_to_add = minutes / 60
            mins_to_add =  minutes - hours_to_add * 60 if hours_to_add != 0
            mins_to_add = minutes if hours_to_add == 0
            [hours_to_add,mins_to_add]
        end
    end
end