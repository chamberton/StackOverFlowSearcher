platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!
supports_swift_versions '>= 5.0'

target 'StackOverFlowSearcher' do
  use_frameworks!
  pod 'Swinject'
  pod 'SwiftyBeaver'
  pod 'ReachabilitySwift'
  pod 'MBProgressHUD'
  
  target 'StackOverFlowSearcherTests' do
    pod 'Cuckoo'
    inherit! :search_paths
  end
end
