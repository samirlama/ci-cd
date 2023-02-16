require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: 'sameer', email: 'samirlama509@gmail.com', address: 'samakhusi')
  }

  it "is valid with the attributes" do
    expect(subject).to be_valid
  end

  it 'is not valid with absence of any attribute' do
    subject.name = ''
    expect(subject).to be_invalid
  end

  it 'has unique email' do
    subject.email = "samirlama509@gmail.com"
    expect(subject).to be_valid
  end
end
