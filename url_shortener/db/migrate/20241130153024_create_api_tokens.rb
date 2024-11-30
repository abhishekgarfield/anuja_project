class CreateApiTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :api_tokens do |t|
      t.string :token
      t.string :client_name
      t.datetime :expires_at

      t.timestamps
    end
  end
end
