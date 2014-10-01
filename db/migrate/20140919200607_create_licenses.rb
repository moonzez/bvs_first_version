class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.text :title
      t.string :shortcut
    end

    create_table :licenses_users, id: false do |t|
      t.integer :license_id
      t.integer :user_id
    end

    fill_licenses
    add_licenses_to_users
  end

  def fill_licenses
    licenses = {
      'Lizenz Halbtagesseminar' => 'Lizenz HTS',
      'Lizenz Tagesseminar "Was sieht man und was bedeutet das? - Der Alltag der Häftlinge in Bildern und Berichten"' => 'Lizenz TS Allt.',
      'Lizenz Tagesseminar "Menschenrechtsverletzungen im Konzentrationslager Dachau - Die KZ-Gedenkstätte Dachau als Lernort für Menschenrechte"' => 'Lizenz TS Mensch.',
      'Lizenz Tagesseminar "Was geht mich das an? - Erinnerungskultur und Formen des Gedenkens auf dem Gelände der KZ-Gedenkstätte Dachau"' => 'Lizenz TS Erinn.'
    }

    licenses.each do |text, cut|
      License.create(title: text, shortcut: cut)
    end
  end

  def add_licenses_to_users
    Referent.all.each do |referent|
      next unless (referent.lizenz_hts || referent.lizenz_ts_all || referent.lizenz_ts_men || referent.lizenz_ts_er)
      user = User.find_by(referent_id: referent.id)
      next unless user

      if referent.lizenz_hts
        license = License.find_by(shortcut: 'Lizenz HTS')
        user.licenses << license
      end

      if referent.lizenz_ts_all
        license = License.find_by(shortcut: 'Lizenz TS Allt.')
        user.licenses << license
      end

      if referent.lizenz_ts_men
        license = License.find_by(shortcut: 'Lizenz TS Mensch.')
        user.licenses << license
      end

      if referent.lizenz_ts_er
        license = License.find_by(shortcut: 'Lizenz TS Erinn.')
        user.licenses << license
      end
    end
  end
end
