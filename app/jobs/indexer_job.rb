class IndexerJob < ApplicationJob
  queue_as :default

  def perform(url_id)
    Url.find(url_id).parse!
  end
end
