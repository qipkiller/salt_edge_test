require 'rails_helper'

RSpec.describe Connection, type: :model do
  let(:user) { create(:user, customer_id: Faker::Number.number(digits: 10)) }
  let(:remote_id) { Faker::Number.number(digits: 10) }
  let(:connection) { create(:connection, user: user) }
  subject do
    described_class.new(
      user: user,
      remote_id: remote_id
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
    expect(subject.created_at).to be_nil
  end


  it 'is invalid with invalid remote_id' do
    subject.remote_id = nil

    expect(subject).not_to be_valid
    expect(subject.created_at).to be_nil
  end


  it 'is active after create' do 
    expect(connection.arhived).to eq(false)
  end

  it 'is arhived after use method' do 
    expect(connection.arhived).to eq(false)
    connection.arhive
    expect(connection.arhived).to eq(true)
  end

end
