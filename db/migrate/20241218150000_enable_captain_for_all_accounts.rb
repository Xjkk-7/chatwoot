class EnableCaptainForAllAccounts < ActiveRecord::Migration[7.0]
  def up
    # Enable captain_integration feature for all existing accounts
    Account.find_each do |account|
      account.enable_features!('captain_integration')
    end
  end

  def down
    # Disable captain_integration feature for all accounts (rollback)
    Account.find_each do |account|
      account.disable_features!('captain_integration')
    end
  end
end 