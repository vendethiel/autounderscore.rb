require 'autounderscore'

RSpec.describe AutoUnderscore, "Basic usage" do
  context "Provides an _ method" do
    include AutoUnderscore
    it "Can be called" do
      expect(_).to_not be_nil
      expect(it).to_not be_nil
    end

    it "Allows built-in methods" do
      expect(_.to_s[:foo]).to eq "foo"
      expect(it.to_s[:foo]).to eq "foo"
      expect(_.to_a[1..3]).to eq [1,2,3]
      expect(_.to_i["123"]).to eq 123
    end

    it "Returns its argument" do
      expect(_[3]).to eq 3
      expect(it[3]).to eq 3
    end

    it "Calls a method" do
      expect((_ + 3)[2]).to eq 5
      expect((_ + 3)[2]).to eq 5
      expect((it + 3)[2]).to eq 5
    end

    it "Evaluates method arguments to find other nodes" do
      expect((_ + _)[2]).to eq 4
      expect((it + it)[2]).to eq 4
    end

    it "Restores the original argument" do
      expect((_ + 3 + _)[2]).to eq 7
    end

    it "Can take multiple parameters" do
      expect((_(0) + _(1))[1, 10]).to eq 11
    end

    it "Provides shorthands" do
      expect((_0 + _1)[1, 10]).to eq 11
    end

    it "Allows method stacking" do
      expect(it.split(" ").join("*")["foo bar"]).to eq "foo*bar"

      expr = ((_0.split(" ") + _1.split(" ")).join(_2))["a b", "c d", ","]
      expect(expr).to eq "a,b,c,d"
    end
  end
end

