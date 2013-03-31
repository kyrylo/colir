class Colir
  # The module provides methods for RGB to HSL and HSL to RGB conversions. I
  # just ported it from a C implementation.
  # @see http://goo.gl/WLwi6
  # @since 0.0.1
  # @private
  module HSLRGB

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
    # @see http://en.wikipedia.org/wiki/HSL_color_space HSL color space
    # @see ::hsl_to_rgb
    def self.rgb_to_hsl(red, green, blue)
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
    # @see ::rgb_to_hsl
    def self.hsl_to_rgb(hue, saturation, lightness)
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
