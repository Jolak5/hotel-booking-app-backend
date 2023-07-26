require 'rails_helper'

describe Hotel, type: :model do
  subject { Hotel.new(name: 'Hotel California', description: 'A lovely place', duration: 5, price: 200.0) }

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Price should be greater than zero' do
    subject.price = 0
    expect(subject).to_not be_valid
  end

  it 'Duration should be greater than zero' do
    subject.duration = 0
    expect(subject).to_not be_valid
  end
end
