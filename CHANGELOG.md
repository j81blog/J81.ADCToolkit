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
