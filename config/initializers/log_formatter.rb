class Logger::SimpleFormatter  #overrride default to show severity of message 
    def call( severtiy, time, progname, msg )
        "[#{severity}] #{msg}\n"
    end
end