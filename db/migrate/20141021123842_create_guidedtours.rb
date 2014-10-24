class CreateGuidedtours < ActiveRecord::Migration
  def change
    create_table :guidedtours do |t|
      t.integer  :gender
      t.string   :title
      t.string   :firstname
      t.string   :lastname
      t.string   :telbus
      t.string   :telbus_time
      t.string   :telpriv
      t.string   :telpriv_time
      t.string   :email
      t.string   :fax
      t.string   :schoolname
      t.string   :schooltype
      t.string   :street
      t.string   :city
      t.string   :zip
      t.string   :country

      t.date     :date1
      t.time     :from1
      t.time     :to1
      t.date     :date2
      t.time     :from2
      t.time     :to2
      t.date     :date3
      t.time     :from3
      t.time     :to3

      t.integer  :participants
      t.integer  :groupnumber
      t.integer  :male_count
      t.integer  :female_count
      t.string   :age
      t.string   :schoolgrade
      t.integer  :teamleader
      t.string   :cellphone

      t.date     :confirmeddate
      t.time     :confirmedfrom
      t.time     :confirmedto

      t.integer  :language, default: 0
      t.integer  :havebeen, default: 0
      t.text     :reason
      t.text     :topic
      t.text     :munichstay
      t.text     :wish
      t.text     :remarc

      t.integer  :lock_vers, default: 0
      t.integer  :state, default: 0
      t.string   :form_language, default: 'de'
      t.integer  :film, default: 0

      t.string   :last_changed_by
      t.datetime :last_changed_on
      t.integer  :given_price, default: 0
      t.integer  :paid_price, default: 0

      t.string   :paid_external_by
      t.datetime :paid_external_on

      t.boolean  :themetour, default: false
      t.string   :themetour_type
      t.boolean  :result_sent, default: false

      t.text     :comments
      t.text     :infopoint

      t.integer  :invoice, default: 1
      t.string   :invoice_number
      t.integer  :paid, default: 0
      t.integer  :bill_sent, default: 0
      t.string   :hl_number

      t.datetime :denial_sent_on
      t.integer  :mahnung_sent,  default: 0
      t.datetime :mahnung_sent_on
      t.datetime :storno_sent_on

      t.timestamps
    end
  end
end
