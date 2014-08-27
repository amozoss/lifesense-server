class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_records, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :name, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def total_time
    time_records = TimeRecord.where("project_id = ?", id)
    total = 0
    time_records.each do |tr|
      if !tr.started_at.nil? and !tr.ended_at.nil?
        total += tr.ended_at - tr.started_at
      elsif !tr.started_at.nil? and tr.ended_at.nil?
        total += Time.now - tr.started_at
      end
    end
    return total
  end

  def stopped?
    time_records = TimeRecord.where("project_id = ?", id)
    stopped = true
    time_records.each do |tr|
      if tr.ended_at.nil?
        stopped = false
      end
    end
    return stopped
  end


end
