require 'net/ssh'
class DeviceFetch

  @@username = "root"
  @@password = "password"

  def self.run_command(ip,cmd)
    begin
        ssh = Net::SSH.start(ip, @@username, :password => @@password)
        res = ssh.exec!(cmd)
        ssh.close
        return res
    rescue
        return "Unable to connect to #{@hostname} using #{@username}/#{@password}"
    end 
  end

  def get_serial(ip)
     cmd = "cli show configuration"
     res = DeviceFetch.run_command(ip,cmd)
     return res.lines[1] 
  end

  def get_model(ip)
     cmd = "cli show configuration"
     res = DeviceFetch.run_command(ip,cmd)
     return res.lines[1]
  end
end
