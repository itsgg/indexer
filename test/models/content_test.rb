# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  text       :string           not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ContentTest < ActiveSupport::TestCase

  test 'validate presence' do
    content = Content.new
    assert !content.save
    assert content.errors[:name].include?("can't be blank")
    assert content.errors[:text].include?("can't be blank")
    assert content.errors[:url].include?("can't be blank")
  end

end
