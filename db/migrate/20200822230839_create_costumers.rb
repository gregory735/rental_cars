class CreateCostumers < ActiveRecord::Migration[6.0]
  def change
    create_table :costumers do |t|
      t.string :name
      t.string :cpf
      t.string :email

      t.timestamps
    end
  end
end
