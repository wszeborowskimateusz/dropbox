class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.where(organization_id: organization_ids_for_attachments)
  end

  def new
    @attachment = Attachment.new
  end

  def create
    org_id = current_user.organization.id

    @attachment = Attachment.new(attachment_params.merge({ organization_id: org_id }))
    if @attachment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    redirect_to root_path
  end

  private

  def attachment_params
    params.require(:attachment).permit(:name, files: [])
  end

  def organization_ids_for_attachments
    main_org = current_user.organization
    ids = []

    ids << main_org.id
    ids += get_parent_orgs_ids(main_org)
    ids += get_children_org_ids(main_org)

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
