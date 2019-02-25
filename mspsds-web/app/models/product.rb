class Product < ApplicationRecord
  include Shared::Web::CountriesHelper
  include Documentable
  include Searchable
  include DateConcern
  include AttachmentConcern

  def get_date_key
    :date_placed_on_market
  end

  index_name [Rails.env, "products"].join("_")

  before_validation :trim_end_line
  validates :name, presence: true
  validates :product_type, presence: true
  validates :category, presence: true
  validates_length_of :description, maximum: 10000

  has_many_attached :documents

  has_many :investigation_products, dependent: :destroy
  has_many :investigations, through: :investigation_products

  has_many :corrective_actions, dependent: :destroy
  has_many :tests, dependent: :destroy

  has_one :source, as: :sourceable, dependent: :destroy

  def country_of_origin_for_display
    country_from_code(country_of_origin) || country_of_origin
  end

  def pretty_description
    "Product #{id}"
  end

private

  # Browsers treat end of line as one character when checking input length, but send it as \r\n, 2 characters
  # To keep max length consistent we need to reverse that
  def trim_end_line
    self.description.gsub!("\r\n", "\n") if self.description
  end
end

Product.import force: true if Rails.env.development? # for auto sync model with elastic search
