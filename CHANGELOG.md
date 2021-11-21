# Change Log

## 2011.0921

* Initial version  

## 2011.0922

* Minor changes and updates.

## 2011.1122

* Added Pester test
* Cleaned and unified code

## 2011.1223

* Added CS vServer functions

## 2011.1224

* Fixed an issue with Invoke-ADCDeleteSystemFile

## 2012.2023/2012.2411

* Fixed issue with Connect-ADCNode, part of the code was generating false-positive in defender
* Fixed issue in Invoke-ADCRetrieveCertificateRemoveInfo (used by Invoke-ADCRetrieveCertificateRemoveInfo); not all certificates that could be deleted where deleted
* Added almost all (except for PING and TRACEROUTE) ADC functions (configuration and statistics) based on the Nitro documentation.
* A lot of functions are still untested!

## v2101.0322

* Compatibility improvements for PowerShell 6/7 & Core
* Changed the Invoke-ADCCleanCertKeyFiles function so a full backup is created instead of a basic backup
* Added a function Connect-ADCHANodes for connecting all HA nodes
* Added option -HA to Connect-ADCNode to connect all HA nodes (Will call Connect-ADCHANodes internally)
* ADC functions regenerated, change required for statistics functions

## VERSION$
* Changed/improved description of modules
* Fixed some parameter options as they were sometimes wrong when imported from the NITRO docs
* Introduced the option to define a $Global:ManagementURL or $Global:ADCCredential variable (Can also be a Sript scoped variable)
