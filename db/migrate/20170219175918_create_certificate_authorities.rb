class CreateCertificateAuthorities < ActiveRecord::Migration[5.0]
  def change
    create_table :certificate_authorities do |t|
      t.string :title
      t.text :intermediate
      t.text :root

      t.timestamps
    end
  end
end
