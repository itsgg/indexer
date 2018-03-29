# == Schema Information
#
# Table name: urls
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UrlTest < ActiveSupport::TestCase

  test 'validate presence' do
    url = Url.new
    assert !url.save
    assert url.errors[:name].include?("can't be blank")
  end
end
