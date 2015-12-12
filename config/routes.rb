Rails.application.routes.draw do
  post '/index/:name' => 'wiki#name_reurn_links_front'
  post '/index/'=>'wiki#random_names_front'
end
