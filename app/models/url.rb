# == Schema Information
#
# Table name: urls
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Url < ApplicationRecord
  validates :name, presence: true

  has_many :contents
  has_many :links
end
