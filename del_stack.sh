
neutron floatingip-list
echo "Please enter ID of floatingip first "
read OS_FLOAT_INPUT
export OS_FLOAT=$OS_FLOAT_INPUT

neutron floatingip-delete $OS_FLOAT
heat stack-delete BDNSTACK

