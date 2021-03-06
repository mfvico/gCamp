class Task < ActiveRecord::Base
  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
  validates :task, presence: true
  validate :not_past_date, on: :create

  belongs_to :project
  has_many :comments, dependent: :destroy

  def not_past_date
    if due_date
      if self.due_date < Date.today
        errors.add(:due_date, 'cannot be in the past')
      end
    end
  end
end
