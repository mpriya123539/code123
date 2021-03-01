 provider "azurerm" {
   version = "=2.19.0"
   features {}
 }
module "resourcegroup" {
  source    = "./module/resourcegroup"
  resourcegroupname    = "RG-Networking-Demo"
  resourcegrouplocation    = "westeurope"
  app_code=var.app_code
  app_name=var.app_name
  environment=var.environment
  tags=var.rgtags
}

module "hubvnet" {
  source    = "./module/virtualnetwork"
  vnet="hubvnet"
  virtualnetworkvnetaddressspace=["10.0.0.0/16"]
  resource_group_location= module.resourcegroup.resourcegrouplocation
  resourcegroupname=module.resourcegroup.resourcegroupname
}
module "GatewaySubnet" {
  source    = "./module/subnet"
  subnet                 = "GatewaySubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.1.0/27"]
}

module "managementsubnet" {
  source    = "./module/subnet"
  subnet                 = "managementsubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.2.0/24"]
}

module "AzureFirewallSubnet" {
  source    = "./module/subnet"
  subnet                 = "AzureFirewallSubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.8.0/26"]
}

module "AzureBastionSubnet" {
  source    = "./module/subnet"
  subnet                 = "AzureBastionSubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.10.0/27"]
}

module "spokevnet" {
  source    = "./module/virtualnetwork"
  vnet="spokevnet"
  virtualnetworkvnetaddressspace=["10.1.0.0/16"]
  resource_group_location= module.resourcegroup.resourcegrouplocation
  resourcegroupname=module.resourcegroup.resourcegroupname
}

module "websubnet" {
  source    = "./module/subnet"
  subnet                 = "websubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.spokevnet.name
  virtualnetworkvnetaddressspace     =["10.1.1.0/24"]
}

module "onpremvnet" {
  source    = "./module/virtualnetwork"
  vnet="onpremvnet"
  virtualnetworkvnetaddressspace=["192.168.0.0/16"]
  resource_group_location= module.resourcegroup.resourcegrouplocation
  resourcegroupname=module.resourcegroup.resourcegroupname
}

module "onpremSubnet" {
  source    = "./module/subnet"
  subnet                 = "onpremSubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.onpremvnet.name
  virtualnetworkvnetaddressspace     =["192.168.1.0/24"]
}
module "onpremgatewaysubnet" {
  source    = "./module/subnet"
  subnet                 = "GatewaySubnet"
  resourcegroupname  = module.resourcegroup.resourcegroupname
  vnet = module.onpremvnet.name
  virtualnetworkvnetaddressspace     =["192.168.10.0/27"]
}

module "vmhub" {
  source    = "./module/vm"
  vmname                = "azmngserver1"
  resourcegroupname = module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  vmsize                = "Standard_F2"
  vmadminusername      = "adminuser"
  vmadminpassword      = "P@$$w0rd1234!"
  vmnetworkinterfaceids = [module.nichub.id]
    vmosdiskcaching              = "ReadWrite"
    vmosdiskstorageaccounttype = "Standard_LRS"
    vmpublisher = "MicrosoftWindowsServer"
    vmoffer     = "WindowsServer"
    vmsku       =  "2019-Datacenter"
    vmversion   =  "latest"
  
}

module "vmspoke" {
  source    = "./module/vm_count"
  vmname                = "azwsserver"
  resourcegroupname = module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  vmcount = 2
  availabilitysetid= module.avset.id
  vmsize                = "Standard_F2"
  vmadminusername      = "adminuser"
  vmadminpassword      = "P@$$w0rd1234!"
  vmosdiskcaching              = "ReadWrite"
    vmosdiskstorageaccounttype = "Standard_LRS"
    vmpublisher = "MicrosoftWindowsServer"
    vmoffer     = "WindowsServer"
    vmsku       =  "2019-Datacenter"
    vmversion   =  "latest"
    networkinterfacename                = "azwsserver-NIC"
    ipconfigurationname                          = "IPConfig1"
    ipconfigurationsubnetid                     = module.websubnet.id
    ipconfigurationprivateipaddress = "dynamic"
  
}
module "nichub" {
  source    = "./module/networkinterface"
  networkinterfacename                = "azmngserver1-nic01"
  resourcegrouplocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname =module.resourcegroup.resourcegroupname
    ipconfigurationname                          = "IPConfig1"
    ipconfigurationsubnetid                     = module.managementsubnet.id
    ipconfigurationprivateipaddress = "dynamic"
}

