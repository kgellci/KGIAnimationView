Pod::Spec.new do |s|
  s.name         = "KGAnimationView"
  s.version      = "0.0.6"
  s.summary      = "An easy way to create key frame based animations for UIView which are tied to movement based gestures."
  s.description  = <<-DESC
                   * KGAnimationView allows you to add key frame animations to a view.
                   * The key frame animations are not tied to time but rether to movement.
                   * You can tie key frame animations to the scroll view did scroll delegate method to create some coole effects.
                   DESC
  s.homepage     = "https://github.com/kgellci/KGAnimationView"
  s.license      = "Apache License, Version2.0 (LICENSE)"
  s.author             = "Kris Gellci"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/kgellci/KGAnimationView.git", :tag => "0.0.6" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
