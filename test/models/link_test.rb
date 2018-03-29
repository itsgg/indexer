# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  href       :string(255)      not null
#  url_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LinkTest < ActiveSupport::TestCase

  test 'validate presence' do
    link = Link.new
    assert !link.save
    assert link.errors[:href].include?("can't be blank")
    assert link.errors[:url].include?("can't be blank")
  end

end
