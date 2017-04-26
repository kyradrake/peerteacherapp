class OfficeHoursController < ApplicationController
  
  def update
    #render plain: params[:office_hour][:deleted].inspect
    
    @no_deletes = true
    @office_hours = OfficeHour.all
    
    if(params[:office_hour] != nil)
      @office_hours.where(email: params[:office_hour][:userEmail]).find_each do |time| 
        if(params[:office_hour][:deleted] == time.timeID.to_s)
          @no_deletes = false
          time.update(change: "Delete")
          canceledDate = params[:office_hour][:cancelMonth] + "/" + params[:office_hour][:cancelDay] + "/" + params[:office_hour][:cancelYear]
          Update.create(:timeID => time.timeID, :email => time.email, :dow => time.dow, :sHour => time.sHour, :sMin => time.sMin, :eHour => time.eHour, :eMin => time.eMin, :date => canceledDate, :action => "Delete", :msg => params[:office_hour][:reason], :approved => 1)
          ExampleMailer.api_email(params[:office_hour][:userEmail], true, time.timeID).deliver_later
          
          if(params[:office_hour][:reschedule] == "1")
            month = params[:office_hour][:rescheduleMonth].to_i
            day = params[:office_hour][:rescheduleDay].to_i
            year = params[:office_hour][:rescheduleYear].to_i
            weekDay = ""
            weekDayNum = Time.new(year, month, day).wday
            if(weekDayNum == 0)
              weekDay = "Su"
            elsif(weekDayNum == 1) 
              weekDay = "M"
            elsif(weekDayNum == 2) 
              weekDay = "T"
            elsif(weekDayNum == 3) 
              weekDay = "W"
            elsif(weekDayNum == 4) 
              weekDay = "R"
            elsif(weekDayNum == 5) 
              weekDay = "F"
            end
            rescheduleDate = params[:office_hour][:rescheduleMonth] + "/" + params[:office_hour][:rescheduleDay] + "/" + params[:office_hour][:rescheduleYear]
            #time.update(change: rescheduleDate)
            randID = rand(1000..100000)
            Update.create(:timeID => randID, :email => time.email, :dow => weekDay, :sHour => params[:office_hour][:sHour], :sMin => params[:office_hour][:sMin], :eHour => params[:office_hour][:eHour], :eMin => params[:office_hour][:eMin], :date => rescheduleDate, :action => "Add", :msg => params[:office_hour][:reason], :approved => 1)
            ExampleMailer.api_email(params[:office_hour][:userEmail], true, randID).deliver_later
          end
        end
      end
      if(params[:office_hour][:reschedule] == "1" && @no_deletes == true)
          month = params[:office_hour][:rescheduleMonth].to_i
          day = params[:office_hour][:rescheduleDay].to_i
          year = params[:office_hour][:rescheduleYear].to_i
          weekDay = ""
          weekDayNum = Time.new(year, month, day).wday
          if(weekDayNum == 0)
            weekDay = "Su"
          elsif(weekDayNum == 1) 
            weekDay = "M"
          elsif(weekDayNum == 2) 
            weekDay = "T"
          elsif(weekDayNum == 3) 
            weekDay = "W"
          elsif(weekDayNum == 4) 
            weekDay = "R"
          elsif(weekDayNum == 5) 
            weekDay = "F"
          end
          rescheduleDate = params[:office_hour][:rescheduleMonth] + "/" + params[:office_hour][:rescheduleDay] + "/" + params[:office_hour][:rescheduleYear]
          randID = rand(1000..100000)
          Update.create(:timeID => randID, :email => params[:office_hour][:userEmail], :dow => weekDay, :sHour => params[:office_hour][:sHour], :sMin => params[:office_hour][:sMin], :eHour => params[:office_hour][:eHour], :eMin => params[:office_hour][:eMin], :date => rescheduleDate, :action => "Add", :msg => params[:office_hour][:reason], :approved => 1)
          ExampleMailer.api_email(params[:office_hour][:userEmail], true, u.randID).deliver_later
      end
    end
    
    if(params[:office_hour_add] != nil)
        month = params[:office_hour_add][:rescheduleMonth].to_i
        day = params[:office_hour_add][:rescheduleDay].to_i
        year = params[:office_hour_add][:rescheduleYear].to_i
        weekDay = ""
        weekDayNum = Time.new(year, month, day).wday
        if(weekDayNum == 0)
          weekDay = "Su"
        elsif(weekDayNum == 1) 
          weekDay = "M"
        elsif(weekDayNum == 2) 
          weekDay = "T"
        elsif(weekDayNum == 3) 
          weekDay = "W"
        elsif(weekDayNum == 4) 
          weekDay = "R"
        elsif(weekDayNum == 5) 
          weekDay = "F"
        end
        rescheduleDate = params[:office_hour_add][:rescheduleMonth] + "/" + params[:office_hour_add][:rescheduleDay] + "/" + params[:office_hour_add][:rescheduleYear]
        randID = rand(1000..1000000)
        Update.create(:timeID => randID, :email => params[:office_hour_add][:userEmail], :dow => weekDay, :sHour => params[:office_hour_add][:sHour], :sMin => params[:office_hour_add][:sMin], :eHour => params[:office_hour_add][:eHour], :eMin => params[:office_hour_add][:eMin], :date => rescheduleDate, :action => "Add", :msg => params[:office_hour_add][:reason], :approved => 1)
        ExampleMailer.api_email(params[:office_hour_add][:userEmail], true, randID).deliver_later
    end
    redirect_to login_hub_index_path
  end
end