module "vmop" {
  source    = "./module/vm"
  vmname                = "onpremserver1"
  resourcegroupname = module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  vmsize                = "Standard_F2"
  vmadminusername      = "adminuser"
  vmadminpassword      = "P@$$w0rd1234!"
  vmnetworkinterfaceids = [module.nicop.id]
    vmosdiskcaching              = "ReadWrite"
    vmosdiskstorageaccounttype = "Standard_LRS"
    vmpublisher = "MicrosoftWindowsServer"
    vmoffer     = "WindowsServer"
    vmsku       =  "2019-Datacenter"
    vmversion   =  "latest"
  
}
module "nicop" {
  source    = "./module/networkinterface"
  networkinterfacename                = "onpremserver1-nic01"
  resourcegrouplocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname =module.resourcegroup.resourcegroupname
    ipconfigurationname                          = "IPConfig1"
    ipconfigurationsubnetid                     = module.onpremSubnet.id
    ipconfigurationprivateipaddress = "dynamic"
}
module "avset" {
  source    = "./module/availabilityset"
    availabilitysetname = "vmavset-spokevm"
    availabilitysetfaultdomaincount = "3"
    availabilitysetupdatedomaincount = "5" 
    resourcegroupname = module.resourcegroup.resourcegroupname
    availabilitysetlocation = module.resourcegroup.resourcegrouplocation
    managed = "true"
}


module "watcher" {
  source    = "./module/networkwatcher"
  networkwatchername                = "demo-nwwatcher"
  networkwatcherlocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
}
module "nsgbastion" {
  source    = "./module/networksecuritygroup"
  nsgname                = "nsg_azurebastion"
  nsglocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
}
module "loganalytics" {
  source    = "./module/oms"
  loganalyticsworkspaceName                = "netdemo-loganalytics"
  resourcegrouplocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
  loganalyticsworkspacesku                 = "PerGB2018"
  loganalyticsworkspaceretentionindays   = 30
}


module "bastion-in-allow" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-in-allow"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}
module "bastion-control-in-allow4443" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-in-allow"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "4443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}

module "bastion-control-in-allow443" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-in-allow"
  priority                    = 125
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range     = "443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}

module "bastion-in-deny" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-in-deny"
  priority                    = 900
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}

module "bastion-vnet-out-allowssh" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-vnet-out-allowssh"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}

module "bastion-vnet-out-allowrdp" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-vnet-out-allowrdp"
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range     = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}

module "bastion-azure-out-allow" {
  source    = "./module/networksecurityrule"
  name                        = "bastion-vnet-out-allow"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgbastion.name
}
module "bnsgbastionsubnet" {
  source    = "./module/nsgsubnetassociation"
  subnetid                 = module.AzureBastionSubnet.id
  networksecuritygroupid = module.nsgbastion.id
  dependson=[module.resourcegroup.resourcegroupname] 
}

module "nsgmgmt" {
  source    = "./module/networksecuritygroup"
  nsgname                = "nsg_mgmt"
  nsglocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
}


