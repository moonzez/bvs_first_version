class MigrateDetoursToGuidedtours < ActiveRecord::Migration
  def change
    film_states = { 'nein' => 0, 'no' => 0, 'ja' => 1 }

    genders = {
      'Herr' => :mr, 'Frau' => :mrs, 'Frau Dr.' => :mrs, 'Frau Prof.' => :mrs, 'Herr' => :mr,
      'Herr Prof.' => :mr, 'Herr Pfarrer' => :mr, 'Herr Pastor' => :mr, 'Miss' => :miss, 'Herr Dr.' => :mr,
      'Mr' => :mr, 'Mrs.' => :mrs, 'Mrs' => :mrs, 'Mr.' => :mr, 'Herr Hauptmann' => :mr, 'Ms' => :ms,
      'Signor' => :mr, 'Sr' => :mr, 'Signora' => :mrs, '.' => :mr
    }

    titles = {
      'Herr' => '', 'Frau' => '', 'Frau Dr.' => 'Dr.', 'Frau Prof.' => 'Prof.', 'Herr Prof.' => 'Prof.',
      'Herr Pfarrer' => 'Pfarrer', 'Herr Pastor' => 'Pastor', 'Miss' => '', 'Mr' => '', 'Mrs.' => '',
      'Mrs' => '', 'Mr.' => '', 'Herr Hauptmann' => 'Hauptmann', 'Ms' => '', 'Signor' => '', 'Sr' => '',
      'Signora' => '', '.' => ''
    }

    languages = {
      'Deutsch' => 'de',
      'Französisch' => 'fr',
      'Spanisch' => 'es',
      'Englisch' => 'en',
      'Italienisch' => 'it',
      'Tschechisch' => 'sc',
      'Russisch' => 'ru',
      'Hebräisch' => 'he',
      'Polnisch' => 'pl',
      'Arabisch' => 'ar',
      'Japanisch' => 'ja',
      'Finnisch' => 'fi',
      'Griechisch' => 'el',
      'Slovenisch' => 'sl',
      'Slowakisch' => 'sk',
      'English' => 'en'
    }

    form_lang = {
      'ger' => 'de',
      'eng' => 'en',
      'fr' => 'fr',
      'it' => 'it'
    }

    current_states = {
      'bestätigt' => :confirmed, 'bestatigt' => :confirmed, 'abgesagt' => :rejected,
      'storniert' => :canceled, 'offen' => :opened
    }

    havebeens = { 'zum Teil' => :some, 'nein' => :no, 'ja' => :yes, 'some' => :some }

    theme_types = { nil => 0, 'Theme' => 1, 'Exkursion' => 2 }

    paids = {
      'nein' => :not_paid,
      'ja,überwiesen' => :transferred,
      'ja,uberwiesen' => :transferred,
      'ja,bar' => :cash,
      'kostenfrei' => :costfree
    }

    Detour.all.each do |g|
      gt = Guidedtour.new(
        gender: genders[g.gender],
        title: titles[g.gender],
        firstname: g.firstname,
        lastname: g.lastname,
        telbus: g.telbus,
        telbus_time: g.telbusTime,
        telpriv: g.telpriv,
        telpriv_time: g.telprivTime,
        email: g.email.strip,
        fax: g.fax,
        schoolname: g.schoolname,
        schooltype: g.schooltype,
        street: g.street,
        city: g.city,
        zip: g.zip,
        country: g.country,
        date1: g.date1,
        from1: g.from1,
        to1: g.to1,
        date2: g.date2,
        from2: g.from2,
        to2: g.to2,
        date3: g.date3,
        from3: g.from3,
        to3: g.to3,
        participants: g.participnumber,
        groupnumber: g.groupnumber,
        male_count: g.male,
        female_count: g.female,
        age: g.age,
        schoolgrade: g.schoolgrade,
        teamleader: g.teamleader,
        cellphone: g.cellphone,
        confirmeddate: g.thedate,
        confirmedfrom: g.thefrom,
        confirmedto: g.theto,
        language: languages[g.language],
        havebeen: havebeens[g.havebeen],
        reason: g.reason,
        topic: g.topic,
        munichstay: g.municstay,
        wish: g.wish,
        remarc: g.remarc,
        state: current_states[g.status],
        form_language: form_lang[g.formular],
        film: film_states[g.film],
        last_changed_by: g.last_change,
        given_price: get_price_int(g.given_price),
        paid_price: get_price_int(g.paid_price),
        paid_external_by: g.set_paid_external,
        paid_external_on: g.set_paid_date,
        themetour: g.themetour,
        themetour_type: theme_types[g.theme_type],
        result_sent: g.result_sent,
        comments: g.comments,
        infopoint: g.infopoint,
        invoice: g.invoice,
        invoice_number: g.invoice_number,
        paid: paids[g.paid],
        bill_sent: g.bill_sent,
        hl_number: g.hl_number,
        denial_sent_on: g.denial_date,
        mahnung_sent: g.mahnung,
        mahnung_sent_on: g.mahnungdate,
        storno_sent_on: g.storno_date,
        created_at: g.created_at,
        updated_at: g.updated_at
      )
      write_log_file(g.id, gt) unless gt.save
    end
  end
  # t.string   "zus_form",                                  default: "nein"
  # t.string   "zus_voll",                                  default: "nein"
  # t.date     "zf_date"
  # t.date     "zv_date"

  def get_price_int(price)
    return 0 if price.nil? || price == 0.0
    (price * 100).to_i
  end

  def write_log_file(detour_id, guidedtour)
    my_logger_file = Logger.new("#{Rails.root}/log/detour_migration_log.log")

    my_logger_file.info("\n\n\nDetour ID #{ detour_id }")
    my_logger_file.info("\n#{ guidedtour.inspect }")
    guidedtour.errors.each do |key, value|
      my_logger_file.info("\n#{ key }: #{ value }")
    end
  end
end
