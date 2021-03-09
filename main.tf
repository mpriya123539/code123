 provider "azurerm" {
   version = "=2.19.0"
   features {}
 }
module "resourcegroup" {
  source    = "./module/resourcegroup"
}
module "hubvnet" {
  source    = "./module/virtualnetwork"
  vnet="hubvnet"
  virtualnetworkvnetaddressspace=["10.0.0.0/16"]
 }
module "GatewaySubnet" {
  source    = "./module/subnet"
  subnet                 = "GatewaySubnet"
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.1.0/27"]
}
module "managementsubnet" {
  source    = "./module/subnet"
  subnet                 = "managementsubnet"
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.2.0/24"]
}
module "AzureFirewallSubnet" {
  source    = "./module/subnet"
  subnet                 = "AzureFirewallSubnet"
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.8.0/26"]
}
module "AzureBastionSubnet" {
  source    = "./module/subnet"
  subnet                 = "AzureBastionSubnet"
  vnet = module.hubvnet.name
  virtualnetworkvnetaddressspace     =["10.0.10.0/27"]
}
module "spokevnet" {
  source    = "./module/virtualnetwork"
  vnet="spokevnet"
  virtualnetworkvnetaddressspace=["10.1.0.0/16"]
 }
module "websubnet" {
  source    = "./module/subnet"
  subnet                 = "websubnet"
  vnet = module.spokevnet.name
  virtualnetworkvnetaddressspace     =["10.1.1.0/24"]
}
module "onpremvnet" {
  source    = "./module/virtualnetwork"
  vnet="onpremvnet"
  virtualnetworkvnetaddressspace=["192.168.0.0/16"]
 }
