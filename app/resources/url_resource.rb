class UrlResource < JSONAPI::Resource
  attributes :href, :status, :error

  has_many :contents
  has_many :links

  def self.creatable_fields(context)
    [:href]
  end

  def self.updatable_fields(context)
    [:href]
  end

  filter :href, apply: ->(records, value, _options) {
    records.where('urls.href = ?', value)
  }
end
