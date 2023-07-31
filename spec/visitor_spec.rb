require './lib/visitor'

RSpec.describe Visitor do
  describe "#initialize" do
    it "exists" do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1).to be_a Visitor
    end

    it "has a name, height and spending money" do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1.name).to eq("Bruce")
      expect(visitor1.height).to eq(54)
      expect(visitor1.spending_money).to eq("$10")
    end

    it "has preferences that start empty" do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1.preferences).to be_empty
    end
  end

  describe "#add_preference" do
    it "adds a preference" do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      visitor1.add_preference(:gentle)
      visitor1.add_preference(:thrilling)

      expect(visitor1.preferences).to eq([:gentle, :thrilling])
    end
  end
end