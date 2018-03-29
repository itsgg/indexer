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

require 'nokogiri'
require 'open-uri'

class Url < ApplicationRecord
  validates :href, presence: true

  has_many :contents, dependent: :destroy
  has_many :links, dependent: :destroy

  enum status: [ :started, :completed, :failed ]

  after_create :parse_content

  default_scope { order(created_at: :desc) }

  def parse!
    # Remove old indexes
    self.contents.delete_all
    self.links.delete_all

    # Now parse
    doc = Nokogiri::HTML(open(self.href))

    # Create contents
    doc.css('h1', 'h2', 'h3', 'h4', 'h5').each do |header|
      # XXX: Force UTF-8 encoding. skipping invalid ones. Hack really, to completely handle all encodings,
      # needs tweak to the database, since it is just an tech assignment, this should be ok
      content = self.contents.new name: header.name, text: header.content.encode(Encoding.find('UTF-8'), { invalid: :replace, undef: :replace, replace: '' })
      unless content.save
        # Ignore parse errors and continue
        logger.info content.errors.full_messages
      end
    end
    # Create links
    doc.css('a').each do |hyperlink|
      link = self.links.new name: hyperlink.content.encode(Encoding.find('UTF-8'), { invalid: :replace, undef: :replace, replace: '' }), href: hyperlink['href']
      unless link.save
        # Ignore parse errors and continue
        logger.info link.errors.full_messages
      end
    end
    self.completed!
  rescue => e
    self.update_column :error, e
    self.failed!
    logger.error e
  end

  private
  def parse_content
    IndexerJob.perform_later self.id
  end
end
