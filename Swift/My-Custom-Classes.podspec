Pod::Spec.new do |s|

  s.name         = "My-Custom-Classes-Swift"
  s.version      = "0.0.1"
  s.summary      = "My library"
  s.homepage     = "https://github.com/Nibelungc/My-Custom-Classes"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Nikolai Kagala" => "nibelungc@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Nibelungc/My-Custom-Classes.git", :tag => s.version.to_s }
  s.source_files  = "My-Custom-Classes/Swift/**/*.{swift}"
  s.requires_arc = true

end
