# Find by SQL file

This plugin extends the API of `ActiveRecord::Base.find_by_sql`.

## Usage

Instead of passing the SQL statement as a string...

    Elephant.find_by_sql "SELECT * FROM elephants WHERE weight='massive'"

You can pass a symbol that refers to a query file stored in
`RAILS_ROOT`/app/queries/`TABLE_NAME`/`SYMBOL`.sql

    Elephant.find_by_sql :massive_weight

## A Warning

Besides the warnings on the `ERB` section below (don't ignore those), this
code is not tested at all, and has no track record whatsoever. So there,
beware.

## Motivation

The advantage of the latter approach is that the SQL file can be properly
indented and commented (the indentation and comments are stripped from the
logs.)

It's possible to pass named bind variables, much like in the conditions
parameter of `ActiveRecord::Base.find`, by passing a hash as the second
parameter, like so:

    Elephant.find_by_sql :specifics, :color => 'grey', :weight => 6800

## ERB (be careful)

It is also possible to use `ERB` inside the query file, but **beware!**
Unlike the named bind variables, any data passed in via the ERB method is not
properly quoted by the database adapter, leaving open the possibility of
**SQL injection**. 99.9% of the time, **you will _NOT_ need this**.

Here's an artificial (but easy to explain) example of how the
(very dangerous!) `ERB` _feature_ works:

    Elephant.find_by_sql :single_value, :value   => 'grey',
                                        :inject! => { :field => 'color' }

The call above replaces the bind variable `:value` inside the SQL file,
but it also populates the instance variable `@field` with `"color"`, which
can then be used with the usual ERB syntax, like so:

    SELECT <%= @field -%> FROM elephants WHERE <%= @field -%> = :value

### Legal

Copyright (c) 2008 Jordi Bunster, released under the MIT license