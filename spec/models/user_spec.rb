require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it "should create a new instance of a user given valid attributes" do
    expect(@user).to be_valid
  end

  it "uses the user's email address if display_name is nil" do
    @no_name = build(:user, display_name: nil)
    @no_name.save
    expect(@no_name.display_name).to eq(@no_name.email)
  end

  it "is uses a default image if profile_pic_url is nil" do
    @no_pic = build(:user, profile_pic_url: nil)
    @no_pic.save
    expect(@no_pic.profile_pic_url).to eq("cd.png")
  end

  it "is invalid without an email address" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "is invalid without a spotify account" do
    expect(build(:user, spotify_id: nil)).not_to be_valid
  end
end
