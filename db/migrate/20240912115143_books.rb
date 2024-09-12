class Books < ActiveRecord::Migration[7.1]

  def change
    create_table :authors do |t|
      t.string :nama

      t.timestamps
    end


    create_table :books do |t|
      t.string :judul
      t.integer :tahun_terbit
      t.belongs_to :author, foreign_key: true

      t.timestamps
    end


  end
end
