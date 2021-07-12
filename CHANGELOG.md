# Changelog
## v1.4.3
  - Move to github
  - Add metadata support from base module

## v1.4.2
  - Update base module to v1.4.2

## v1.4.1
  - Add sensitive flags to outputs where necessary
## v1.4

 - Add support for configuring block storage type (volume or local file).
   Defaults to local file
## v1.3.2

 - Make userdata file input optional

## v1.3.1

 - Upgrade sub-module to v1.3.1 to apply config_drive hotfix
 - Format with `terraform fmt`

## v1.3

- Upgrade sub-module to v1.3
- Remove unnecessary data source usage

## v1.2.1

- Add server and network info outputs
- Add changelog
- Fix additional networks not properly working

## v1.2

- Upgrade to terraform 0.13 
- Replace using resources with sub-module loop


## v1.1

- Allow input of dictionary as context for rendering userdata template
- Replace id inputs with name inputs for increased reusability of code

## v1.0

- Initial Release