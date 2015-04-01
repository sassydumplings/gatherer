class Task < ActiveRecord::Base

  belongs_to :project

  def mark_completed(date = nil)
    self.completed_at = ( date ||  Time.current)
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_towards_velocity
    if part_of_velocity?
     return  size
    else
     return 0
    end
  end

end