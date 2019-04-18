class DocumentsFlowController < ApplicationController
  include FileConcern
  set_attachment_names :file
  set_file_params_key :document

  include DocumentsHelper
  include Wicked::Wizard
  steps :upload, :metadata

  before_action :set_parent
  before_action :set_file, only: %i[show update]

  def show;
    render_wizard
  end

  def new
    initialize_file_attachments
    redirect_to wizard_path(steps.first, request.query_parameters)
  end

  def update
    if @document_model.update_file(get_attachment_metadata_params(:file))
      return redirect_to next_wizard_path unless step == steps.last

      @document_model.attach_blob_to_list(@parent.documents)
      AuditActivity::Document::Add.from(@document_model.file, @parent) if @parent.is_a? Investigation
      redirect_to @parent
    else
      render step
    end
  end

private

  def set_file
    file_blob, * = load_file_attachments
    required_fields = [:file]
    required_fields << :title if step == :metadata
    @document_model = Document.new(file_blob, required_fields)
  end
end
