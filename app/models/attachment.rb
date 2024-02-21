# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer          not null
#
# Indexes
#
#  index_attachments_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  organization_id  (organization_id => organizations.id)
#
class Attachment < ApplicationRecord
  validates :name, presence: true

  belongs_to :organization
  has_many_attached :files

  def can_delete(user)
    organization.id == user.organization.id
  end
end
