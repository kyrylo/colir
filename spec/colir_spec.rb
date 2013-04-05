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

    it "doesn't allow too low HEX number" do
      should.raise(RangeError) {
        Colir.new(-0x000001)
      }.message.should =~ /out of allowed RGB values/
    end

    it "doesn't allow too high HEX number" do
      should.raise(RangeError) {
        Colir.new(0x1000000)
      }.message.should =~ /out of allowed RGB values/
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

    it "returns a Float value" do
      Colir.new(0x123456).transparency.should.be kind_of(Float)
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

  describe "#reset_shade" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "resets the colour to its initial state" do
      before = @colir.shade
      3.times { @colir.darken }
      @colir.shade.should.not == before
      @colir.reset_shade
      @colir.shade.should == before
    end

    it "restores the hex number" do
      before = @colir.hex
      3.times { @colir.darken }
      @colir.hex.should.not == before
      @colir.reset_shade
      @colir.hex.should == before
    end
  end

  describe "#darker" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "returns a new object" do
      before_id = @colir.object_id
      after_id = @colir.darker.object_id
      after_id.should.not == before_id
    end

    it "doesn't modify the base colour" do
      before = @colir.hex
      @colir.darker
      @colir.hex.should == before
    end

    it "returns a new colour, but a little bit darker" do
      @colir.darker.shade.should == -1
    end
  end

  describe "#lighter" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "returns a new object" do
      before_id = @colir.object_id
      after_id = @colir.lighter.object_id
      after_id.should.not == before_id
    end

    it "doesn't modify the base colour" do
      before = @colir.hex
      @colir.lighter
      @colir.hex.should == before
    end

    it "returns a new colour, but a little bit darker" do
      @colir.lighter.shade.should == 1
    end
  end

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
      @colir.hex.should == 0x0e2a45
    end

    it "makes the current colour even more dark" do
      3.times { @colir.darken }
      @colir.hex.should == 0x071522
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
      @colir.hex.should == 0x205d99
    end

    it "makes the current colour even more light" do
      3.times { @colir.lighten }
      @colir.hex.should == 0x79aee3
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

  describe "shading" do
    before do
      @colir = Colir.new(0x123456)
    end

    it "darkens properly" do
      @colir.darken.hex.should == 0x0e2a45
      @colir.darken.hex.should == 0x0b1f34
      @colir.darken.hex.should == 0x071522
      @colir.darken.hex.should == 0x040a11
      @colir.darken.hex.should == 0
    end

    it "lightens properly" do
      @colir.lighten.hex.should == 0x205d99
      @colir.lighten.hex.should == 0x3685d5
      @colir.lighten.hex.should == 0x79aee3
      @colir.lighten.hex.should == 0xbcd6f1
      @colir.lighten.hex.should == 0xffffff
    end

    it "darkens and lightens properly" do
      before = @colir.hex
      2.times { @colir.lighten }
      5.times { @colir.darken }
      10.times { @colir.lighten }
      5.times { @colir.darken }
      after = @colir.hex
      before.should == after
    end

    describe "lower limit - 0x000000" do
      describe "darkening" do
        before do
          @colir = Colir.new(0x000000)
        end

        it "doesn't change the hex value" do
          before = @colir.hex
          after = @colir.darken.hex
          after.should == before
        end

        it "does change the shade level" do
          @colir.darken.shade.should == -1
        end

        it "doesn't overflow the shade level" do
          6.times { @colir.darken }
          @colir.shade.should == -5
        end
      end

      describe "lightening" do
        before do
          @colir = Colir.new(0x000000)
        end

        it "does change the hex value" do
          before = @colir.hex
          after = @colir.lighten.hex
          after.should.not == before
        end

        it "does change the shade level" do
          @colir.lighten.shade.should == 1
        end

        it "doesn't overflow the shade level" do
          6.times { @colir.lighten }
          @colir.shade.should == 5
        end
      end
    end

    describe "very close to lower limit" do
      describe "darkening" do
        before do
          @colir = Colir.new(0x000001)
        end

        it "does change the hex value when it's time" do
          before = @colir.hex
          3.times { @colir.darken }
          after = @colir.hex
          after.should.not == before
        end

        it "stops darkening when reaches the lower limit" do
          3.times { @colir.darken }
          before = @colir.hex
          after = @colir.darken.hex
          after.should == before
        end

        it "keeps changing the shade level" do
          2.times { @colir.darken }
          @colir.shade.should == -2

          2.times { @colir.darken }
          @colir.shade.should == -4
        end
      end
    end

    describe "very close to upper limit" do
      describe "lightening" do
        before do
          @colir = Colir.new(0xfffffe)
        end

        it "does change the hex value when it's time" do
          before = @colir.hex
          3.times { @colir.lighten }
          after = @colir.hex
          after.should.not == before
        end

        it "stops lightening when reaches the upper limit" do
          3.times { @colir.lighten }
          before = @colir.hex
          after = @colir.lighten.hex
          after.should == before
        end

        it "keeps changing the shade level" do
          2.times { @colir.lighten }
          @colir.shade.should == 2

          2.times { @colir.lighten }
          @colir.shade.should == 4
        end
      end
    end

  end
end
