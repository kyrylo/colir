require_relative '../helper'

describe Colir::HSLRGB::HSL do

  describe "::valid_hsl?" do
    describe "parameters" do
      it "returns false if it's too long" do
        Colir::HSLRGB::HSL.valid_hsl?([0, 0, 0, 0]).should.be.equal false
      end

      it "returns false if it's too short" do
        Colir::HSLRGB::HSL.valid_hsl?([0, 0]).should.be.equal false
      end

      describe "H" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::HSL.valid_hsl?([0, 0, 0]).should.be.equal true
          Colir::HSLRGB::HSL.valid_hsl?([360, 0.9, 0.9]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::HSL.valid_hsl?([-1, 0, 0]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::HSL.valid_hsl?([361, 1, 1]).should.be.equal false
        end

        it "returns false if it's not integer" do
          Colir::HSLRGB::HSL.valid_hsl?([359.1, 0, 0]).should.be.equal false
          Colir::HSLRGB::HSL.valid_hsl?(
            [Rational(3591, 10), 0, 0]
          ).should.be.equal false
        end
      end

      describe "S" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::HSL.valid_hsl?([0, 0, 0]).should.be.equal true
          Colir::HSLRGB::HSL.valid_hsl?([360, 0.9, 0.9]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::HSL.valid_hsl?([0, -0.1, 0]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::HSL.valid_hsl?([360, 1.1, 1]).should.be.equal false
        end
      end

      describe "L" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::HSL.valid_hsl?([0, 0, 0]).should.be.equal true
          Colir::HSLRGB::HSL.valid_hsl?([360, 0.9, 0.9]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::HSL.valid_hsl?([0, 0, -0.1]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::HSL.valid_hsl?([360, 1, 1.1]).should.be.equal false
        end
      end
    end
  end

end