class SecretFile
  #attr_reader :data

  def initialize(secret_data)
    @data = secret_data
    @logger = logger
  end

  def data
    @logger.create_log_enter
    @data
  end
end

class SecurityLogger
  def create_log_entry
  end
end
