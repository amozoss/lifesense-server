class TimeRecord < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order('started_at DESC') }
  validates :project_id, presence: true
end
