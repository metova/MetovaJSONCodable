Pod::Spec.new do |s|

  s.name         = "MetovaJSONCodable"
  s.version      = "1.1.0"
  s.summary      = "MetovaJSONCodable is a small utility class that extends codable for easier JSON support"
  s.description  = <<-DESC
MetovaJSONCodable is a simple protocol implemented on top of the existing codable protocol with specialized support for JSON
                   DESC
  s.homepage     = "https://github.com/metova/MetovaJSONCodable"
  s.license      = "MIT"
  s.authors      = {
    "Kalan Stowe" => "kalan.stowe@metova.com",
    "Nick Griffith" => "nick.griffith@metova.com"
  }

  s.ios.deployment_target = "10.0"
  s.swift_version = "4.2"

  s.source       = { :git => "https://github.com/metova/MetovaJSONCodable.git", :tag => s.tag.to_s }
  s.source_files  = "MetovaJSONCodable/*.swift"

end
