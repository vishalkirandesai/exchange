# Enables the extension hstore
class EnableHstore < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore'
  end
end
