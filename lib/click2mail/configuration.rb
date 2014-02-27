module Click2Mail
  class Configuration

    attr_accessor :username, :password, :target
    def initialize(config={})
      config = Configuration.default_config if config.empty?
      config.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def self.default_config
      return {
        username:       'Customerlobby',
        password:       'RvjpCKP42iCDZa',
        target:         'stage-batch',
      }
    end

    def self.configure(opts = {})
      config = Configuration.default_config
      valid_keys = config.keys
      opts.each { |k,v| config[k.to_sym] = v if valid_keys.include? k.to_sym }

      return Configuration.new(@config)
    end

    def self.configure_with(path_to_yaml_file, environment='')
      begin
        yaml_values = YAML::load(IO.read(path_to_yaml_file))
      rescue => e
        raise "YAML configuration file couldn't be found: #{e}"
      end

      yaml_values = yaml_values[environment] unless environment.blank?

      configure(yaml_values)
    end
  end
end
