require 'net/ssh'
class DeviceFetch

  def self.run_command(ip,cmd)
   
    # Read login from auth file in root
    contentsArray=[]  
    f = File.open('auth')
    f.each_line {|line|
       contentsArray.push line
    }

    @username = contentsArray[0].delete("\n")
    @password = contentsArray[1].delete("\n")

    begin
        ssh = Net::SSH.start(ip, @username, :password => @password)
        res = ssh.exec!(cmd)
        ssh.close
        return res
    rescue
        return "Unable to connect to #{@hostname} using #{@username}/#{@password}"
    end 
  end

  def get_serial(ip)
     cmd = "cli show version"
     res = DeviceFetch.run_command(ip,cmd)
     return res.lines[1] 
  end

  def get_model(ip)
     cmd = "cli show version"
     res = DeviceFetch.run_command(ip,cmd)
     return res.lines[1]
  end
end