module "managment-in-allow_ssh" {
  source    = "./module/networksecurityrule"
  name                        = "managment-in-allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "managment-in-allow_rdp" {
  source    = "./module/networksecurityrule"
  name                        = "managment-in-allow_rdp"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "managment-in-allow_icmp" {
  source    = "./module/networksecurityrule"
  name                        = "managment-in-allow_icmp"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}

module "nsgmgmtsubnet" {
  source    = "./module/nsgsubnetassociation"
  subnetid                 = module.managementsubnet.id
  networksecuritygroupid = module.nsgmgmt.id
  dependson=[module.resourcegroup.resourcegroupname] #[module.extspoke] 
}

module "nsgweb" {
  source    = "./module/networksecuritygroup"
  nsgname                = "nsg_web"
  nsglocation            =  module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
}


module "web-in-allow_ssh" {
  source    = "./module/networksecurityrule"
  name                        = "web-in-allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "web-in-allow_rdp" {
  source    = "./module/networksecurityrule"
  name                        = "web-in-allow_rdp"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "web-in-allow_http" {
  source    = "./module/networksecurityrule"
  name                        = "web-in-allow_http"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "web-in-allow_https" {
  source    = "./module/networksecurityrule"
  name                        = "web-in-allow_https"
  priority                    = 125
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}
module "web-in-allow_icmp" {
  source    = "./module/networksecurityrule"
  name                        = "web-in-allow_icmp"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.resourcegroupname
  network_security_group_name = module.nsgmgmt.name
}

module "nswebsubnet" {
  source    = "./module/nsgsubnetassociation"
  subnetid                 = module.websubnet.id
  networksecuritygroupid = module.nsgweb.id
  dependson= [module.resourcegroup.resourcegroupname] #[module.extspoke]
}

module "bastionpip" {
  source    = "./module/publicip"
  publicipname                = "bastionpip"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  publicallocationmethod   ="Static"
  publicipsku = "Standard"
}
module "bastionhost" {
  source    = "./module/bastionhost"
  publicipname                = "demobastion"
  resourcegroupname = module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  ipconfigurationname                 = "configuration"
  ipconfigurationsubnetid            = module.AzureBastionSubnet.id
  ipconfigurationpublicipaddressid =  module.bastionpip.id
}


module "Hub2Spoke" {
  source    = "./module/virtualnetworkpeering"
  networkpeeringname                = "Hub2Spoke"
  networkpeeringresourcegroup          =  module.resourcegroup.resourcegroupname
  networkpeeringvirtualnetworkname         = module.hubvnet.name
  networkpeeringremotevirtualnetworkid    = module.spokevnet.id
  networkpeeringallowvirtualnetworkaccess = true
  networkpeeringallowforwardedtraffic      = true 
  networkpeeringallowgatewaytransit = true
  networkpeeringdependson = [module.HOnprem-to-hub-vpn.id, module.Hub-to-Onprem-vpn.id]
}
module "Spoke2Hub" {
  source    = "./module/virtualnetworkpeering"
  networkpeeringname                = "Spoke2Hub"
  networkpeeringresourcegroup          =  module.resourcegroup.resourcegroupname
  networkpeeringvirtualnetworkname         = module.spokevnet.name
  networkpeeringremotevirtualnetworkid    = module.hubvnet.id
  networkpeeringallowvirtualnetworkaccess = true
  networkpeeringallowforwardedtraffic      = true 
  networkpeeringallowgatewaytransit = true
  networkpeeringdependson = [module.HOnprem-to-hub-vpn.id, module.Hub-to-Onprem-vpn.id]
}
module "route-hubvnet-managementsubnet" {
  source    = "./module/routetable"
  azurermroutetablename                = "route-hubvnet-managementsubnet"
  resourcegroupnamelocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname =   module.resourcegroup.resourcegroupname
  routedependson = [module.azfirewall.id, module.azfirewall-apprules.id]

}

module "hubvnet-managementsubnet-to-internet" {
  source    = "./module/route"
  routename                = "hubvnet-managementsubnet-to-internet"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  routeroutetablename    = module.route-hubvnet-managementsubnet.name
  routeaddressprefix      = "0.0.0.0/0"
  routenexthoptype       = "VirtualAppliance"
  routenexthopinipaddress = "10.0.8.4"
  routedependson = [module.route-hubvnet-managementsubnet.id]

}

module "route-hubvnet-managementsubnet-ass" {
  source    = "./module/routetablesubnetassociation"
  subnetid      = module.managementsubnet.id
  routetableid = module.route-hubvnet-managementsubnet.id
  routedependson = [module.route-hubvnet-managementsubnet.id]

}

module "route-spokevnet-websubnet" {
  source    = "./module/routetable"
  azurermroutetablename                = "route-spokevnet-websubnet"
  resourcegroupnamelocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname =   module.resourcegroup.resourcegroupname
  routedependson =  [module.azfirewall.name, module.azfirewall-apprules.name]

}

module "spokevnet-websubnet-to-internet" {
  source    = "./module/route"
  routename                = "spokevnet-websubnet-to-internet"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  routeroutetablename    = module.route-spokevnet-websubnet.name
  routeaddressprefix      = "0.0.0.0/0"
  routenexthoptype       = "VirtualAppliance"
  routenexthopinipaddress = "10.0.8.4"
  routedependson = [module.route-spokevnet-websubnet.id]

}
module "route-spokevnet-websubnet-ass" {
  source    = "./module/routetablesubnetassociation"
  subnetid      = module.websubnet.id
  routetableid = module.route-spokevnet-websubnet.id
  routedependson = [module.route-spokevnet-websubnet.id]

}

module "route-onpremvnet-onpresubnet" {
  source    = "./module/routetable"
  azurermroutetablename                = "route-onpremvnet-onpresubnet"
  resourcegroupnamelocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname =   module.resourcegroup.resourcegroupname
  routedependson =  [module.azfirewall.name, module.azfirewall-apprules.name]

}

module "onpremvnet-onpresubnet-to-hubvnet" {
  source    = "./module/route"
  routename                = "onpremvnet-onpresubnet-to-hubvnet"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  routeroutetablename    = module.route-onpremvnet-onpresubnet.name
  routeaddressprefix      = "10.0.1.0/27"
  routenexthoptype       = "VirtualAppliance"
  routenexthopinipaddress = "10.0.8.4"
  routedependson =[module.route-onpremvnet-onpresubnet.id]
}
module "route-onpremvnet-onpresubnet-ass" {
  source    = "./module/routetablesubnetassociation"
  subnetid      = module.GatewaySubnet.id
  routetableid = module.route-onpremvnet-onpresubnet.id
  routedependson = [module.route-onpremvnet-onpresubnet.id]

}
module "azfirewallpip" {
  source    = "./module/publicip"
  publicipname                = "azfirewallpip"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  publicallocationmethod   ="Static"
  publicipsku = "Standard"
}

module "azfirewall" {
  source    = "./module/firewall"
  firewallname                = "demoazfirewall"
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
  firewalldependson = [module.resourcegroup.resourcegroupname] #[module.extspoke.name]
  firewallipconfigurationname                 = "configuration"
  firewallipconfigurationsubnetid            = module.AzureFirewallSubnet.id
  firewallipconfigurationpublicipaddressid = module.azfirewallpip.id
}
module "azfirewall-apprules" {
  source    = "./module/firewallapplicationrulecollection"
  firewallapplicationname                = "app-allow-rule-websites"
  firewallapplicationazurefirewallname = module.azfirewall.name
  resourcegroupname = module.resourcegroup.resourcegroupname
  firewallapplicationpriority            = 200
  firewallapplicationaction              = "Allow"
  firewallapplicationrulename = "allow-microsoft"
  firewallapplicationrulesourceaddresses =[ "10.0.2.0/24", "10.1.1.0/24" ]
  firewallapplicationruletargetfqdns =[ "*.microsoft.com","*.azure.com","*.windows.net"]
}
module "azfirewall-netrules" {
  source    = "./module/firewallnetworkrulecollectiom"
  firewallnetworkname                = "testcollection"
  firewallnetworkazurefirewallname = module.azfirewall.name
  resourcegroupname = module.resourcegroup.resourcegroupname
  firewallnetworkpriority            = 200
  firewallnetworkaction              = "Allow"
  firewallnetworkrulename = "net-allow-rule-dns"
    firewallnetworkrulesourceaddresses = [ "10.0.0.0/16",      "10.1.0.0/16"    ]
    firewallnetworkruledestinationports = [      "53"]
    firewallnetworkruledestinationaddresses = [      "168.63.129.16",    ]
    firewallnetworkruleprotocols = [      "TCP",      "UDP"    ]
 }
module "fd2fwnat" {
  source    = "./module/firewallnatrulecollection"
  firewallnatrulename                =  "testcollection"
  firewallnatruleazure_firewall_name = module.azfirewall.name
  resourcegroupname =  module.resourcegroup.resourcegroupname
  firewallnatrulepriority            = 200
  firewallnatruleaction              = "Dnat"
    firewallnatrule_rulename = "fw2lbnat"
    firewallnatrulesourceaddresses = [      "*"    ]
    firewallnatruledestinationports = [      "80"    ]
    firewallnatruledestinationaddresses = ["${module.azfirewallpip.ip_address}" ]
    firewallnatruleprotocols =  [ "TCP" ]
    firewallnatruletranslatedaddress = "10.1.1.100"
    firewallnatruletranslatedport = "80"

}

module "hubvpngw-pip" {
  source    = "./module/publicip"
  publicipname                = "hubvpngw-pip"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  publicallocationmethod   ="Dynamic"
  publicipsku = "Standard"
}



module "hubvpngw" {
  source    = "./module/virtualnetworkgateway"
  virtualnetworkgatewayname                = "hubvpngw"
  virtualnetworkgatewaylocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname =  module.resourcegroup.resourcegroupname

  virtualnetworkgatewaytype     = "Vpn"
  virtualnetworkgatewayvpntype = "RouteBased"

  virtualnetworkgatewayactiveactive = false
  virtualnetworkgatewayenablebgp    = false
  virtualnetworkgatewaysku           = "Basic"
  virtualnetworkgatewayipname                          = "vnetGatewayConfig"
    virtualnetworkgatewayippublicipaddressid          = module.hubvpngw-pip.id
    virtualnetworkgatewayipprivateipaddressallocation = "Dynamic"
    virtualnetworkgatewayipsubnetid                     = module.GatewaySubnet.id
  
}


module "onpremvpngw-pip" {
  source    = "./module/publicip"
  publicipname                = "onpremvpngw-pip"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  publicallocationmethod   ="Dynamic"
  publicipsku = "Standard"
}


module "onpremvpngw" {
  source    = "./module/virtualnetworkgateway"
  virtualnetworkgatewayname                = "onpremvpngw"
  virtualnetworkgatewaylocation            = module.resourcegroup.resourcegrouplocation
  resourcegroupname =  module.resourcegroup.resourcegroupname

  virtualnetworkgatewaytype     = "Vpn"
  virtualnetworkgatewayvpntype = "RouteBased"

  virtualnetworkgatewayactiveactive = false
  virtualnetworkgatewayenablebgp    = false
  virtualnetworkgatewaysku           = "Basic"
  virtualnetworkgatewayipname                          = "vnetGatewayConfig"
    virtualnetworkgatewayippublicipaddressid          = module.onpremvpngw-pip.id
    virtualnetworkgatewayipprivateipaddressallocation = "Dynamic"
    virtualnetworkgatewayipsubnetid                     = module.onpremgatewaysubnet.id
  
}


module "Hub-to-Onprem-vpn" {
  source    = "./module/virtualnetworkgatewayconnection"
  virtualnetworkgatewayconnectionname                = "Hub-to-Onprem-vpn"
  location            = module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
  virtualnetworkgatewayconnectiontype                            = "Vnet2Vnet"
  virtualnetworkgatewayconnectiongatewayid      = module.hubvpngw.id
  virtualnetworkgatewayconnectionpeergatewayid = module.onpremvpngw.id
  virtualnetworkgatewayconnectionsharedkey =  "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}


module "HOnprem-to-hub-vpn" {
  source    = "./module/virtualnetworkgatewayconnection"
  virtualnetworkgatewayconnectionname                = "Onprem-to-hub-vpn"
  location            = module.resourcegroup.resourcegrouplocation
  resourcegroupname = module.resourcegroup.resourcegroupname
  virtualnetworkgatewayconnectiontype                            = "Vnet2Vnet"
  virtualnetworkgatewayconnectiongatewayid      = module.onpremvpngw.id
  virtualnetworkgatewayconnectionpeergatewayid = module.hubvpngw.id
  virtualnetworkgatewayconnectionsharedkey =  "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}

module "lbspokeweb" {
  source    = "./module/lb"
  lbname                = "lbspokeweb"
  lblocation            = module.resourcegroup.resourcegrouplocation
  lbresourcegroupname =  module.resourcegroup.resourcegroupname
  lbsku = "Basic"

    lbfrontendipconfigurationname                 = "PrivateIPAddress"
    lbfrontendipconfigurationprivateipaddress = "10.1.1.100"
    lbfrontendipconfigurationprivateipaddressallocation = "Static"
    lbfrontendipconfigurationsubnetid = module.websubnet.id
}

module "lb-backendpool" {
  source    = "./module/lbbackendaddresspool"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  loadbalancerid     = module.lbspokeweb.id
  name                = "BackEndAddressPool"
}



module "lb_rule" {
  source    = "./module/lbrule"
  lbruleresourcegroupname            = module.resourcegroup.resourcegroupname
  lbruleloadbalancerid                = module.lbspokeweb.id
  lbrulename                           = "LBRule"
  lbruleprotocol                       = "tcp"
  lbrulefrontendport                  = 80
  lbrulebackendport                   = 80
  lbrulefrontendipconfigurationname = "PrivateIPAddress"
  lbruleenablefloatingip             = false
  lbrulebackendaddresspoolid        =  module.lb-backendpool.id
  lbruleidletimeoutinminutes        = 5
  lbruleprobeid                       = module.lb_probe.id
  lbruledependson                     = [module.lb_probe.id]
}


module "lb_probe" {
  source    = "./module/lbprobe"
  lbproberesourcegroupname = module.resourcegroup.resourcegroupname
  lbprobeloadbalancerid     =module.lbspokeweb.id
  lbprobename                = "tcpProbe"
  lbprobeprotocol            = "tcp"
  lbprobeport                = 80
  lbprobeintervalinseconds = 5
  lbprobenumberofprobes    = 2
}



module "watcher-flow-web" {
  source    = "./module/networkwatcherflowlog"
  networkwatcherflowlognetworkwatchername =  module.watcher.name
  resourcegroupname  =  module.resourcegroup.resourcegroupname

  networkwatcherflowlognetworksecuritygroupid = module.nsgweb.id
  networkwatcherflowlogstorageaccountid        = module.storageaccount.id
  networkwatcherflowlogenabled                   = true
    networkwatcherflowlogretentionpolicyenabled = true
    networkwatcherflowlogretentionpolicydays    = 7

    networkwatcherflowlogtrafficanalyticsenabled               = true
    networkwatcherflowlogtrafficanalyticsworkspaceid          = module.loganalytics.workspace_id
    networkwatcherflowlogtrafficanalyticsworkspaceregion      = module.loganalytics.location
    networkwatcherflowlogtrafficanalyticsworkspaceresourceid =  module.loganalytics.id
}

module "watcher-flow-mgmt" {
  source    = "./module/networkwatcherflowlog"
  networkwatcherflowlognetworkwatchername =  module.watcher.name
  resourcegroupname  =  module.resourcegroup.resourcegroupname

  networkwatcherflowlognetworksecuritygroupid = module.nsgmgmt.id
  networkwatcherflowlogstorageaccountid        = module.storageaccount.id
  networkwatcherflowlogenabled                   = true


    networkwatcherflowlogretentionpolicyenabled = true
    networkwatcherflowlogretentionpolicydays    = 7
    networkwatcherflowlogtrafficanalyticsenabled               = true
    networkwatcherflowlogtrafficanalyticsworkspaceid          = module.loganalytics.workspace_id
    networkwatcherflowlogtrafficanalyticsworkspaceregion      = module.loganalytics.location
    networkwatcherflowlogtrafficanalyticsworkspaceresourceid =  module.loganalytics.id
}
module "randomId" {
  source    = "./module/random"
    resourcegroupname = module.resourcegroup.resourcegroupname
    byte_length = 8


}

module "storageaccount" {
  source    = "./module/storage"
  storagename                     = "petsa${module.randomId.hex}"
  resourcegroupname      = module.resourcegroup.resourcegroupname
  resourcegrouplocation                 = module.resourcegroup.resourcegrouplocation
  storageaccounttier             = "Standard"
  storagereplicationtype = "LRS"  
  storageenablehttpstrafficonly= true
  storageallowblobpublicaccess=true

}
module "azfrontdoor" {
  source    = "./module/frontdoor"
  frontdoorname                                         = "frontdoorname2061"
  location                                     = module.resourcegroup.resourcegrouplocation
  resource_group_name                          =  module.resourcegroup.resourcegroupname
  enforce_backend_pools_certificate_name_check = false

    routing_rulename               = "exampleRoutingRule1"
    routing_ruleaccepted_protocols = ["Http"]
    routing_rulepatterns_to_match  = ["/*"]
    routing_rulefrontend_endpoints = ["exampleFrontendEndpoint1"]

      routing_ruleforwarding_protocol = "HttpOnly"
      routing_rulebackend_pool_name   = "exampleBackend"

    backend_pool_load_balancingname = "exampleLoadBalancingSettings1"
    backend_pool_health_probename = "exampleHealthProbeSetting1"


    backend_poolname = "exampleBackend"
      backend_poolhost_header = "mytest"
      backend_pooladdress     = module.azfirewallpip.ip_address
      backend_poolhttp_port   = 80
      backend_poolhttps_port  = 443
 

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
 
    frontend_endpointname                              = "exampleFrontendEndpoint1"
    frontend_endpointhost_name                         = "frontdoorname2061"
    frontend_endpointcustom_https_provisioning_enabled = false
  
}

module "backendassociation" {
  source    = "./module/networkInterfacebackendaddresspoolassociation"
  network_interface_id    = module.vmspoke.nicid
  ip_configuration_name   = "IPConfig1"
  backend_address_pool_id =module.lb-backendpool.id
  lbcount = 2
  dependson = [module.lb-backendpool.id]
}

module "exthub" {
  source    = "./module/vmextension"
  name                 = "hostname1"
  virtual_machine_id   = module.vmhub.id
  publisher            ="Microsoft.Compute"
  extype                 =  "CustomScriptExtension"
  type_handler_version ="1.8"
  scriptping= "https://sridver"
  commandToExecute="powershell.exe -ExecutionPolicy Unrestricted -file enable-icmp.ps1"
}
module "extop" {
  source    = "./module/vmextension"
  name                 =  "hostname"
  virtual_machine_id   = module.vmop.id
  publisher            ="Microsoft.Compute"
  extype                 =  "CustomScriptExtension"
  type_handler_version ="1.8"
  scriptping= "https://sridver"
  commandToExecute="powershell.exe -ExecutionPolicy Unrestricted -file enable-icmp.ps1"
}




