# == Schema Information
#
# Table name: urls
#
#  id         :integer          not null, primary key
#  href       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("started"), not null
#  error      :text(65535)
#

require 'test_helper'
require 'vcr'


class UrlTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'validate presence' do
    url = Url.new
    assert !url.save
    assert url.errors[:href].include?("can't be blank")
  end

  test 'Indexing should be started by default' do
    url = urls(:example)
    assert url.started?
  end

  test 'should parse in the background' do
    VCR.use_cassette 'akshi' do
      assert_enqueued_jobs 1 do
        url = Url.create! href: 'https://akshi.com'
      end
    end
  end

  test 'parse!' do
    VCR.use_cassette 'akshi' do
      perform_enqueued_jobs do
        url = Url.create! href: 'https://akshi.com'
        assert_equal url.contents.length, 22
        assert_equal url.links.length, 65
        assert_performed_jobs 1
      end
    end
  end
end
