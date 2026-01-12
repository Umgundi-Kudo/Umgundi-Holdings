require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Reload application code on every request
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  
  # Action Mailer (REAL EMAILS)
  
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  # Use ngrok for email links
  config.action_mailer.default_url_options = {
    host: "noninfusible-preconsonantal-will.ngrok-free.dev",
    protocol: "https"
  }

  # Gmail SMTP 
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    authentication: "plain",
    enable_starttls_auto: true
  }

  # -----------------------------
  # Logging & debugging
  # -----------------------------
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  # Raise error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight background jobs in logs.
  config.active_job.verbose_enqueue_logs = true

  # Suppress asset request logs.
  config.assets.quiet = true

  # Raise error when a before_action references missing actions
  config.action_controller.raise_on_missing_callback_actions = true
end
