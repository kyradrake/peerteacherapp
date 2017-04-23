# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#peerTeachers = [{:netID => 'jsmith', :name => 'John Smith', :courselist => '121,221', :timelist => '100,101'},
#    	        {:netID => 'cooper', :name => 'Alice Cooper', :courselist => '312', :timelist => '102,103'},
#    	        {:netID => 'cr7', :name => 'Cristiano Ronaldo', :courselist => '222,315', :timelist => '104'},
#  	           ]
  	           
#officeHours = [{:timeID => 100, :netID => 'jsmith', :dow => 'TUE', :sHour => 10, :sMin => 30, :eHour => 12, :eMin => 30},
#               {:timeID => 101, :netID => 'jsmith', :dow => 'THU', :sHour => 10, :sMin => 30, :eHour => 12, :eMin => 30},
#               {:timeID => 102, :netID => 'cooper', :dow => 'MON', :sHour => 1, :sMin => 00, :eHour => 2, :eMin => 30},
#               {:timeID => 103, :netID => 'cooper', :dow => 'WED', :sHour => 2, :sMin => 15, :eHour => 3, :eMin => 45},
#               {:timeID => 104, :netID => 'cr7', :dow => 'FRI', :sHour => 9, :sMin => 50, :eHour => 1, :eMin => 50},
#        ]  
#user = [{email: 'joelescobar@tamu.edu', first_name: 'Joel', last_name: 'Escobar', password: 'user' },
#        {email: 'kyradrake@tamu.edu', first_name: 'Kyra', last_name: 'Drake', password: 'pass' }, 
#        {email: 'testing@tamu.edu', first_name: 'John', last_name: 'Hancok', password: 'admin', admin: true } ]           
        

#user.each do |u|
#    User.create!( u )
#end

Administrator.create( 
        :first_name     => "Joel",
        :last_name      => "Escobar",
        :user_attributes => {
            :email          => "Joelescobar@tamu.edu",
            :password       => "admin",
            :password_confirmation => "admin",
        }
    )

Administrator.create(
        :first_name     => "John",
        :last_name      => "Pound",
        :user_attributes => {
            :email      => "Joelescobar01@tamu.edu",
            :password   => "testing",
            :password_confirmation => "testing",
        }
    )

PeerTeacherLogin.create(
        :first_name     => "Bob",
        :last_name      => "Dylan",
        :user_attributes => {
            :email          => "Bobdylan@tamu.edu",
            :password       => "user",
            :password_confirmation => "user", 
        }
    )

#peerTeachers.each do |pt|
#  PeerTeacher.create!(pt)
#end

#officeHours.each do |time|
#  OfficeHour.create!(time)
#end