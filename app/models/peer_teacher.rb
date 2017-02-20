class PeerTeacher < ActiveRecord::Base
    has_many :officeHours
    validates_presence_of :netID
    validates_presence_of :name
    validates_presence_of :courselist
    validates_presence_of :timelist
end
