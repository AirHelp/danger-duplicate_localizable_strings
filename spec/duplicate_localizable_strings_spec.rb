require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerDuplicateLocalizableStrings do
    it 'should be a plugin' do
      expect(Danger::DangerDuplicateLocalizableStrings.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @plugin = @dangerfile.duplicate_localizable_strings

        allow(@plugin.git).to receive(:deleted_files).and_return([])
      end

      context 'when there are Localizable.strings files in changeset' do
        context 'when the Localizable.strings file contains duplicates' do
          before do
            allow(@plugin.git).to receive(:modified_files)
              .and_return(['spec/fixtures/LocalizableWithDuplicates1.strings'])
            allow(@plugin.git).to receive(:added_files)
              .and_return(['spec/fixtures/LocalizableWithDuplicates2.strings'])

            @plugin.check_localizable_duplicates
            @output = @plugin.status_report[:markdowns].first
          end

          it 'contains header' do
            expect(@output).to include('Found duplicate entries in Localizable.strings files')
          end

          it 'contains information about key from first file' do
            expect(@output).to include('| spec/fixtures/LocalizableWithDuplicates1.strings | "Fixture Key 2 In File 1" |')
          end

          it 'contains infromation about key from second file' do
            expect(@output).to include('| spec/fixtures/LocalizableWithDuplicates2.strings | "Fixture Key 3 In File 2" |')
          end
        end

        context 'when the Localizable.strings file does not contain duplicates' do
          before do
            allow(@plugin.git).to receive(:modified_files)
              .and_return(['spec/fixtures/ModifiedSwiftFile.swift'])
            allow(@plugin.git).to receive(:added_files)
              .and_return(['spec/fixtures/LocalizableWithoutDuplicates.strings'])

            @plugin.check_localizable_duplicates
          end

          it 'does not warn about duplicate entries in Localizable.strings' do
            expect(@plugin.status_report[:markdowns].first).to be_nil
          end
        end
      end

      context 'when there are no Localizable.strings files in changeset' do
        before do
          allow(@plugin.git).to receive(:modified_files)
            .and_return(['spec/fixtures/ModifiedSwiftFile.swift'])
          allow(@plugin.git).to receive(:added_files)
            .and_return(['spec/fixtures/AddedSwiftFile.swift'])

          @plugin.check_localizable_duplicates
        end

        it 'does not warn about duplicate entries in Localizable.strings' do
          expect(@plugin.status_report[:markdowns].first).to be_nil
        end
      end
    end
  end
end
