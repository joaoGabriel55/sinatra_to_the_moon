# frozen_string_literal: true

RSpec.describe SinatraToTheMoon::Project do
  describe ".validate_name!" do
    it "accepts safe project names" do
      expect(described_class.validate_name!("moon_api-2")).to eq("moon_api-2")
    end

    it "rejects paths and constants" do
      expect { described_class.validate_name!("../Moon") }
        .to raise_error(SinatraToTheMoon::InvalidProjectNameError)
    end
  end

  describe ".constant_name" do
    it "converts project names into Ruby constants" do
      expect(described_class.constant_name("moon-api")).to eq("MoonApi")
    end
  end
end
