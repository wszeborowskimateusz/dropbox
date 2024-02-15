# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
# Indexes
#
#  index_organizations_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  parent_id  (parent_id => organizations.id)
#
class Organization < ApplicationRecord
    belongs_to :parent, class_name: 'Organization', optional: true

    has_many :organization_users, dependent: :destroy
    has_many :attachments, dependent: :destroy
    has_many :children, inverse_of: :parent, class_name: 'Organization', foreign_key: :parent_id, dependent: :destroy
end
