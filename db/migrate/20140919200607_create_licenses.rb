class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.text :title
      t.string :shortcut
    end

    create_table :licenses_users, :id => false do |t|
      t.integer :license_id
      t.integer :user_id
    end

    licenses = {
      "Lizenz Halbtagesseminar" => "Lizenz HTS",
      "Lizenz Tagesseminar 'Was sieht man und was bedeutet das? - Der Alltag der Häftlinge in Bildern und Berichten'" => "Lizenz TS Allt.",
      "Lizenz Tagesseminar 'Menschenrechtsverletzungen im Konzentrationslager Dachau - Die KZ-Gedenkstätte Dachau als Lernort für Menschenrechte'" => "Lizenz TS Mensch.",
      "Lizenz Tagesseminar 'Was geht mich das an? - Erinnerungskultur und Formen des Gedenkens auf dem Gelände der KZ-Gedenkstätte Dachau'" => "Lizenz TS Erinn."
    }

    licenses.each do |text, cut|
      License.create(title: text, shortcut: cut)
    end

    Referent.all.each do |referent|
      if referent.lizenz_hts or referent.lizenz_ts_all or referent.lizenz_ts_men or referent.lizenz_ts_er
        user = User.find_by(referent_id: referent.id)

        if user

          if referent.lizenz_hts
            license = License.find_by(shortcut: "Lizenz HTS")
            user.licenses << license
          end

          if referent.lizenz_ts_all
            license = License.find_by(shortcut: "Lizenz TS Allt.")
            user.licenses << license
          end

          if referent.lizenz_ts_men
            license = License.find_by(shortcut: "Lizenz TS Mensch.")
            user.licenses << license
          end

          if referent.lizenz_ts_er
            license = License.find_by(shortcut: "Lizenz TS Erinn.")
            user.licenses << license
          end
        end

      end
    end

  end
end
