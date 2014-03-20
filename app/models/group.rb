class Group < ActiveRecord::Base
  has_many :pupil_groups
  has_many :pupils, through: :pupil_groups
end
