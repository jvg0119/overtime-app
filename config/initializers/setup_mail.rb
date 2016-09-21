<<<<<<< HEAD
if Rails.env.development? || Rails.env.production?  # for both dev & production env
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sparkpostmail.com',
    port:           '587',
    authentication: :plain,
    user_name:      ENV['SPARKPOST_SMTP_USERNAME'],
    password:       ENV['SPARKPOST_SMTP_PASSWORD'],
=======
#if Rails.env.development?
if Rails.env.development? || Rails.env.production?  ## for production
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           '587',
    authentication: :plain,
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
>>>>>>> cadabdea8f2cbfb9f1a281c8a5e05cecc3446caf
    domain:         'heroku.com',
    enable_starttls_auto: true
  }
end
<<<<<<< HEAD

=======
>>>>>>> cadabdea8f2cbfb9f1a281c8a5e05cecc3446caf
