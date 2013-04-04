require 'bigdecimal'

class Colir
  # The module provides methods for RGB to HSL and HSL to RGB conversions. I
  # just ported it from a C implementation.
  # @see http://goo.gl/WLwi6
  # @since 0.0.1
  # @private
  module HSLRGB

    # Provides helper methods for the RGB colours.
    module RGB

      # The possible values of an RGB colour.
      RGB_RANGE = 0..255

      # Performs a validation check for the +rgb+.
      #
      # @example Truthy
      #   RGB.valid_rgb?([255, 13, 0]) #=> true
      #
      # @example Falsey
      #   RGB.valid_rgb?([256, 13, -1]) #=> false
      #
      # @param [Array<Integer>] rgb The RGB colour to be checked
      # @return [Boolean] true if the given +rgb+ colour lies within the
      #   `RGB_RANGE`
      def self.valid_rgb?(rgb)
        rgb.all? { |b| valid_byte?(b) } && (rgb.length == 3)
      end

      # Converts +hex+ number to the RGB array.
      #
      # @example
      #   # TODO: accepts Integer, not String
      #   RGB.int_bytes('123456') #=> [18, 52, 86]
      #
      # @param [String] hex The hex number expressed without the preceding `0x`
      # @return [Array<Integer>] the RGB array
      def self.int_bytes(hex)
        hex.to_s(16).rjust(6, '0').scan(/../).map { |b| b.to_i(16) }
      end

      def self.valid_byte?(byte)
        RGB_RANGE.cover?(byte) && byte.integer?
      end
      private_class_method :valid_byte?
    end

    # Provides helper methods for HSL colours.
    module HSL

      # The possible values for the hue.
      H_RANGE = 0..360

      # The possible values for the saturation.
      S_RANGE = 0..1

      # The possible values for the lightness.
      L_RANGE = S_RANGE

      # Performs a validation check for the +hsl+.
      #
      # @example Truthy
      #   RGB.valid_hsl?([180, 1, 0.55]) #=> true
      #
      # @example Falsey
      #   RGB.valid_hsl?([180, 1.1, 0.55]) #=> false
      #
      # @param [Array<Number>] hsl The HSL colour to be checked
      # @return [Boolean] true if the given +hsl+ colour lies within the
      #   `H_RANGE`, `S_RANGE`, `L_RANGE`
      def self.valid_hsl?(hsl)
        valid_hue?(hsl[0]) && S_RANGE.cover?(hsl[1]) &&
          L_RANGE.cover?(hsl[2]) && (hsl.length == 3)
      end

      def self.valid_hue?(hue)
        H_RANGE.cover?(hue) && hue.integer?
      end
      private_class_method :valid_hue?
    end

    # The cached array of arrays, which contains order codes for the model  from
    # `::hsl_to_rgb`. The model is an array, where the needed for conversion
    # values are calculated only once. The order codes allows to refer to the
    # calculated model array values via indices. Hopefully, it saves some CPU
    # cycles.
    RGB_ORDER_CODES = [
      [0, 1, 2], # [0, 60)
      [1, 0, 2], # [60, 120)
      [2, 0, 1], # [120, 180)
      [2, 1, 0], # [180, 240)
      [1, 2, 0], # [240, 300)
      [0, 2, 1], # [300, 360)
    ]

    # The code returned for 0 or 360 degrees.
    RGB_DEFAULT_CODE = [2, 2, 2]

    # Converts an RGB colour to its HSL counterpart.
    #
    # @example
    #   rgb = 'c0c0c0'.scan(/../).map { |b| b.to_i(16) } #=> [192, 192, 192]
    #   HSLRGB.rgb_to_hsl(192, 192, 192) #=> [0, 0.0, 0.75]
    #
    # @param [Integer] red Possible values: 0..255
    # @param [Integer] green Possible values: 0..255
    # @param [Integer] blue Possible values: 0..255
    # @return [Array<Integer,BigDecimal>] the converted HSL representation of
    #   an RGB colour
    # @raise [RangeError] if one of the parameters doesn't lie within the
    #   accepted range
    # @see http://en.wikipedia.org/wiki/HSL_color_space HSL color space
    # @see ::hsl_to_rgb
    def self.rgb_to_hsl(red, green, blue)
      validate_rgb!([red, green, blue])

      red, green, blue = [red, green, blue].map { |b| b / BigDecimal('255.0') }
      min, max = [red, green, blue].minmax
      chroma = max - min
      lightness = (min + max) * 0.5

      hue = 0
      saturation = BigDecimal('0.0')

      if chroma.nonzero?
        hue = case max
              when red   then (green - blue) / chroma % 6
              when green then (blue - red) / chroma + 2
              else            (red - green) / chroma + 4
              end
        hue = (hue * 60).round
        saturation = chroma / (BigDecimal('1.0') - (2 * lightness - 1).abs)
      end

      [hue, saturation, lightness]
    end

    def self.validate_rgb!(rgb)
      unless RGB.valid_rgb?(rgb)
        raise RangeError, 'out of allowed RGB values (0-255)'
      end
    end
    private_class_method :validate_rgb!

    def self.validate_hsl!(hsl)
      unless HSL.valid_hsl?(hsl)
        raise RangeError, 'out of allowed HSL values (h:0-360 s:0-1 l:0-1)'
      end
    end
    private_class_method :validate_hsl!

    # Converts an HSL colour to its RGB counterpart. The algorithm is correct,
    # but sometimes you'll notice little laxity (because of rounding problems).
    #
    # @example
    #   HSLRGB.hsl_to_rgb(180, 1, 0.55) #=> [25, 255, 255]
    #
    # @param [Integer] hue Possible values: 0..360
    # @param [Float] saturation Possible values: 0..1
    # @param [Float] lightness Possible values: 0..1
    # @return [Array<Integer>] the converted RGB representation of a HSL colour
    # @raise [RangeError] if one of the parameters doesn't lie within the
    #   accepted range
    # @see ::rgb_to_hsl
    def self.hsl_to_rgb(hue, saturation, lightness)
      validate_hsl!([hue, saturation, lightness])

      chroma = (BigDecimal('1.0') - (2 * lightness - 1.0).abs) * saturation
      a = BigDecimal('1.0') * (lightness - BigDecimal('0.5') * chroma)
      b = chroma * (BigDecimal('1.0') - ((hue / BigDecimal('60.0')).modulo(2) - BigDecimal('1.0')).abs)

      degrees = Array.new(7) { |idx| idx * 60 }.each
      model = [chroma+a, a+b, a]

      RGB_ORDER_CODES.find(->{RGB_DEFAULT_CODE}) {
        (degrees.next...degrees.peek) === hue
      }.map { |id|
        (model[id] * 255).round
      }
    end

  end
end
