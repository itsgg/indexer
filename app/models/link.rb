# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  href       :string           not null
#  url_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ApplicationRecord
  belongs_to :url

  validates :url, presence: true
  validates :name, presence: true
  validates :href, presence: true
end
