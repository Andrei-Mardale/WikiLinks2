Rails.application.routes.draw do
  get '/:name' => 'wiki#name_return_links_front'
  post '/'=>'wiki#random_names_front'
end
