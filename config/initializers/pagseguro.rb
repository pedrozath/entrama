PagSeguro.configure do |config|
    config.token       = ENV["TOKEN_PAGSEGURO"]
    config.email       = ENV["EMAIL"]
    config.environment = :sandbox
    config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end