# danger-duplicate_localizable_strings

A [Danger](https://github.com/danger/danger) plugin that detect duplicate entries in Localizable.strings.

## Installation

    $ gem install danger-duplicate_localizable_strings

## Usage

Just call


    check_localizable_duplicates


in your `Dangerfile` and you're all set 🎉

You can also call `localizable_duplicate_entries` to get an array of hashes
containing Localizable.strings file path under `file` and duplicate entry
key under `key`.

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
