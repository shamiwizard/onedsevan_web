require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '.age' do
    it 'return user age' do
      expect(user.age).to eq(Date.current.year - user.date_of_birth.year)
    end
  end

  describe '.full_name' do
    it 'return user full name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
