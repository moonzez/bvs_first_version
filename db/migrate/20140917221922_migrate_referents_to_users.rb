class MigrateReferentsToUsers < ActiveRecord::Migration
  def change
    Referent.all.each do |r|

      password = r.id.to_s + r.lastname
      genders = { 'Frau' => 1, 'Herr' => 0 }
      states = { 'aktiv' => 0, 'inaktiv' => 1, 'temporary' => 2 }
      email = r.email.strip

      user = User.new(
        firstname: r.firstname,
        lastname: r.lastname,
        password: password,
        password_confirmation: password,
        created_at: r.created_at,
        email: email,
        referent_id: r.id,
        gender: genders[r.gender],
        tel: r.tel,
        tel2: r.tel2,
        remarc: r.remarc,
        activ: states[r.aktiv],
        zip: r.zip,
        city: r.city,
        street: r.street,
        country: r.country,
        bank: r.bank,
        blz: r.blz,
        konto: r.konto,
        honorar: r.honorar,
        username: email
      )

      write_log_file(r.id, user) unless user.save
    end
  end

  def write_log_file(referent_id, user)
    my_logger_file = Logger.new("#{Rails.root}/log/referent_migration_log.log")

    my_logger_file.info("\n\n\nReferent ID #{ referent_id }")
    my_logger_file.info("\n#{ user.inspect }")
    user.errors.each do |key, value|
      my_logger_file.info("\n#{ key }: #{ value }")
    end
  end
end
