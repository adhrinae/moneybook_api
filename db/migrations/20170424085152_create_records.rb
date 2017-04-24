Hanami::Model.migration do
  change do
    create_table :records do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :amount,      Integer, null: false
      column :description, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
