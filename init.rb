require 'redmine'

require_dependency File.dirname(__FILE__) + '/app/helpers/mailer_patch'
require_dependency File.dirname(__FILE__) + '/app/helpers/settings_controller_patch'

Redmine::Plugin.register :akayagi do
  name 'Akayagi plugin'
  author 'Shunsuke Ohtani'
  description 'Akayagi san kara otegami tsuita!'
  version '0.0.1'
  url ''
  author_url 'http://www.zaneli.com/'

  permission :akayagi_settings, {:akayagi => [:settings]}
end

Rails.configuration.to_prepare do
  unless ProjectsHelper::included_modules.include? ProjectsHelperPatch
    ProjectsHelper::send(:include, ProjectsHelperPatch)
  end
end
