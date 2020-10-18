# StackOverFlowSearcher

## Architecture

MVC + Interactor pattern

 ViewController -> constraint to view
 Model -> Struct, enums, etc
 C -> Controller classes
 
Repositorys layer - > Data fetching and updating
Network layer -> HTTP Client [Use of synchronous version to reduce the verbosity of the async implementation]

##  Cocoapod projects

Application dependencies:
 * Swinject [For depency injection]
 * SwiftyBeaver [For logging]
 * ReachabilitySwift [For connectiviy detection]
 * MBProgressHUD [For progress indication]
 * DateToolsSwift [For date convenience methods]

Test target dependencies: 
  * Cuckoo [For mocking]

## Dependency container

To fulfill dependency inversion principle
--> Use of Swinject


## Logger

Logging:
* failures
* service calls
* exceptions

## Localization

* French and english
* Use of a custom LocalizedCopy method that uses prefix to determine in which table to fetch the copy


## Application startup

* Use of command pattern
