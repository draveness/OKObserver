Pod::Spec.new do |s|
  s.name             = "OKObserver"
  s.version          = "0.1.0"
  s.summary          = "A lightweight framework which makes KVO easily to use."

  s.description      = <<-DESC
KVO is very troublesome to use, you need to call addObserver: method, override method
to observe the event. All I need is when there is somthing changed, execute blocks.
At first ReactiveCocoa fits my requirement, and I really had a happy time with it. But
it is a swift framework and doesn't officially support cocoapods as installation method.
OKObserver is created under this circumstance to help us bind model and view.
                       DESC

  s.homepage         = "https://github.com/draveness/OKObserver"
  s.license          = 'MIT'
  s.author           = { "Draveness" => "stark.draven@gmail.com" }
  s.source           = { :git => "https://github.com/draveness/OKObserver.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'OKObserver/Classes/**/*'
  
end
