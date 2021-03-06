class AkayagiGeneralSettings < ActiveRecord::Base
  unloadable

  def self::find_first_or_create
    akayagi_general_settings = self::first
    if akayagi_general_settings.nil?
      return self::create
    end
    akayagi_general_settings
  end

  def self::safe_subject_prefix
    akayagi_general_settings = self::first
    if akayagi_general_settings.nil?
      ""
    else
      akayagi_general_settings.subject_prefix.to_s #convert nil to empty string
    end
  end
end
