Pod::Spec.new do |s|
  s.name         = "PLRangeSlider"
  s.version      = "0.0.2"
  s.summary      = "A custom range slider for iOS"
  s.homepage     = "https://github.com/lduraes/PLRangeSlider"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors            = { "Luiz Duraes" => "lduraes@gmail.com", 'Pedro Lucas' => 'lucasdasilvajunior@yahoo.com.br'  }
  s.social_media_url   = "http://twitter.com/ilduraes"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/lduraes/PLRangeSlider.git", :commit => "4693b8b3105450d56094a0f413be964c5e4b6c8f" }
  s.source_files  = "RangeSlider/PLRangeSliderView.{h,m}"
  s.resources = "RangeSlider/**/*.png"
  s.requires_arc = true
end
