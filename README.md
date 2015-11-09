# [Typespec](http://mtwilliams.github.io/typespec)

[![Gem Version](https://img.shields.io/gem/v/typespec.svg)](https://rubygems.org/gems/typespec)
[![Build Status](https://img.shields.io/travis/mtwilliams/typespec/master.svg)](https://travis-ci.org/mtwilliams/typespec)
[![Code Climate](https://img.shields.io/codeclimate/github/mtwilliams/typespec.svg)](https://codeclimate.com/github/mtwilliams/typespec)
[![Dependency Status](https://img.shields.io/gemnasium/mtwilliams/typespec.svg)](https://gemnasium.com/mtwilliams/typespec)

:nut_and_bolt: Specify complex schema made of types or specific values.

```Ruby
Typespec.hash[Typespec.string => Typespec.or[Typespec.nothing,
                                             Typespec.boolean,
                                             Typespec.number,
                                             Typespec.string]]
```
