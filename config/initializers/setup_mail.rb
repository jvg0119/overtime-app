if Rails.env.development? || Rails.env.production?  # for both dev & production env
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sparkpostmail.com',
    port:           '587',
    authentication: :plain,
    user_name:      ENV['SPARKPOST_SMTP_USERNAME'],
    password:       ENV['SPARKPOST_SMTP_PASSWORD'],
    domain:         'heroku.com',
    enable_starttls_auto: true
  }
end

