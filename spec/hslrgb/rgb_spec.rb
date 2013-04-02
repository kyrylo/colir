require_relative '../helper'

describe Colir::HSLRGB::RGB do

  describe "::valid_rgb?" do
    describe "parameters" do
      it "returns false if it's too long" do
        Colir::HSLRGB::RGB.valid_rgb?([255, 255, 255, 255]).should.be.equal false
      end

      it "returns false if it's too short" do
        Colir::HSLRGB::RGB.valid_rgb?([255, 255]).should.be.equal false
      end

      describe "R" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 255, 255]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::RGB.valid_rgb?([-1, 0, 0]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::RGB.valid_rgb?([256, 255, 255]).should.be.equal false
        end

        it "returns false if it's not integer" do
          Colir::HSLRGB::RGB.valid_rgb?([254.1, 255, 255]).should.be.equal false
          Colir::HSLRGB::RGB.valid_rgb?(
            [Rational(2541, 10), 255, 255]
          ).should.be.equal false
        end
      end

      describe "G" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 255, 255]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::RGB.valid_rgb?([0, -1, 0]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 256, 255]).should.be.equal false
        end

        it "returns false if it's not integer" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 254.1, 255]).should.be.equal false
          Colir::HSLRGB::RGB.valid_rgb?(
            [255, Rational(2541, 10), 255]
          ).should.be.equal false
        end
      end

      describe "B" do
        it "returns true if it's coverd by the range" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 255, 255]).should.be.equal true
        end

        it "returns false if it's too low" do
          Colir::HSLRGB::RGB.valid_rgb?([0, 0, -1]).should.be.equal false
        end

        it "returns false if it's too high" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 255, 256]).should.be.equal false
        end

        it "returns false if it's not integer" do
          Colir::HSLRGB::RGB.valid_rgb?([255, 255, 254.1]).should.be.equal false
          Colir::HSLRGB::RGB.valid_rgb?(
            [255, 255, Rational(2541, 10)]
          ).should.be.equal false
        end
      end
    end
  end

end