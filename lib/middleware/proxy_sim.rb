module Cfg
  class ProxySim
    def initialize(app)
      @app = app
    end

    def call(env)
      unless Rails.env.production?
        file_path = "#{Rails.root}/config/proxy_sim.yml"
        unless File.exists?(file_path)
          proxy_sim_yml = <<eos
HTTP_SSL_CLIENT_S_DN: CN=USER JOE J,OU=,OU=,OU=,O=,C=
HTTP_SSL_CLIENT_S_DN_CN: USER JOE J
eos
          File.open(file_path, 'w') {|f| f.write(proxy_sim_yml)}
        end

        headers = YAML.load_file(file_path)
        env.merge!(headers)
      end
      @app.call(env)
    end
  end
end