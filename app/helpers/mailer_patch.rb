require_dependency "mailer"

module MailerPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.class_eval do
      class << self
        alias_method_chain :deliver_mail, :akayagi
      end
    end
  end
end

module ClassMethods
  def deliver_mail_with_akayagi(mail, &block)
    project_identifier = mail.header["X-Redmine-Project"]
    mail.subject = get_prefix(project_identifier) + mail.subject
    mail.from = get_from(project_identifier, mail.from)
    deliver_mail_without_akayagi(mail, &block)
  end

  private
  def get_prefix(project_identifier)
    if project_identifier.blank?
      AkayagiGeneralSettings::safe_subject_prefix
    else
      project = Project::find_by_identifier(project_identifier.to_s)
      project_settings = AkayagiProjectSettings::find_by_project_id(project.id)
      if project_settings.nil? || project_settings.subject_prefix.nil?
        AkayagiGeneralSettings::safe_subject_prefix
      else
        project_settings.subject_prefix
      end
    end
  end

  def get_from(project_identifier, org_from)
    if project_identifier.blank?
      org_from
    else
      project = Project::find_by_identifier(project_identifier.to_s)
      project_settings = AkayagiProjectSettings::find_by_project_id(project.id)
      if project_settings.nil?
        org_from
      else
        if project_settings.from_address.blank?
          org_from
        else
          project_settings.from_address
        end
      end
    end
  end
end

Mailer::send(:include, MailerPatch)
