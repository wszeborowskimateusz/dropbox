class AddParentOrganizationToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_reference :organizations, :parent, null: true, foreign_key: { to_table: :organizations }
  end
end
