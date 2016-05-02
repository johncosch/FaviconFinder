require 'sequel'

Sequel.migration {
  up do
    create_table(:favicons) do
      primary_key :id
      String :url, null: false, :index
      String :fav_url, null: false
      DateTime :created_at
    end
  end

  down do
    drop_table(:favicons)
  end
}
