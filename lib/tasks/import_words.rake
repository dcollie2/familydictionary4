require 'csv'
namespace :import do
  task :words => :environment do
    CSV.foreach("docs/tmp_migration/words_export.csv", :headers => true, liberal_parsing: {double_quote_outside_quote: true}) do |row|
      record = row.to_hash.symbolize_keys.except!(:id, :audio_file_name, :audio_content_type, :audio_file_size, :audio_updated_at,
                                                 :illustration_file_name, :illustration_content_type, :illustration_file_size, :illustration_updated_at)
      record[:also_matches] = record[:also_matches].split(' ') if record[:also_matches].present?
      record[:definition] = ActionController::Base.helpers.strip_tags(record[:definition])
      # puts record
      # puts row.to_hash.except(:id, :audio_file_name, :audio_content_type, :audio_file_size, :audio_updated_at,
      #                        :illustration_file_name, :illustration_content_type, :illustration_file_size, :illustration_updated_at)
      Word.create!(record)
    end
    # Creation link check happens when some words aren't created yet, so force another check
    Word.all.each do |word|
      word.check_links
      word.save!
    end
  end

end
