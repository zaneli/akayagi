require_dependency "settings_controller"

module SettingsControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :index, :akayagi
      alias_method_chain :edit, :akayagi
    end
  end
end

module InstanceMethods
  def index_with_akayagi
    @akayagi_general_subject_prefix = get_general_subject_prefix
    index_without_akayagi
  end

  def edit_with_akayagi
    if request.post? && params[:settings] && params[:settings].is_a?(Hash)
      akayagi_general_setting = AkayagiGeneralSettings::find1_or_create
      akayagi_general_setting.subject_prefix = params[:subject_prefix]
      akayagi_general_setting.save
    else
      @akayagi_general_subject_prefix = get_general_subject_prefix
    end
    edit_without_akayagi
  end

  private
  def get_general_subject_prefix
    AkayagiGeneralSettings::safe_subject_prefix
  end
end

SettingsController::send(:include, SettingsControllerPatch)
