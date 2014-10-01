class MigrateReferentsLanguages < ActiveRecord::Migration
  def change
    create_languages

    Referent.all.each do |referent|
      user = User.find_by(referent_id: referent.id)
      next unless user
      (1..3).each do |num|
        language_str = referent.send("language#{num}")
        language_str = language_str.strip
        language = Language.find_by(language: language_str)

        user.languages << language if language
      end
    end
  end

  def create_languages
    languages = []

    Referent.all.each do |referent|
      (1..3).each do |num|
        language = referent.send("language#{num}")
        language = language.strip
        if !language.blank? && !languages.include?(language)
          languages << language
        end
      end
    end

    languages.each do |language|
      Language.create(language: language)
    end
  end
end
