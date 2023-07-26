require 'rails_helper'

describe Reservation, type: :model do
  let(:user) { User.create(name: 'Test User', password: 'password') }
  let(:hotel) { Hotel.create(name: 'Hotel California', description: 'A lovely place', duration: 5, price: 200.0) }

  subject { Reservation.new(user_id: user.id, hotel_id: hotel.id, reservation_date: Date.today, duration: 5) }

  before { subject.save }

  it 'User should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'Hotel should be present' do
    subject.hotel_id = nil
    expect(subject).to_not be_valid
  end

  it 'Reservation date should be present' do
    subject.reservation_date = nil
    expect(subject).to_not be_valid
  end

  it 'Duration should be greater than zero' do
    subject.duration = 0
    expect(subject).to_not be_valid
  end
end