require "rails_helper"

RSpec.describe "Movie Details" do
  describe "existance" do
    it "exists with attributes" do

    end
  end

  describe "methods" do
    it "converts integer to runtime" do
      runtime_in_minutes = 263
      expect(to_hours(runtime_in_minutes)).to eq("4 hours, 23 minutes")
    end
  end

end