BIOSTAR-VAGRANT
===

A deployment suite for biostar based on virtualbox, vagrant and ansible.

HOW TO USE
===
Assuming a VirutalBox/Vagrant set up

1. Clone the repository on the host 
2. RUN vagrant up

SETTINGS
===

1. All the biostar settings are included in variables.yml. To personalise the Biostar instance (for ex-changing site name, image, social auth keys etc.), change the respective settings in variables.yml.
2. By default, the server listens on port 8080. To change it, open the Vagrantfile and replace "host: 8080" to the respective host.
