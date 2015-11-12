# [Typespec](http://mtwilliams.github.io/typespec)

[![Gem Version](https://img.shields.io/gem/v/typespec.svg)](https://rubygems.org/gems/typespec)
[![Build Status](https://img.shields.io/travis/mtwilliams/typespec/master.svg)](https://travis-ci.org/mtwilliams/typespec)
[![Code Climate](https://img.shields.io/codeclimate/github/mtwilliams/typespec.svg)](https://codeclimate.com/github/mtwilliams/typespec)
[![Dependency Status](https://img.shields.io/gemnasium/mtwilliams/typespec.svg)](https://gemnasium.com/mtwilliams/typespec)

:nut_and_bolt: Specify complex schema made of types or specific values.

```Ruby
module Defines
  def self.typespec
    Typespec.hash[Typespec.string => Typespec.or[Typespec.nothing,
                                                 Typespec.boolean,
                                                 Typespec.number,
                                                 Typespec.string]]
  end
end

Defines.typespec.valid?('YETI_LINKAGE' => 'YETI_LINKAGE_STATIC',
                        '__YETI_IS_BEING_COMPILED__' => true,
                        'YETI_CONFIGURATION' => 'YETI_CONFIGURATION_DEBUG',
                        '_HAS_EXCEPTIONS' => false,
                        '_SCL_SECURE_NO_WARNINGS' => true,
                        '_CRT_SECURE_NO_WARNINGS' => true,
                        '_CRT_SECURE_NO_DEPRECATE' => true,
                        '_SECURE_SCL_THROWS' => false,
                        '_SILENCE_DEPRECATION_OF_SECURE_SCL_THROWS' => true,
                        '_USING_V110_SDK71_' => true,
                        '_DEBUG' => true,
                        '_HAS_ITERATOR_DEBUGGING' => true,
                        '_SECURE_SCL' => true)

#=> true
```

