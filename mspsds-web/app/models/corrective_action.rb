class CorrectiveAction < ApplicationRecord
  include DateConcern

  attribute :related_file

  belongs_to :investigation
  belongs_to :business, optional: true
  belongs_to :product

  has_many_attached :documents

  def get_date_key
    :date_decided
  end

  before_validation :trim_end_line
  validates :summary, presence: { message: "Enter a summary of the corrective action" }
  validates :date_decided, presence: { message: "Enter the date the corrective action was decided" }
  validate :date_decided_cannot_be_in_the_future
  validates :legislation, presence: { message: "Select the legislation relevant to the corrective action" }
  validates :related_file, presence: { message: "Select whether you want to upload a related file" }
  validate :related_file_attachment_validation

  validates_length_of :summary, maximum: 10000
  validates_length_of :details, maximum: 50000

  after_create :create_audit_activity

  def date_decided_cannot_be_in_the_future
    if date_decided.present? && date_decided > Time.zone.today
      errors.add(:date_decided, "The date of corrective action decision can not be in the future")
    end
  end

  def create_audit_activity
    AuditActivity::CorrectiveAction::Add.from(self)
  end

  def related_file_attachment_validation
    if related_file == "Yes" && documents.attachments.empty?
      errors.add(:base, :file_missing, message: "Provide a related file or select no")
    end
  end

private

  # Browsers treat end of line as one character when checking input length, but send it as \r\n, 2 characters
  # To keep max length consistent we need to reverse that
  def trim_end_line
    self.summary.gsub!("\r\n", "\n") if self.summary
    self.details.gsub!("\r\n", "\n") if self.details
  end
end
