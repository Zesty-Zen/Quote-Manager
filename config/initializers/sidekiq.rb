require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.config_for(:cable)['url'] }
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('config/sidekiq_schedule.yml', __dir__)) || {}
    Sidekiq::Cron::Job.load_from_hash(Sidekiq.schedule)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.config_for(:cable)['url'] }
end