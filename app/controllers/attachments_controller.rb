class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.where(organization_id: organization_ids_for_attachments)
  end

  def new
    @attachment = Attachment.new
  end

  def create
    # TODO: Control which organization to add to?
    org_id = current_user.organizations.first.id

    @attachment = Attachment.new(attachment_params.merge({ organization_id: org_id }))
    if @attachment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:name)
  end

  def organization_ids_for_attachments
    main_orgs = current_user.organizations
    ids = []

    main_orgs.each do |org|
      ids << org.id
      ids += get_parent_orgs_ids(org)
      ids += get_children_org_ids(org)
    end

    ids
  end

  def get_parent_orgs_ids(org)
    ids = []
    curr_org = org.parent

    until curr_org.nil?
      ids << curr_org.id
      curr_org = curr_org.parent
    end

    ids
  end

  def get_children_org_ids(org)
    ids = []
    curr_orgs = org.children

    until curr_orgs.empty?
      ids = [*ids, *curr_orgs.pluck(:id)]
      new_curr_orgs = []

      curr_orgs.each do |org|
        new_curr_orgs += org.children
      end

      curr_orgs = new_curr_orgs
    end

    ids
  end
end
