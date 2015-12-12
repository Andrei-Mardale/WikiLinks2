Rails.application.routes.draw do
  post '/:name' => 'wiki#name_reurn_links_front'
  post '/'=>'wiki#random_names_front'
end
