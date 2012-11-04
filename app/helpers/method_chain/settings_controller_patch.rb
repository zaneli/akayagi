require_dependency "settings_controller"

module SettingsControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :edit, :akayagi
    end
  end
end

module InstanceMethods
  def edit_with_akayagi
    if request.post? && params[:settings] && params[:settings].is_a?(Hash)
      akayagi_general_setting = AkayagiGeneralSettings::find_first_or_create
      akayagi_general_setting.subject_prefix = params[:subject_prefix]
      akayagi_general_setting.save
    end
    edit_without_akayagi
  end
end

SettingsController::send(:include, SettingsControllerPatch)
