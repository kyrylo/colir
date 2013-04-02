require_relative 'helper'

describe Colir do
  describe "some shortcuts" do
    it "has a shortcut for red colour" do
      Colir.red.hexa.should == 0xff000000
    end

    it "has a shortcut for blanched almond colour" do
      Colir.blanched_almond.hexa.should == 0xffebcd00
    end

    it "has a shortcut royal blue colour" do
      Colir.royal_blue.hexa.should == 0x4169e100
    end

    it "can set the colour's transparency" do
      Colir.snow(0.5).transparency.should == 0.5
    end
  end

  describe "#intialize" do
    it "accepts transparency parameter" do
      Colir.new(0x012345, 0.77).transparency.should == 0.77
    end
  end

  describe "#hex" do
    it "returns the hex code of a colour (without transparency)" do
      Colir.new(0x123456, 0.1).hex.should == 0x123456
    end
  end

  describe "#hexa" do
    it "returns the hex code of a colour (with transparency)" do
      Colir.new(0x123456, 0.1).hexa.should == 0x1234560a
    end
  end

  describe "#transparency" do
    it "defaults to no transparency" do
      Colir.new(0x123456).transparency.should == 0.0
    end

    it "can be set to a specific value" do
      Colir.new(0x123456, 0.98).transparency.should == 0.98
    end

    it "must lie within the range of 0 to 1 (min)" do
      should.raise(RangeError) {
        Colir.new(0x123456, -0.01)
      }.message.should =~ /out of allowed transparency values \(0-1\)/
    end

    it "must lie within the range of 0 to 1 (max)" do
      should.raise(RangeError) {
        Colir.new(0x123456, 1.01)
      }.message.should =~ /out of allowed transparency values \(0-1\)/
    end
  end

  describe "#transparent!" do
    it "changes the object's transparency to full transparency" do
      colir = Colir.new(0x123456, 0.3).transparent!
      colir.transparency.should == 1.0
    end
  end

  describe "#opaque!" do
    it "changes the object's transparency to no transparency" do
      colir = Colir.new(0x123456, 0.3).opaque!
      colir.transparency.should == 0.0
    end
  end

  describe "#shade" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "returns 0 colour shade for a colour without shades" do
      @colir.shade.should == 0
    end

    it "returns -1 for a darker colour" do
      @colir.darken.shade.should == -1
    end

    it "returns 1 for a lighter colour" do
      @colir.lighten.shade.should == 1
    end
  end

  #describe "#reset_shade" do
    #it "resets the colour to its initial state" do
    #end
  #end

  #describe "#darker" do
    #it "doesn't modify the base colour" do
    #end

    #it "returns a new colour, but a little bit darker" do
    #end
  #end

  #describe "#lighter" do
    #it "doesn't modify the base colour" do
    #end

    #it "returns a new colour, but a little bit lighter" do
    #end
  #end

  describe "#darken" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "modifies the base colour" do
      old_colour = @colir.hex
      @colir.darken
      @colir.hex.should.not == old_colour
    end

    it "makes the current colour darker" do
      @colir.darken
      @colir.hex.should == 0x0e2843
    end

    it "makes the current colour even more dark" do
      3.times { @colir.darken }
      @colir.hex.should == 0x061422
    end

    describe "lower limit" do
      before do
        5.times { @colir.darken }
      end

      it "stops darkening the current colour when meets the limit of shades" do
        old_hex = @colir.hex
        @colir.darken.hex.should == old_hex
      end

      it "finally reaches black colour" do
        @colir.hex.should == 0x000000
      end
    end
  end

  describe "#lighten" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "modifies the base colour" do
      old_colour = @colir.hex
      @colir.lighten
      @colir.hex.should.not == old_colour
    end

    it "makes the current colour lighter" do
      @colir.lighten
      @colir.hex.should == 0x205b97
    end

    it "makes the current colour even more light" do
      3.times { @colir.lighten }
      @colir.hex.should == 0x78ade2
    end

    describe "upper limit" do
      before do
        5.times { @colir.lighten }
      end

      it "stops lightening the current colour when meets the limit of shades" do
        old_hex = @colir.hex
        @colir.lighten.hex.should == old_hex
      end

      it "finally reaches white colour" do
        @colir.hex.should == 0xffffff
      end
    end
  end

  #describe "shading" do
    #it "can be properly configured step by step" do
      #base_color = 0x123456
      #colir = Colir.new(base_color)
      #colir.darken
      #colir.darken
      #colir.lighten
      #colir.lighten
      #colir.lighten
      #colir.lighten
      #colir.darken
      #colir.darken
      #colir.lighten
      #colir.darken
      #colir.hex.should == base_color
    #end
  #end
end