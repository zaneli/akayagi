class AkayagiController < ApplicationController

  def save
    project = Project::find(params[:project_id])
    begin
      @settings = AkayagiProjectSettings::find_or_create_by(project_id: project.id)
      @settings.subject_prefix = params[:subject_prefix]
      @settings.from_address = params[:from_address]
      @settings.to_address = params[:to_address]
      @settings.cc_address = params[:cc_address]
      @settings.bcc_address = params[:bcc_address]
      @settings.save
      flash[:notice] = l(:notice_successful_update)
    rescue => e
      flash[:error] = e.message
    ensure
      redirect_to :controller => 'projects', :action => "settings", :id => project, :tab => 'akayagi'
    end
  end
end
