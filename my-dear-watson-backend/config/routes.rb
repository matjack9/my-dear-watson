Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/analysis_metadata/:id/consumption_preferences', to: 'analysis_metadata#consumption_preferences'
      get '/analysis_metadata/:id/values', to: 'analysis_metadata#values'
      get '/analysis_metadata/:id/needs', to: 'analysis_metadata#needs'
      get '/analysis_metadata/:id/personalities', to: 'analysis_metadata#personalities'
      # resources :word_counts, only: [:index]
      # resources :consumption_preferences, only: [:index]
      # resources :values, only: [:index]
      # resources :needs, only: [:index]
      # resources :personalities, only: [:index]
      resources :twitter_accounts do
        get '/word_counts', to: 'word_counts#word_count'
        get '/consumption_preferences', to: 'consumption_preferences#consumption_preference'
        get '/values', to: 'values#value'
        get '/needs', to: 'needs#need'
        get '/personalities', to: 'personalities#personality'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
