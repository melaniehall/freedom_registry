class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
       t.integer :id
        t.string :name
          t.text :mission_statement
        t.string :address_line1
        t.string :address_line2
        t.string :city
        t.string :state
        t.string :zip
        t.string :country
        t.string :mailing_address_line1
        t.string :mailing_address_line2
        t.string :mailing_city
        t.string :mailing_state
        t.string :mailing_zip
        t.string :mailing_country
        t.string :contact_name
        t.string :contact_email
        t.string :contact_phone
        t.string :website
        t.string :facebook
        t.string :twitter
        t.string :youtube
        t.string :blog
        t.string :year_founded
       t.integer :organization_type_id
        t.string :irs_sub_section_code
       t.boolean :registered_with_state
    end
  end
end