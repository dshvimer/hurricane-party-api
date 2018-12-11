class Conversation < ApplicationRecord
  has_many :messages

  validates :participants,
            presence: true,
            uniqueness: { case_sensitive: true }

  def members
    usernames = self.participants.split(':')
    User.where(username: usernames)
  end

  def set_members(*members)
    self.participants = members.map(&:username).sort.join(':')
  end

  def self.between(*members)
    find_by(participants: members.map(&:username).sort.join(':'))
  end
end
