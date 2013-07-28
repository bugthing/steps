
RSpec.configure do |config|
  config.color_enabled = true       # Use color in STDOUT
  config.tty = true                 # Use color not only in STDOUT but also in pagers and files
  config.formatter = :documentation # Use the specified formatter (:progress, :html, :textmate)
end

