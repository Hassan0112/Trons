require 'rails_helper'

RSpec.describe UserAdd, type: :model do
  describe "associations" do
    it "belongs to a user" do
      expect(UserAdd.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "validates presence of city" do
      expect(described_class.validators_on(:city).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of registered_in" do
      expect(described_class.validators_on(:registered_in).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of exterior_color" do
      expect(described_class.validators_on(:exterior_color).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of mileage" do
      expect(described_class.validators_on(:mileage).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of price" do
      expect(described_class.validators_on(:price).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of add_description" do
      expect(described_class.validators_on(:add_description).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end

    it "validates presence of mobile_number" do
      expect(described_class.validators_on(:mobile_number).map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
    end
  end
end
