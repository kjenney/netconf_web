require 'net/netconf'

# create the options hash for the new NETCONF session.  If you are
# using ssh-agent, then omit the :password

unless ARGV[0]
   puts "You must specify a target"
   exit 1
end

# login information for NETCONF session
login = { :target => ARGV[0], :username => 'vmc'  }


# provide a block and the session will open, execute, and close

Netconf::SSH.new( login ){ |dev|

  # perform the RPC command:
  # <rpc>
  #    <get-chassis-inventory/>
  # </rpc>

  inv = dev.rpc.get_chassis_inventory
 
  # The response is in Nokogiri XML format for easy processing ...

  puts "Chassis: " + inv.xpath('chassis/description').text
  puts "Chassis Serial-Number: " + inv.xpath('chassis/serial-number').text
}