module "onpremSubnet" {
  source    = "./module/subnet"
  subnet                 = "onpremSubnet"
  vnet = module.onpremvnet.name
  virtualnetworkvnetaddressspace     =["192.168.1.0/24"]
}
module "onpremgatewaysubnet" {
  source    = "./module/subnet"
  subnet                 = "GatewaySubnet"
  vnet = module.onpremvnet.name
  virtualnetworkvnetaddressspace     =["192.168.10.0/27"]
}
module "vmhub" {
  source    = "./module/vm"
  vmnetworkinterfaceids = [module.nichub.id]
}
module "vmspoke" {
  source    = "./module/vm_count"
  availabilitysetid= module.avset.id
  ipconfigurationsubnetid                     = module.websubnet.id
}
module "nichub" {
  source    = "./module/networkinterface"
  networkinterfacename                = "azmngserver1-nic01"
  ipconfigurationsubnetid                     = module.managementsubnet.id
  
}
module "vmop" {
  source    = "./module/vm"
  vmname                = "onpremserver1"
  vmnetworkinterfaceids = [module.nicop.id]
}
module "nicop" {
  source    = "./module/networkinterface"
  networkinterfacename                = "onpremserver1-nic01"
  ipconfigurationsubnetid                     = module.onpremSubnet.id

}
module "avset" {
  source    = "./module/availabilityset"
    availabilitysetlocation = module.resourcegroup.resourcegrouplocation
}
module "watcher" {
  source    = "./module/networkwatcher"
  networkwatcherlocation            =  module.resourcegroup.resourcegrouplocation
}
module "nsgbastion" {
  source    = "./module/networksecuritygroup"
  nsgname                = "nsg_azurebastion"
  nsglocation            =  module.resourcegroup.resourcegrouplocation
}
module "loganalytics" {
  source    = "./module/oms"

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
  publicallocationmethod   ="Static"
  publicipsku = "Standard"
}
module "bastionhost" {
  source    = "./module/bastionhost"
  ipconfigurationsubnetid            = module.AzureBastionSubnet.id
  ipconfigurationpublicipaddressid =  module.bastionpip.id
}
module "Hub2Spoke" {
  source    = "./module/virtualnetworkpeering"
  networkpeeringname                = "Hub2Spoke"
  networkpeeringresourcegroup          =  module.resourcegroup.resourcegroupname
  networkpeeringvirtualnetworkname         = module.hubvnet.name
  networkpeeringremotevirtualnetworkid    = module.spokevnet.id
  networkpeeringdependson = [module.HOnprem-to-hub-vpn.id, module.Hub-to-Onprem-vpn.id]
}
module "Spoke2Hub" {
  source    = "./module/virtualnetworkpeering"
  networkpeeringname                = "Spoke2Hub"
  networkpeeringresourcegroup          =  module.resourcegroup.resourcegroupname
  networkpeeringvirtualnetworkname         = module.spokevnet.name
  networkpeeringremotevirtualnetworkid    = module.hubvnet.id
  networkpeeringdependson = [module.HOnprem-to-hub-vpn.id, module.Hub-to-Onprem-vpn.id]
}
module "route-hubvnet-managementsubnet" {
  source    = "./module/routetable"
  azurermroutetablename                = "route-hubvnet-managementsubnet"
  routedependson = [module.azfirewall.id, module.azfirewall-apprules.id]

}
module "hubvnet-managementsubnet-to-internet" {
  source    = "./module/route"
  routename                = "hubvnet-managementsubnet-to-internet"
  resourcegroupname =  module.resourcegroup.resourcegroupname
  routeroutetablename    = module.route-hubvnet-managementsubnet.name
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
  routedependson =  [module.azfirewall.name, module.azfirewall-apprules.name]
}
module "spokevnet-websubnet-to-internet" {
  source    = "./module/route"
  routename                = "spokevnet-websubnet-to-internet"
  routeroutetablename    = module.route-spokevnet-websubnet.name
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
  resourcegrouplocation            = module.resourcegroup.resourcegrouplocation
  publicallocationmethod   ="Static"
  publicipsku = "Standard"
}
module "azfirewall" {
  source    = "./module/firewall"
  firewallname                = "demoazfirewall"
  firewalldependson = [module.resourcegroup.resourcegroupname] #[module.extspoke.name]
  firewallipconfigurationname                 = "configuration"
  firewallipconfigurationsubnetid            = module.AzureFirewallSubnet.id
  firewallipconfigurationpublicipaddressid = module.azfirewallpip.id
}
module "azfirewall-apprules" {
  source    = "./module/firewallapplicationrulecollection"
  firewallapplicationname                = "app-allow-rule-websites"
  firewallapplicationazurefirewallname = module.azfirewall.name
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
  publicallocationmethod   ="Dynamic"
  publicipsku = "Standard"
}
module "hubvpngw" {
  source    = "./module/virtualnetworkgateway"
  virtualnetworkgatewayname                = "hubvpngw"
  virtualnetworkgatewaylocation            = module.resourcegroup.resourcegrouplocation
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
  publicallocationmethod   ="Dynamic"
  publicipsku = "Standard"
}
module "onpremvpngw" {
  source    = "./module/virtualnetworkgateway"
  virtualnetworkgatewayname                = "onpremvpngw"
  virtualnetworkgatewaylocation            = module.resourcegroup.resourcegrouplocation
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
  virtualnetworkgatewayconnectiontype                            = "Vnet2Vnet"
  virtualnetworkgatewayconnectiongatewayid      = module.hubvpngw.id
  virtualnetworkgatewayconnectionpeergatewayid = module.onpremvpngw.id
  virtualnetworkgatewayconnectionsharedkey =  "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}
module "HOnprem-to-hub-vpn" {
  source    = "./module/virtualnetworkgatewayconnection"
  virtualnetworkgatewayconnectionname                = "Onprem-to-hub-vpn"
  virtualnetworkgatewayconnectiontype                            = "Vnet2Vnet"
  virtualnetworkgatewayconnectiongatewayid      = module.onpremvpngw.id
  virtualnetworkgatewayconnectionpeergatewayid = module.hubvpngw.id
  virtualnetworkgatewayconnectionsharedkey =  "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}
module "lbspokeweb" {
  source    = "./module/lb"
  lbname                = "lbspokeweb"
  lbsku = "Basic"
    lbfrontendipconfigurationname                 = "PrivateIPAddress"
    lbfrontendipconfigurationprivateipaddress = "10.1.1.100"
    lbfrontendipconfigurationprivateipaddressallocation = "Static"
    lbfrontendipconfigurationsubnetid = module.websubnet.id
}
module "lb-backendpool" {
  source    = "./module/lbbackendaddresspool"
  loadbalancerid     = module.lbspokeweb.id
}
module "lb_rule" {
  source    = "./module/lbrule"
  lbruleloadbalancerid                = module.lbspokeweb.id
  lbrulebackendaddresspoolid        =  module.lb-backendpool.id
  lbruleprobeid                       = module.lb_probe.id
  lbruledependson                     = [module.lb_probe.id]
}
module "lb_probe" {
  source    = "./module/lbprobe"
  lbprobeloadbalancerid     =module.lbspokeweb.id
}
module "watcher-flow-web" {
  source    = "./module/networkwatcherflowlog"
  networkwatcherflowlognetworkwatchername =  module.watcher.name
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
    byte_length = 8
}

module "storageaccount" {
  source    = "./module/storage"
  storagename                     = "petsa${module.randomId.hex}"
}
module "azfrontdoor" {
  source    = "./module/frontdoor"
  location                                     = module.resourcegroup.resourcegrouplocation
  resource_group_name                          =  module.resourcegroup.resourcegroupname
  backend_pooladdress     = module.azfirewallpip.ip_address
}
module "backendassociation" {
  source    = "./module/networkInterfacebackendaddresspoolassociation"
  network_interface_id    = module.vmspoke.nicid
  backend_address_pool_id =module.lb-backendpool.id
  dependson = [module.lb-backendpool.id]
}
module "exthub" {
  source    = "./module/vmextension"
  virtual_machine_id   = module.vmhub.id
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




