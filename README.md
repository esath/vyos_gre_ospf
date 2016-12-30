
Source your credentials for Openstack
Ask admin to create external router. You need ID for router to run stack.

#Create networks & routers with HEAT-template
- (modify bdn-router-ID or use --parameters):
- $ heat stack-create --template-file BDN_Vyos_STACK.yml --parameters "heat_bdn_router=a8419590-ecf3-4800-bcca-c642b27d65bxx" BDNSTACK
- OR (depends what tools you have)
-  *$ openstack stack create vyos_bdn_stack -t BDN_Vyos_STACK.yml --parameter "heat_bdn_router=a8419590-ecf3-4800-bcca-c642b27d65xx"

Full guide:
http://wiki.intra.sonera.fi/display/CLOUD/HEAT+Template+for+BDN

-------------

Modify hosts -file to match your VyOS floating-ip.

(propably now you need to remove ip dhcp from VyOS eth1 -interface using openstack-console)

#Modify security-group (SSH&GRE)!!!!!!

Login VyOS intance to verify connectivity and add keys (look below).
First time login with 'ssh vyos@192.130.3.xx' Ansible won't work before that.
 
With sh_interfaces.yml playbook you can safely test Ansible-connection.

And finally you can configure VyOS with vyos_conf.yml playbook.
You have to change 192.168.62.xx address to vyos_conf.sh. Admin gives that.
Modify carefully!!


If you want to use pwd instead of public-key:
- $ sudo apt-get install sshpass

And run playbooks with: --ask-pass

--
To use keys with VyOS:
From jump-host or workstation copy public-key to vyos:
- $ scp .ssh/id_rsa.pub vyos@192.130.3.xx:/home/vyos/.ssh/dev1.pub

vyos@vyos# loadkey vyos /home/vyos/.ssh/dev1.pub

--
#Test:

- $ ansible-playbook sh_interfaces.yml

sh_interfaces.yml - Runs script-file: sh_interfaces.sh

------------------
vyos_conf.yml needs no modification

vyos_conf.sh needs one unique ip-address (from admin):
Change 192.168.61.xx ip address for eth1 and for 'tunX local-ip 192.168.62.xx'

Finally:
- $ ansible-playbook vyos_conf.yml -vvvv

------------
With this you can test tunnel endpoint and check routing-table.
You should see ospf-router through tun-interface (proto zebra).

- $ ansible-playbook raw_test2.yml


----
#Things to fix:
 - DONE: Automate anti-spoof neutron-command.
 - Insert variables in one place (bdn-router-id , eth1-ip_address , floating-ip) 
   (if possible)
 - BGP-routing instead of OSPF
 - Add security-group to HEAT-template
 - Clear Ansible output of vyos_conf.yml. That's full of locale errors you don't need to care.
 - Stack deletion fails if you don't release Floating-ip first
 - Host-routes should be added for networks behind Datanet. Heat shouls ask those as parameter.
