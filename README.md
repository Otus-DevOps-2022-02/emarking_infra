
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

#################################################################################

TASK REPORT: HOME WORK 6

#TASK001: Create bash scripts for installing environment and deploy ruby app

install_ruby.sh - Makes install the Ruby env install_mongodb.sh - Makes install mongodb-org packeges deploy.sh - Makes deploy Ruby APP

#TASK002: Create cripts for auto depoyng Ruby app in YC instance

 autodeploy.sh - Creates new instance, instaling all neccery packeges
                 and make start ruby app in Yandex cloud
 metadata.yaml - Metadata for autodeploy.sh

#TASK003: Provide public ip address and tcp port number where ruby app is running

testapp_IP = 51.250.2.185 testapp_port = 9292


#################################################################################


TASK REPORT: HOME WORK 7


#TASK001 Preapering infrastructure for install and run Packer


      1.Installing Packer
      2.Creating the service account in YC
      3.Assigning an editor role to service account
      4.Creating key for service account

#TASK002 Build Packer image with preinstalled Ruby and MongoDb

      1.Created ubuntu16.json file with all neccery settings
      2.Created varibles.json file with varibles for build file
      3.Reworked bash scipts install.ruby.sh and install_mongodb.sh
      4.Created  image with preinstalled Ruby and MongoDb

#TASK003 Build Packer image with preinstaled Ruby, MongoDb and Ruby app. Create instance with this image.

      1.Reworked deploy.sh script and autodeploy.sh script
      2.Created new image gor this task
      3.Launched autodeploy.sh script which automatically deployed the instance
