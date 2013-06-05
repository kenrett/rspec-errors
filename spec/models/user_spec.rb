require 'spec_helper'

describe User do

  it "should have an email address" do
    user = User.create(password: '1234')
    expect(user.email).to be_nil
  end

  it "should have a password" do
    user = User.create(email: 'nil@example.com')
    expect(user.password).to be_nil
  end

  it "should have a unique password" do
    expect { should validate_uniqueness_of(:email) }
  end

  # it "should have a secure password" do
    
  # end
end
