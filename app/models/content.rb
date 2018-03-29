# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  text       :string(255)      not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Content < ApplicationRecord
  belongs_to :url

  validates :url, presence: true
  validates :name, presence: true
  validates :text, presence: true
end
