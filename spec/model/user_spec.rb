require 'rails_helper'

describe User, type: :model do
  subject { User.new(name: 'Test User', password: 'password') }

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Password should be present' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'Password should be at least 6 characters long' do
    subject.password = '123'
    expect(subject).to_not be_valid
  end
end
