class PeerTeacher < ActiveRecord::Base
    has_many :office_hours
    validates_presence_of :netID
    validates_presence_of :name
    validates_presence_of :courselist
    validates_presence_of :timelist
end
