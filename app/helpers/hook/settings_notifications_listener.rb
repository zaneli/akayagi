class AccountListener < Redmine::Hook::ViewListener
  def view_settings_notification_for_akayagi(hash)
    subject_prefix = AkayagiGeneralSettings::safe_subject_prefix
    html = ""
    html << "<p>"
    html << "<label for=\"akayagi_general_subject_prefix\">#{l(:subject_prefix)}</label>"
    html << "<input id=\"akayagi_general_subject_prefix\" name=\"subject_prefix\" value=\"#{subject_prefix}\"/>"
    html << "</p>"
    html
  end
end
