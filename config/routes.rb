Rails.application.routes.draw do
  get '/random'=>'wiki#random_names_front'
  get '/:name' => 'wiki#name_return_links_front'
  
end
