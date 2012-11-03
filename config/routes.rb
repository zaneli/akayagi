RedmineApp::Application.routes.draw do
#  match '/projects/:project_id/akayagi', :to => 'akayagi#index'
  match '/akayagi/save', :to => 'akayagi#save'
end

