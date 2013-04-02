require_relative 'colir/hslrgb'

# Blah
class Colir

  # The VERSION file must be in the root directory of the library.
  VERSION_FILE = File.expand_path('../../VERSION', __FILE__)

  VERSION = File.exist?(VERSION_FILE) ?
    File.read(VERSION_FILE).chomp : '(could not find VERSION file)'

  # The list for human readable colour according to the HTML and CSS color
  # specification. Does not include alpha channel.
  COLIRS = {
    :alice_blue              => 0xf0f8ff,
    :antique_white           => 0xfaebd7,
    :aqua                    => 0x00ffff,
    :aquamarine              => 0x7fffd4,
    :azure                   => 0xf0ffff,
    :beige                   => 0xf5f5dc,
    :bisque                  => 0xffe4c4,
    :black                   => 0x000000,
    :blanched_almond         => 0xffebcd,
    :blue                    => 0x0000ff,
    :blue_violet             => 0x8a2be2,
    :brown                   => 0xa52a2a,
    :burly_wood              => 0xdeb887,
    :cadet_blue              => 0x5f9ea0,
    :chartreuse              => 0x7fff00,
    :chocolate               => 0xd2691e,
    :coral                   => 0xff7f50,
    :cornflower_blue         => 0x6495ed,
    :cornsilk                => 0xfff8dc,
    :crimson                 => 0xdc143c,
    :cyan                    => 0x00ffff,
    :dark_blue               => 0x00008b,
    :dark_cyan               => 0x008b8b,
    :dark_golden_rod         => 0xb8860b,
    :dark_gray               => 0xa9a9a9,
    :dark_green              => 0xa9a9a9,
    :dark_khaki              => 0xbdb76b,
    :dark_magenta            => 0x8b008b,
    :dark_olive_green        => 0x556b2f,
    :dark_orange             => 0xff8c00,
    :dark_orchid             => 0x9932cc,
    :dark_red                => 0x9932cc,
    :dark_salmon             => 0xe9967a,
    :dark_sea_green          => 0x8fbc8f,
    :dark_slate_blue         => 0x483d8b,
    :dark_slate_gray         => 0x2f4f4f,
    :dark_turquoise          => 0x00ced1,
    :dark_violet             => 0x9400d3,
    :deep_pink               => 0xff1493,
    :deep_sky_blue           => 0x00bfff,
    :dim_gray                => 0x696969,
    :dim_grey                => 0x696969,
    :dodger_blue             => 0x1e90ff,
    :fire_brick              => 0xb22222,
    :floral_white            => 0xfffaf0,
    :forest_green            => 0x228b22,
    :fuchsia                 => 0xff00ff,
    :gainsboro               => 0xdcdcdc,
    :ghost_white             => 0xf8f8ff,
    :gold                    => 0xffd700,
    :golden_rod              => 0xdaa520,
    :gray                    => 0x808080,
    :green                   => 0x008000,
    :green_yellow            => 0xadff2f,
    :honey_dew               => 0xf0fff0,
    :hot_pink                => 0xff69b4,
    :indian_red              => 0xcd5c5c,
    :indigo                  => 0x4b0082,
    :ivory                   => 0xfffff0,
    :khaki                   => 0xf0e68c,
    :lavender                => 0xe6e6fa,
    :lavender_blush          => 0xfff0f5,
    :lawn_green              => 0x7cfc00,
    :lemon_chiffon           => 0xfffacd,
    :light_blue              => 0xadd8e6,
    :light_coral             => 0xf08080,
    :light_cyan              => 0xe0ffff,
    :light_golden_rod_yellow => 0xfafad2,
    :light_gray              => 0xd3d3d3,
    :light_green             => 0x90ee90,
    :light_pink              => 0xffb6c1,
    :light_salmon            => 0xffa07a,
    :light_sea_green         => 0x20b2aa,
    :light_sky_blue          => 0x87cefa,
    :light_slate_gray        => 0x778899,
    :light_steel_blue        => 0xb0c4de,
    :light_yellow            => 0xffffe0,
    :lime                    => 0x00ff00,
    :lime_green              => 0x32cd32,
    :linen                   => 0xfaf0e6,
    :magenta                 => 0xff00ff,
    :maroon                  => 0x800000,
    :medium_aqua_marine      => 0x66cdaa,
    :medium_blue             => 0x0000cd,
    :medium_orchid           => 0xba55d3,
    :medium_purple           => 0x9370db,
    :medium_sea_green        => 0x3cb371,
    :medium_slate_blue       => 0x7b68ee,
    :medium_spring_green     => 0x00fa9a,
    :medium_turquoise        => 0x48d1cc,
    :medium_violet_red       => 0xc71585,
    :midnight_blue           => 0x191970,
    :mint_cream              => 0xf5fffa,
    :misty_rose              => 0xffe4e1,
    :moccasin                => 0xffe4b5,
    :navajo_white            => 0xffdead,
    :navy                    => 0x000080,
    :old_lace                => 0xfdf5e6,
    :olive                   => 0x808000,
    :olive_drab              => 0x6b8e23,
    :orange                  => 0xffa500,
    :orange_red              => 0xff4500,
    :orchid                  => 0xda70d6,
    :pale_golden_rod         => 0xeee8aa,
    :pale_green              => 0x98fb98,
    :pale_turquoise          => 0xafeeee,
    :pale_violet_red         => 0xdb7093,
    :papaya_whip             => 0xffefd5,
    :peach_puff              => 0xffdab9,
    :peru                    => 0xcd853f,
    :pink                    => 0xffc0cb,
    :plum                    => 0xdda0dd,
    :powder_blue             => 0xb0e0e6,
    :purple                  => 0x800080,
    :red                     => 0xff0000,
    :rosy_brown              => 0xbc8f8f,
    :royal_blue              => 0x4169e1,
    :saddle_brown            => 0x8b4513,
    :salmon                  => 0xfa8072,
    :sandy_brown             => 0xf4a460,
    :sea_green               => 0x2e8b57,
    :sea_shell               => 0xfff5ee,
    :sienna                  => 0xa0522d,
    :silver                  => 0xc0c0c0,
    :sky_blue                => 0x87ceeb,
    :slate_blue              => 0x6a5acd,
    :slate_gray              => 0x708090,
    :snow                    => 0xfffafa,
    :spring_green            => 0x00ff7f,
    :steel_blue              => 0x468284,
    :tan                     => 0xd2b48c,
    :teal                    => 0x008080,
    :thistle                 => 0xd8bfd8,
    :tomato                  => 0xff6347,
    :turquoise               => 0x40e0d0,
    :violet                  => 0xee82ee,
    :wheat                   => 0xf5debe,
    :white                   => 0x000000,
    :white_smoke             => 0xf5f5f5,
    :yellow                  => 0xffff00,
    :yellow_green            => 0x9acd32
  }

  class << self
    # Dynamically define class methods. Each human readable colour turns into a
    # method. It's useful if you don't care about precise colours or can't
    # remember HEX codes for a colour.
    #
    # @example Accessing a colour
    #   Colir.wheat.hex #=> 0xf5debe00
    #
    # @example Transparency
    #   Colir.wheat(0.3).hex #=> 0xf5debee1
    #
    # @param [Float] transparency
    #
    # @return [Colir]
    # @see Colir
    COLIRS.each do |name, hex|
      define_method(name) { |transparency = nil|
        new(hex, transparency || TRANSPARENCY)
      }
    end
  end

  SHADE_FACTOR = 5
  TRANSPARENCY = 0.0
  SHADE = 0

  UPPER_LIMIT = HSLRGB::HSL::L_RANGE.max

  # @return [Integer] the HEX colour without the alpha channel
  attr_reader :hex

  # @return [Float] the transparency. Lies within the range of [0, 1].
  attr_reader :transparency

  # @return [Integer] the current shade of the colour. Lies within the
  #   range of [-5, 5]
  attr_reader :shade

  # Creates a new HEXA colour, where the A states for "Alpha".
  #
  # @param [Integer] hex It's convenient to use Ruby's HEX notation: `0xaaff33`
  # @param [Float] transparency Alpha channel. Must lie within the range
  #   of [0, 1].
  # @raise [RangeError] if the tranparency is a bad value
  def initialize(hex, transparency = TRANSPARENCY)
    unless (0..1).include?(transparency)
      raise RangeError, 'out of allowed transparency values (0-1)'
    end
    @hex = hex
    @transparency = transparency
    @shade = SHADE
    @ld_seq = [:base]
  end

  # @return [Integer] the HEXA representation of the Colir
  def hexa
    (@hex.to_s(16).rjust(6, '0') + (transparency * 100).to_i.to_s(16).rjust(2, '0')).to_i(16)
  end

  # Make the colour fully transparent.
  # @return [self]
  def transparent!
    @transparency = 1.0
    self
  end

  # Make the colour fully opaque.
  # @return [self]
  def opaque!
    @transparency = TRANSPARENCY
    self
  end

  # Lightens `self` by 1 shade. The maximum number of positive shades is 5. The
  # method stops increasing the shade levels when it reaches the limit and
  # merely returns `self` without any changes. The final shade is white colour.
  #
  # @return [self] the lightened `self`
  def lighten
    if @shade < SHADE_FACTOR
      calculate_new_hex { |hsl|
        hsl[2] += if @ld_seq.last == :base || @ld_seq.last == :ltn
                    @ld_seq << :ltn
                    l_factor(hsl)
                  else
                    @ld_seq.pop
                    d_factor(hsl)
                  end
        @shade += 1
        hsl
      }
    end
    self
  end

  # Darkens `self` by 1 shade. The maximum number of negative shades is -5. The
  # method stops decreasing the shade levels when it reaches the limit and
  # merely returns `self` without any changes. The final shade is black colour.
  #
  # @return [self] the darkened `self`
  def darken
    if SHADE_FACTOR * -1 < @shade
      calculate_new_hex { |hsl|
        hsl[2] -= if @ld_seq.last == :base || @ld_seq.last == :dkn
                    @ld_seq << :dkn
                    d_factor(hsl)
                  else
                    @ld_seq.pop
                    l_factor(hsl)
                  end

        @ld_delta = -1
        @shade -= 1
        hsl
      }
    end
    self
  end

  private

  def l_factor(hsl = nil)
    @l_factor ||= ((UPPER_LIMIT - hsl[2]) / SHADE_FACTOR).round(2) if hsl
    @l_factor
  end

  def d_factor(hsl = nil)
    @d_factor ||= (hsl[2] / SHADE_FACTOR).round(2) if hsl
    @d_factor
  end

  # @yield [hsl]
  # @yieldparam [Array<Integer>] an HSL colour based on the current HEX
  # @yieldreturn [Array<Integer>] an HSL colour with corrected lightness
  # @return [void]
  def calculate_new_hex
    hsl = HSLRGB.rgb_to_hsl(*HSLRGB::RGB.int_bytes(@hex))
    @hex = HSLRGB.hsl_to_rgb(*yield(hsl)).map do |b|
      b.to_s(16).rjust(2, '0')
    end.join('').to_i(16)
  end

end
