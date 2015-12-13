Rails.application.routes.draw do
  get '/random'=>'wiki#cale_random_front'
  get '/:name' => 'wiki#name_return_links_front'
  
end
