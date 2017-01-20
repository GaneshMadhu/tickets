class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.text    :created_by
      t.text    :description
      t.integer :severity                     , index: true
      t.integer :status                       , index: true
      t.integer :cancelled_reason
      t.text    :cancelled_other_description
      t.text    :comments

      t.timestamps
    end
  end
end
