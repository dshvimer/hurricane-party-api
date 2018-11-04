require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username)}
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
  end
end
