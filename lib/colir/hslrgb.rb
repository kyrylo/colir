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
      # @param [Array] rgb The RGB colour to be checked
      # @return [Boolean] true if the given +rgb+ colour lies within the
      #   `RGB_RANGE`
      def self.valid_rgb?(rgb)
        rgb.all? { |b| RGB_RANGE.include?(b) }
      end
    end

    # Provides helper methods for HSL colours.
    module HSL

      # The possible values for the hue.
      H_RANGE = 0..360

      # The possible values for the saturation.
      S_RANGE = 0..1

      # The possible values for the lightness.
      L_RANGE = S_RANGE

      # Performs a validation check for the +rgb+.
      #
      # @example Truthy
      #   RGB.valid_rgb?([255, 13, 0]) #=> true
      #
      # @example Falsey
      #   RGB.valid_rgb?([256, 13, -1]) #=> false
      #
      # @param [Array] rgb The RGB colour to be checked
      # @return [Boolean] true if the given +rgb+ colour lies within the
      #   `RGB_RANGE`
      def self.valid_hsl?(hsl)
        H_RANGE.include?(hsl[0]) && S_RANGE.include?(hsl[1]) &&
          L_RANGE.include?(hsl[2])
      end
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
    # @return [Array<Integer,Float>] the converted HSL representation of an RGB
    #   colour
    # @raise [RangeError] if one of the parameters doesn't lie within the
    #   accepted range
    # @see http://en.wikipedia.org/wiki/HSL_color_space HSL color space
    # @see ::hsl_to_rgb
    def self.rgb_to_hsl(red, green, blue)
      validate_rgb!([red, green, blue])

      red, green, blue = [red, green, blue].map { |b| b / 255.0 }
      min, max = [red, green, blue].minmax
      chroma = max - min
      lightness = (0.5 * (min + max)).round(2)

      hue = saturation = 0

      if chroma.nonzero?
        hue = case max
              when red   then ((green - blue) / chroma) % 6
              when green then (blue - red) / chroma + 2
              else            (red - green) / chroma + 4
              end

        hue = Integer(hue / 60 * 3600)
        saturation = ((chroma) / (1.0 - (2 * lightness - 1).abs)).round(2)
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

      chroma = (1.0 - (2 * lightness - 1.0).abs) * saturation
      a = 1.0 * (lightness - 0.5 * chroma)
      b = chroma * (1.0 - ((hue / 60.0).modulo(2) - 1.0).abs)

      degrees = Array.new(7) { |idx| idx * 60 }.each
      model = [chroma+a, a+b, a]

      RGB_ORDER_CODES.find(->{RGB_DEFAULT_CODE}) {
        (degrees.next...degrees.peek) === hue
      }.map { |id|
        (model[id] * 255).to_i
      }
    end

  end
end
