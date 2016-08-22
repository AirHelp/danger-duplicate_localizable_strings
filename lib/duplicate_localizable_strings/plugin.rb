module Danger
  #
  # Simple plugin that checks for duplicate entries in changed
  # Localizable.strings files inside iOS and Mac projects.
  #
  # @example Checks whether there are duplicate entries in Localizable.strings
  #
  #          check_localizable_duplicates
  #
  # @tags localization, cocoa
  #
  class DangerDuplicateLocalizableStrings < Plugin
    #
    # Returns an array of all detected duplicate entries. An entry is
    # represented by a has with file path under 'file' key and the
    # Localizable.strings key under 'key' key.
    #
    # @return  [Array of duplicate Localizable.strings entries]
    #
    def localizable_duplicate_entries
      localizable_files = (git.modified_files + git.added_files) - git.deleted_files
      localizable_files.select! { |line| line.end_with?('.strings') }

      duplicate_entries = []

      localizable_files.each do |file|
        lines = File.readlines(file)

        # Grab just the keys, translations might be different
        keys = lines.map { |e| e.split('=').first }
        # Filter newlines and comments
        keys = keys.select do |e|
          e != "\n" && !e.start_with?('/*') && !e.start_with?('//')
        end

        # Grab keys that appear more than once
        duplicate_keys = keys.select { |e| keys.rindex(e) != keys.index(e) }
        # And make sure we have one entry per duplicate key
        duplicate_keys = duplicate_keys.uniq

        duplicate_keys.each do |key|
          duplicate_entries << { 'file' => file, 'key' => key }
        end
      end

      duplicate_entries
    end

    #
    # Prints passed duplicated entries.
    # @param    [Hash] duplicate_entries
    #           A hash of `[file => keys]` entries to print.
    #
    # @return  [void]
    #
    def print_duplicate_entries(duplicate_entries)
      message = "#### Found duplicate entries in Localizable.strings files \n\n"

      message << "| File | Key |\n"
      message << "| ---- | --- |\n"

      duplicate_entries.each do |entry|
        file = entry['file']
        key = entry['key']

        message << "| #{file} | #{key} | \n"
      end

      markdown message
    end

    #
    # Checks whether there are any duplicated entries in all Localizable.strings
    # files and prints out any found duplicates.
    #
    # @return  [void]
    #
    def check_localizable_duplicates
      entries = localizable_duplicate_entries
      print_duplicate_entries entries unless entries.empty?
    end
  end
end
