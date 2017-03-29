module PeerTeacherHelper
    def beautify_time(time)
      sHour=""
	    sMin=""
	    sTOD=""
	    eHour=""
	    eMin=""
	    eTOD=""
	    
	    if time.sHour>12
	      sHour=time.sHour-12
	      sTOD="pm"
	    else
	      sHour=time.sHour
	      if time.sHour==12
		        sTOD="pm"
		      else
		        sTOD="am"
		      end
	    end
	    
	    if time.sMin==0
	      sMin="00"
	    else 
	      sMin=time.sMin
	    end
	    
	    if time.eHour>12
	      eHour=time.eHour-12
	      eTOD="pm"
	    else
	      eHour=time.eHour
	      if time.eHour==12
		        eTOD="pm"
		      else
		        eTOD="am"
		      end
	    end
	    
	    if time.eMin==0
	      eMin="00"
	    else 
	      eMin=time.eMin
	    end
	    
	    timeDetails = Array.new
	    timeDetails.push(sHour)
	    timeDetails.push(sMin)
	    timeDetails.push(sTOD)
	    timeDetails.push(eHour)
	    timeDetails.push(eMin)
	    timeDetails.push(eTOD)
	    
	    return timeDetails
    end
    
    def format_message(origMsg)
		message = Array.new
    	message[0] = origMsg
    	i = 0
    	while (message[i].size > 21)
        	message[i+1] = message[i][22..-1]
        	message[i] = message[i][0..21] + "\n"
        	i += 1
    	end	
    	return message
    end
end
