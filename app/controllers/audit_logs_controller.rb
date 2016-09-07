class AuditLogsController < ApplicationController

  def index
  	@audit_logs = AuditLog.page(params[:page]).per(10)
  	authorize @audit_logs
  end

  def confirm
  	audit_log = AuditLog.find(params[:id])
    authorize audit_log
  #  raise
  	audit_log.confirmed!
  	flash[:notice] = "Thank you, your confirmation was successfully made."
  	redirect_to root_url
  end

end

