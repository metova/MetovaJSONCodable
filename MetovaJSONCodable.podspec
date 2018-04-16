Pod::Spec.new do |s|

  s.name         = "MetovaJSONCodable"
  s.version      = "1.0.0"
  s.summary      = "MetovaJSONCodable is a small utility class that extends codable for easier JSON support"
  s.description  = <<-DESC
MetovaJSONCodable is a simple protocol implemented on top of the existing codable protocol with specialized support for JSON
                   DESC
  s.homepage     = "https://github.com/metova/metova-json-codable"
  s.license      = "MIT"
  s.author       = { "Kalan Stowe" => "kalan.stowe@metova.com" }

  s.ios.deployment_target = "10.0"

  s.source       = { :git => "https://lab.metova.com/metova/metova-json-codable.git", :tag => "1.0.0" }
  s.source_files  = "MetovaJSONCodable/*.swift"

end
