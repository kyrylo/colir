Colir
=====

* Repository: [https://github.com/kyrylo/colir][cr]

Description
-----------

This tiny library provides support for HEX numbers and some simple manipulations
with them.

Installation
------------

    gem install colir

Synopsis
--------

The name Colir means (roughly) “colour” in Ukrainian. OK, enough of rant, let's
talk about the API instead.

You can create colours with human readable names. For example, the following
code would create opaque red colour (0xff000000).

```
require 'colir'

red = Colir.red #=> (Colir: 0xff000000)
red.hex #=> "0xff000000"
```

You can also create arbitrary HEX colours.

```
red = Colir.new(0xff0000)
```

As you may have noticed, the library supports transparent colours.

```
red = Colir.red(0.3) #=> (Colir: 0xff00001e)
red.hex #=> "0xff00001e"
red.transparency #=> 0.3

green = Colir.new(0x00ff00, 0.3)
green.hex #=> "0x00ff001e"
green.transparency #=> 0.3
```

It's possible to make the colour more or less transparent.

```
# Transparency.
green = Colir.new(0x00ff00, 0.3)
green.transparency #=> 0.3
green.transparent! #=> (Colir: 0x00ff00e1)
green.transparency #=> 0.0

# Opacity.
red = Colir.new(0xff0000, 0)
red.transparency #=> 0.0
red.opaque! #=> (Colir: 0x00ff00ff)
red.transparency #=> 1.0
```

Last but not least, you can use shades.

```
red = Colir.red
red.shade #=> 0
red.darker #=> 
red.shade #=> 0
red.lighter #=> 
red.shade #=> 0

# The previous methods don't return the new colour object. These next two does
# modify the existing Colir:
red.darken
red.shade #=> -1
red.darken
red.shade #=> -2
red.lighten
red.lighten
red.lighten
red.shade #=> 1
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

Licence
-------

The project uses Zlib licence. See LICENCE file for more information.

[ps]: https://github.com/kyrylo/colir
