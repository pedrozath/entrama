PagSeguro.configure do |config|
    config.token       = ENV["TOKEN_PAGSEGURO"]
    config.email       = ENV["EMAIL"]
    config.environment = ENV["PAGSEGURO_ENV"].to_sym
    config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end