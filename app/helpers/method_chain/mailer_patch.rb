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
    project_settings = get_project_settings(mail.header["X-Redmine-Project"])
    mail.subject = get_prefix(project_settings) + mail.subject
    mail.from = get_from(project_settings, mail.from)
    mail.to = get_to(project_settings, mail.to)
    mail.cc = get_cc(project_settings, mail.cc)
    mail.bcc = get_bcc(project_settings, mail.bcc)
    deliver_mail_without_akayagi(mail, &block)
  end

  private
  def get_project_settings(project_identifier)
    if project_identifier.blank?
      nil
    else
      project = Project::find_by_identifier(project_identifier.to_s)
      AkayagiProjectSettings::find_by_project_id(project.id)
    end
  end

  def get_prefix(project_settings)
    if project_settings.nil? || project_settings.subject_prefix.nil?
      AkayagiGeneralSettings::safe_subject_prefix
    else
      project_settings.subject_prefix
    end
  end

  def get_from(project_settings, org_from)
    if project_settings.nil? || project_settings.from_address.blank?
      org_from
    else
      project_settings.from_address
    end
  end

  def get_to(project_settings, org_to)
    if project_settings.nil? || project_settings.to_address.blank?
      org_to
    elsif org_to.nil?
      project_settings.to_address.split(",")
    else
      org_to + project_settings.to_address.split(",")
    end
  end

  def get_cc(project_settings, org_cc)
    if project_settings.nil? || project_settings.cc_address.blank?
      org_cc
    elsif org_cc.nil?
      project_settings.cc_address.split(",")
    else
      org_cc + project_settings.cc_address.split(",")
    end
  end

  def get_bcc(project_settings, org_bcc)
    if project_settings.nil? || project_settings.bcc_address.blank?
      org_bcc
    elsif org_bcc.nil?
      project_settings.bcc_address.split(",")
    else
      org_bcc + project_settings.bcc_address.split(",")
    end
  end
end

Mailer::send(:include, MailerPatch)

