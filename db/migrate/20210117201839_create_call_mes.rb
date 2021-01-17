class CreateCallMes < ActiveRecord::Migration[6.1]
  def change
    create_table :call_mes do |t|
      t.string :phone

      t.timestamps
    end
  end
end
