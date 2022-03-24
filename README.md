TASK REPORT: Home Work Lesson 5


#TASK0001:Research how to connect to host  using only one command

    The best way is to setup SSH Port Forwarding

    Example: ssh -i ~/.ssh/somekey.pub username@host -L localport:RemoteHost:RemotePort
    *For background run use nohup utility and -N key:

    nohup ssh -i ~/.ssh/somekey.pub -L localport:RemoteHost:RemotePort -N &

    After setup SSH Port Forwarding we can access remote host with using
    only one command:

    Example: ssh -i ~/.ssh/somekey username@host

    Also we can use ssh ProxyCommand:

    ssh -i  ~/.ssh/somekey -0 ProxyCommand="ssh -W %h:%p $IpProxyHost" username@DestanationHost
    *You can add ProxyCommand settings to config file stored in ~/.ssh/

##TASK0002:Research how to create an alias for ssh connection

    For creating an aliace we need to create config file in ~/.ssh/ directory
    After creating the config file, we need add alias records in to the file
    Example:

		Host  myalias  --  Yours Alias
		UserName example.com --IP or DNS name of remote Host
		Port  0000 --Port number
		IdentityFIle ~/.ssh/id_rsa_remotesystem
		ProxyCommand ssh $IpProxyHost -W %h:%p

###TASK0003:Provide existing private and public ip addresses of deployed servers

   bastion_IP = 62.84.124.81

   someinternalhost_IP = 192.168.1.25

TASK REPORT: HOME WORK 6

testapp_IP = 51.250.2.185
testapp_port = 9292
