# Find by SQL file

This plugin extends the API of `ActiveRecord::Base.find_by_sql`.

## A Warning

Besides the warnings on the `ERB` section below (don't ignore those), this
code is not very well tested (RCOV shows 100% coverage, but that doesn't
mean much), and has no track record whatsoever. So there, beware.

## Usage

Instead of passing the SQL statement as a string...

    Elephant.find_by_sql "SELECT * FROM elephants WHERE weight='massive'"

You can pass a symbol that refers to a query file stored in
`RAILS_ROOT`/app/queries/`TABLE_NAME`/`SYMBOL`.sql

    Elephant.find_by_sql :massive_weight

## Installation instructions

Via rubygems:

    sudo gem install jordi-find_by_sql_file --source http://gems.github.com

    # Add the following to config/environment.rb:
    config.gem 'jordi-find_by_sql_file', :source => 'http://gems.github.com'

As a Rails plugin:

    ./script/install plugin git://github.com/jordi/find_by_sql_file.git

## Motivation

The advantage of the latter approach is that the SQL file can be properly
indented and commented (the indentation and comments are stripped from the
logs.)

## Features & Problems

### Comment removal

As far as comment removal, only double-dash-space single-line comments are
stripped, like so:

    SELECT foo, -- We need this for X reason
           bar, -- and this for some Y reason
           bez,  # This comment will NOT be removed, and will be a problem
           duh  /* And neither will this one. Use -- style only */

           FROM table;

So, to clarify, the start-comment marker is `-- ` (two dashes and a space).
That I know of, this marker works in MySQL, PostgreSQL, SQLite, Oracle, DB2,
and SQL Server. While not all of these require the space after the dashes,
it never hurts.

### Bind variables

It's possible to pass named bind variables, much like in the conditions
parameter of `ActiveRecord::Base.find`, by passing a hash as the second
parameter, like so:

    Elephant.find_by_sql :specifics, :color => 'grey', :weight => 6800

### ERB (be careful)

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

## Legal

Copyright (c) 2008 Jordi Bunster, released under the MIT license