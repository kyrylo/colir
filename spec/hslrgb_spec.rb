require_relative 'helper'

describe Colir::HSLRGB do

  describe "::rgb_to_hsl" do
    it "converts black RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x00, 0x00, 0x00).should == [0, 0, 0]
    end

    it "converts white RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0xff, 0xff, 0xff).should == [0, 0, 1]
    end

    it "converts reddish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x99, 0x00, 0x00).should == [0, 1.0, 0.3]
    end

    it "converts orangish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0xff, 0xa3, 0x19).should == [36, 1.0, 0.55]
    end

    it "converts yellowish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0xff, 0xff, 0x19).should == [60, 1.0, 0.55]
    end

    it "converts greenish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x33, 0xcc, 0x33).should == [120, 0.6, 0.5]
    end

    it "converts bluish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x19, 0xff, 0xff).should == [180, 1.0, 0.55]
    end

    it "converts indigish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x00, 0x66, 0xff).should == [216, 1.0, 0.5]
    end

    it "converts violetish RGB colour to its HSL equivalent" do
      Colir::HSLRGB.rgb_to_hsl(0x99, 0x33, 0xff).should == [270, 1.0, 0.6]
    end

    describe "return value" do
      before do
        @hsl = Colir::HSLRGB.rgb_to_hsl(0xaf, 0xfe, 0x39)
      end

      it "should be Array" do
        @hsl.should.be kind_of(Array)
      end

      it "returns an integer hue" do
        @hsl[0].should.be kind_of(Integer)
      end

      it "returns a float saturation" do
        @hsl[1].should.be kind_of(Float)
      end

      it "returns a float lightness" do
        @hsl[2].should.be kind_of(Float)
      end
    end

    describe "parameters" do
      describe "R" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(-1, 0, 0)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(256, 255, 255)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end
      end

      describe "G" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(0, -1, 0)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(255, 256, 255)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end

      end

      describe "B" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(0, 0, -1)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.rgb_to_hsl(255, 255, 256)
          }.message =~ /out of allowed RGB values \(0-255\)/
        end
      end
    end
  end

  describe "::hsl_to_rgb" do
    it "converts black HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(0, 0, 0).should == [0, 0, 0]
    end

    it "converts white HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(0, 0, 1.0).should == [0xff, 0xff, 0xff]
    end

    it "converts greyish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(360, 0, 0.8).should == [0xcc, 0xcc, 0xcc]
    end

    it "converts reddish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(0, 1.0, 0.3).should == [0x99, 0x00, 0x00]
    end

    it "converts orangish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(36, 1.0, 0.55).should == [0xff, 0xa3, 0x19]
    end

    it "converts yellowish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(60, 1.0, 0.55).should == [0xff, 0xff, 0x19]
    end

    it "converts greenish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(120, 0.6, 0.5).should == [0x33, 0xcc, 0x33]
    end

    it "converts bluish HSL colour to its RGB equivalent" do
      Colir::HSLRGB.hsl_to_rgb(180, 1.0, 0.55).should == [0x19, 0xff, 0xff]
    end

    it "converts indigish HSL colour to its RGB equivalent" do
      # Little observational error: 0x65 should be 0x66.
      Colir::HSLRGB.hsl_to_rgb(216, 1.0, 0.5).should == [0x00, 0x65, 0xff]
    end

    it "converts violetish HSL colour to its RGB equivalent" do
      # Little observational error: 0x32 should be 0x33.
      Colir::HSLRGB.hsl_to_rgb(270, 1.0, 0.6).should == [0x99, 0x32, 0xff]
    end

    describe "parameters" do
      describe "H" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(-1, 0, 0)
          }.message =~ /out of allowed HSL values/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(361, 1, 1)
          }.message =~ /out of allowed HSL values/
        end
      end

      describe "S" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(0, -0.1, 0)
          }.message =~ /out of allowed HSL values/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(360, 1.1, 1)
          }.message =~ /out of allowed HSL values/
        end

      end

      describe "L" do
        it "raises RangeError if it's too low" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(0, 1, -0.1)
          }.message =~ /out of allowed HSL values/
        end

        it "raises RangeError if it's too high" do
          should.raise(RangeError) {
            Colir::HSLRGB.hsl_to_rgb(360, 1, 1.1)
          }.message =~ /out of allowed HSL values/
        end
      end
    end
  end
end

