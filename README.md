Colir
=====

[![Build Status][ci-badge]][ci-link]

* Repository: [https://github.com/kyrylo/colir][cr]

Description
-----------

This tiny library provides support for RGB colours and some simple manipulations
with them.

Installation
------------

    gem install colir

Synopsis
--------

The name Colir means “colour” in Ukrainian (roughly). OK, enough of rant, let's
talk about the API instead.

###### Basics

You can create colours with human readable names. For example, the following
code would create opaque red colour (0xff000000).

```ruby
require 'colir'

# Create a new Colir.
red = Colir.red #=> #<Colir:...>
# Get a valid RGB colour, represented as an integer number.
red.hex #=> 16711680
# Why do you never trust me?
red.hex.to_s(16) #=> "ff0000"

# You can also get the same colour, but with alpha channel.
red.hexa #=> 4278190080
# Okay, okay!
red.hexa.to_s(16) #=> "ff000000"
```

The list of all human readable colour names can be found at [w3schools][w3].
Actually, you can create any valid RGB colours, not just the predefined ones.

```ruby
# This is valid.
yup = Colir.new(0xff0000) #=> #<Colir:...>
# This isn't. There is no such RGB colour.
nope = Colir.new(0xff00001) #=> RangeError: out of allowed RGB values
```

###### Transparency

As you may have noticed, the library supports transparent colours.

```ruby
# Shortcut methods have only 1 parameter, which is transparency. It must lie
# within the range of 0..1
red = Colir.red(0.3)
red.hexa #=> 4278190110
red.hexa.to_s(16) #=> "ff00001e"
red.transparency #=> 0.3

# With arbitrary colours you can pass the second parameter.
green = Colir.new(0x00ff00, 0.3)
green.hexa #=> 16711710
green.hexa.to_s(16) #=> "0x00ff001e"
green.transparency #=> 0.3

# The default transparency is 0.0
green = Colir.new(0x00ff00)
green.transparency #=> 0.0
```

It's possible to adjust a Colir's transparency.

```ruby
# `#opaque!` and `#transparent!` set a Colir's transparency to `0.0`
# and `1.0` respectively.
blue = Colir.new(0x0000ff, 0.45)
blue.transparency #=> 0.3
blue.transparent! #=> (Colir: 0x00ff00e1)
blue.transparency #=> 0.0
blue.opaque! #=> (Colir: 0x00ff00ff)
blue.transparency #=> 1.0

# You can set your own transparency value.
blue.transparency = 0.9 #=> 0.9
blue.transparency #=> 0.9

# But be careful, as the valid value is anything in between 0 and 1.
blue.transparency = 1.01 #=> RangeError: ...
```

###### Shades

Last but not least, you can use colour shades.

```ruby
yellow = Colir.yellow
yellow.shade #=> 0

# Let's make it a bit darker.
yellow.darken #=> #<Colir:...>
yellow.shade #=> -1
yellow.hex #=> 13421568

# Hum, that's not dark enough. Let's do it one more time.
yellow.darken
yellow.shade #=> -2
yellow.hex #=> 10066176

# Actually, the previous shade was better!
yellow.lighten
yellow.shade #=> -1
yellow.hex #=> 13421568
```

The previous examples modify the Colir object (`#darken` and `#lighten`).
Hovewer, there are two other methods that return a new object: `#darker` and
`#lighter`.

```ruby
# HEXes
orange = Colir.orange
orange.hex #=> 16753920
orange.darker.hex #=> 13403392
orange.hex #=> 16753920

# Shades
orange = Colir.orange
orange.shade #=> 0
orange.lighter.shade #=> 1
orange.shade #=> 0
```

There is a handy way to reset the shade level. Can you guess it? Of course, it's
the `#reset_shade` method!

```ruby
indigo = Colir.indigo
indigo.lighten
indigo.lighten
indigo.lighten
indigo.lighten
indigo.lighten
indigo.shades #=> 5
indigo.reset_shade #=> #<Colir:...>
indigo.shade #=> 0
```

Limitations
-----------

### OS support

Colir is a cross-platform library.

### Rubies

* Ruby 1.9.3 and higher
* Rubinius 2.0.0rc1 and higher (mode 1.9 and higher)
* JRuby 1.7.3 and higher (mode 1.9.3 and higher)

Credits
-------

* The first contributor badge goes to [kachick][kachick]

Licence
-------

The project uses Zlib licence. See LICENCE file for more information.

[cr]: https://github.com/kyrylo/colir
[ci-badge]: https://travis-ci.org/kyrylo/colir.png?branch=master "Build status"
[ci-link]: https://travis-ci.org/kyrylo/colir/ "Build history"
[w3]: http://www.w3schools.com/cssref/css_colornames.asp
[kachick]: https://github.com/kachick
