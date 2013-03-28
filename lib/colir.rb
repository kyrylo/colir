class Colir

  # The VERSION file must be in the root directory of the library.
  VERSION_FILE = File.expand_path('../../VERSION', __FILE__)

  VERSION = File.exist?(VERSION_FILE) ?
    File.read(VERSION_FILE).chomp : '(could not find VERSION file)'

  # HTML and CSS color specification.
  # Includes hexadecimal zeros for alpha channel.
  COLIRS = {
    :alice_blue              => 0x00f0f8ff,
    :antique_white           => 0x00faebd7,
    :aqua                    => 0x0000ffff,
    :aquamarine              => 0x007fffd4,
    :azure                   => 0x00f0ffff,
    :beige                   => 0x00f5f5dc,
    :bisque                  => 0x00ffe4c4,
    :black                   => 0x00000000,
    :blanched_almond         => 0x00ffebcd,
    :blue                    => 0x000000ff,
    :blue_violet             => 0x008a2be2,
    :brown                   => 0x00a52a2a,
    :burly_wood              => 0x00deb887,
    :cadet_blue              => 0x005f9ea0,
    :chartreuse              => 0x007fff00,
    :chocolate               => 0x00d2691e,
    :coral                   => 0x00ff7f50,
    :cornflower_blue         => 0x006495ed,
    :cornsilk                => 0x00fff8dc,
    :crimson                 => 0x00dc143c,
    :cyan                    => 0x0000ffff,
    :dark_blue               => 0x0000008b,
    :dark_cyan               => 0x00008b8b,
    :dark_golden_rod         => 0x00b8860b,
    :dark_gray               => 0x00a9a9a9,
    :dark_green              => 0x00a9a9a9,
    :dark_khaki              => 0x00bdb76b,
    :dark_magenta            => 0x008b008b,
    :dark_olive_green        => 0x00556b2f,
    :dark_orange             => 0x00ff8c00,
    :dark_orchid             => 0x009932cc,
    :dark_red                => 0x009932cc,
    :dark_salmon             => 0x00e9967a,
    :dark_sea_green          => 0x008fbc8f,
    :dark_slate_blue         => 0x00483d8b,
    :dark_slate_gray         => 0x002f4f4f,
    :dark_turquoise          => 0x0000ced1,
    :dark_violet             => 0x009400d3,
    :deep_pink               => 0x00ff1493,
    :deep_sky_blue           => 0x0000bfff,
    :dim_gray                => 0x00696969,
    :dim_grey                => 0x00696969,
    :dodger_blue             => 0x001e90ff,
    :fire_brick              => 0x00b22222,
    :floral_white            => 0x00fffaf0,
    :forest_green            => 0x00228b22,
    :fuchsia                 => 0x00ff00ff,
    :gainsboro               => 0x00dcdcdc,
    :ghost_white             => 0x00f8f8ff,
    :gold                    => 0x00ffd700,
    :golden_rod              => 0x00daa520,
    :gray                    => 0x00808080,
    :green                   => 0x00008000,
    :green_yellow            => 0x00adff2f,
    :honey_dew               => 0x00f0fff0,
    :hot_pink                => 0x00ff69b4,
    :indian_red              => 0x00cd5c5c,
    :indigo                  => 0x004b0082,
    :ivory                   => 0x00fffff0,
    :khaki                   => 0x00f0e68c,
    :lavender                => 0x00e6e6fa,
    :lavender_blush          => 0x00fff0f5,
    :lawn_green              => 0x007cfc00,
    :lemon_chiffon           => 0x00fffacd,
    :light_blue              => 0x00add8e6,
    :light_coral             => 0x00f08080,
    :light_cyan              => 0x00e0ffff,
    :light_golden_rod_yellow => 0x00fafad2,
    :light_gray              => 0x00d3d3d3,
    :light_green             => 0x0090ee90,
    :light_pink              => 0x00ffb6c1,
    :light_salmon            => 0x00ffa07a,
    :light_sea_green         => 0x0020b2aa,
    :light_sky_blue          => 0x0087cefa,
    :light_slate_gray        => 0x00778899,
    :light_steel_blue        => 0x00b0c4de,
    :light_yellow            => 0x00ffffe0,
    :lime                    => 0x0000ff00,
    :lime_green              => 0x0032cd32,
    :linen                   => 0x00faf0e6,
    :magenta                 => 0x00ff00ff,
    :maroon                  => 0x00800000,
    :medium_aqua_marine      => 0x0066cdaa,
    :medium_blue             => 0x000000cd,
    :medium_orchid           => 0x00ba55d3,
    :medium_purple           => 0x009370db,
    :medium_sea_green        => 0x003cb371,
    :medium_slate_blue       => 0x007b68ee,
    :medium_spring_green     => 0x0000fa9a,
    :medium_turquoise        => 0x0048d1cc,
    :medium_violet_red       => 0x00c71585,
    :midnight_blue           => 0x00191970,
    :mint_cream              => 0x00f5fffa,
    :misty_rose              => 0x00ffe4e1,
    :moccasin                => 0x00ffe4b5,
    :navajo_white            => 0x00ffdead,
    :navy                    => 0x00000080,
    :old_lace                => 0x00fdf5e6,
    :olive                   => 0x00808000,
    :olive_drab              => 0x006b8e23,
    :orange                  => 0x00ffa500,
    :orange_red              => 0x00ff4500,
    :orchid                  => 0x00da70d6,
    :pale_golden_rod         => 0x00eee8aa,
    :pale_green              => 0x0098fb98,
    :pale_turquoise          => 0x00afeeee,
    :pale_violet_red         => 0x00db7093,
    :papaya_whip             => 0x00ffefd5,
    :peach_puff              => 0x00ffdab9,
    :peru                    => 0x00cd853f,
    :pink                    => 0x00ffc0cb,
    :plum                    => 0x00dda0dd,
    :powder_blue             => 0x00b0e0e6,
    :purple                  => 0x00800080,
    :red                     => 0x00ff0000,
    :rosy_brown              => 0x00bc8f8f,
    :royal_blue              => 0x004169e1,
    :saddle_brown            => 0x008b4513,
    :salmon                  => 0x00fa8072,
    :sandy_brown             => 0x00f4a460,
    :sea_green               => 0x002e8b57,
    :sea_shell               => 0x00fff5ee,
    :sienna                  => 0x00a0522d,
    :silver                  => 0x00c0c0c0,
    :sky_blue                => 0x0087ceeb,
    :slate_blue              => 0x006a5acd,
    :slate_gray              => 0x00708090,
    :snow                    => 0x00fffafa,
    :spring_green            => 0x0000ff7f,
    :steel_blue              => 0x00468284,
    :tan                     => 0x00d2b48c,
    :teal                    => 0x00008080,
    :thistle                 => 0x00d8bfd8,
    :tomato                  => 0x00ff6347,
    :turquoise               => 0x0040e0d0,
    :violet                  => 0x00ee82ee,
    :wheat                   => 0x00f5debe,
    :white                   => 0x00000000,
    :white_smoke             => 0x00f5f5f5,
    :yellow                  => 0x00ffff00,
    :yellow_green            => 0x009acd32
  }

  class << self
  end

  def initialize()
  end
end
