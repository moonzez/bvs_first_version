class MigrateReferentsToUsers < ActiveRecord::Migration
  def change
    my_logger_file = Logger.new("#{Rails.root}/log/migration_log.log")

    Referent.all.each do |r|

      password = r.id.to_s + r.lastname
      genders = { "Frau" => 1, "Herr" => 0}
      state = { "aktiv" => 0, "inaktiv" => 1, "temporary" => 2 }

      user = User.new(
        firstname: r.firstname,
        lastname: r.lastname,
        password: password,
        password_confirmation: password,
        created_at: r.created_at,
        email: r.email.strip,
        referent_id: r.id,
        gender: genders[r.gender],
        tel: r.tel,
        tel2: r.tel2,
        remarc: r.remarc,
        activ: state[r.aktiv],
        zip: r.zip,
        city: r.city,
        street: r.street,
        country: r.country,
        bank: r.bank,
        blz: r.blz,
        konto: r.konto,
        honorar: r.honorar,
        username: r.email.strip
      )

      if !user.save
        my_logger_file.info("\n\n\nReferent ID #{r.id}")
        my_logger_file.info("\n#{user.inspect}")
        user.errors.each do |k, v|
          my_logger_file.info("\n#{k}: #{v}")
        end
      end

    end
  end
end
