Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # We run development instance locally and remotely.
  # This check is required to disable dev error messages on remote dev environment.
  config.consider_all_requests_local = ENV['LOCAL_DEV_INSTANCE'] == 'true'

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = false

  # Mount Action Cable outside main process or domain
  config.action_cable.mount_path = '/api/cable'
  # config.action_cable.url = [/ws:\/\/*/, /wss:\/\/*/]
  config.action_cable.allowed_request_origins = Rails.application.secrets.allowed_origins

  # Application Load Balancer enforces ssl security.
  # The ALB forces SSL for external APIs, internal APIs are served over http.
  config.force_ssl = false

  # config.action_mailer.default_url_options = { host: ENV.fetch('SERVER_URL').split(',').first }
  # config.action_mailer.default_options = { from: "#{ENV['SMTP_FROM_NAME']} <#{ENV['SMTP_FROM_ADDR']}>" }
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.smtp_settings = {
  #   authentication: :login,
  #   address: ENV['SMTP_HOST'],
  #   port: ENV['SMTP_PORT'],
  #   user_name: ENV['SMTP_USER'],
  #   password: ENV['SMTP_PASSWORD']
  # }

  config.action_mailer.perform_caching = false
  config.action_mailer.show_previews = ENV['LOCAL_DEV_INSTANCE'] == 'true'

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  # Not needed, because the same is implemented in CustomAppLoggerFormatter
  config.active_record.verbose_query_logs = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.i18n.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Used to validate the Host header. Allows prevent DNS rebinding attacks.
  # config.hosts.push *ENV.fetch('SERVER_URL').split(',').map { |s| URI.parse(s).authority }

  empty_logger = Logger.new(nil)
  file_logger = Logger.new(config.paths['log'].first, 100, 50.megabytes)
  stdout_logger = Logger.new(STDOUT)
  # mail_logger = MailLogger.new(STDOUT)

  # config.log_formatter = CustomAppLoggerFormatter.new
  # file_logger.formatter = config.log_formatter
  # stdout_logger.formatter = config.log_formatter
  # mail_logger.formatter = config.log_formatter

  # config.action_view.logger = empty_logger
  config.active_record.logger = ActiveSupport::TaggedLogging.new(file_logger)
  config.logger = ActiveSupport::TaggedLogging.new(stdout_logger)
  # config.action_mailer.logger = mail_logger

  # config.after_initialize do
    # Bullet.enable = config.consider_all_requests_local
    # Bullet.sentry = true
    # Bullet.console = true
    # Bullet.bullet_logger = true
    # Bullet.rails_logger = true
  # end
end