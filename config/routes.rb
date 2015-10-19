RedmineApp::Application.routes.draw do
  match '/akayagi/save', :to => 'akayagi#save', :via => [:post, :patch]
end

