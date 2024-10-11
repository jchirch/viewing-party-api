class AddHostToViewingPartyUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :viewing_party_users, :host, :boolean, default: true
  end
end
