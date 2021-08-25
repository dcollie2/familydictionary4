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

  task :audio => :environment do

    CSV.foreach("docs/tmp_migration/words_export.csv", :headers => true, liberal_parsing: {double_quote_outside_quote: true}) do |row|
      puts "#{row['word']} - #{row['audio_file_name']}"
      unless row['audio_file_name'].blank?
        # find the word
        word = Word.friendly.find(row['word'].downcase)
        if word.blank?
          puts "WORD NOT FOUND------#{row['word']}"
        else
          begin
            src =  "https://s3.amazonaws.com/familydictionary2.net/original/#{row['audio_file_name']}"
            word.audio.purge
            word.audio.attach(io: URI.open(src), filename: row['audio_file_name'], content_type: row['audio_content_type'])
          rescue => e
            puts "------ERROR GETTING #{row['word']}"
          end
        end
      else
        puts 'No audio'
      end
    end
  end

  task :pages => :environment do
    include ActionView::Helpers::TextHelper
    CSV.foreach("docs/tmp_migration/pages_export.csv", :headers => true, liberal_parsing: {double_quote_outside_quote: true}) do |row|
      record = row.to_hash.symbolize_keys.except!(:id)
      new_page = Page.find_or_create_by(permalink: record[:permalink], title: record[:title])
      new_page.update(contents: simple_format(record[:contents]))
      puts record.inspect
      puts '------'

    end
  end

  task :reset => :environment do
    Word.destroy_all
  end

end
