
Pod::Spec.new do |s|

  s.name         = "JCS_Kit"
  s.version      = "1.0.10"
  s.summary      = "JCS_Kit."
  s.description  = <<-DESC
                    this is JCS_Kit
                   DESC
                   
  s.homepage     = "https://github.com/jcsteam/JCS_Kit"
  s.source       = { :git => "https://github.com/jcsteam/JCS_Kit.git", :tag => s.version.to_s }
  s.source_files  = "JCS_Kit/JCS_Kit/**/*.{h,m,swift}"
  
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "devjackcat" => "devjackcat@163.com" }
  s.platform     = :ios, "9.0"
  
    s.subspec 'BaseLib' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_BaseLib/**/*.{h,m,swift}'
    end
    
    s.subspec 'Category' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_Category/**/*.{h,m,swift}'
      ss.dependency 'FastCoding'
      ss.dependency 'JCS_Kit/BaseLib'
    end
    
    s.subspec 'EventBus' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_EventBus/**/*.{h,m,swift}'
      ss.dependency 'JCS_Kit/BaseLib'
      ss.dependency 'JCS_Kit/Category'
    end
    
    s.subspec 'Injection' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_Injection/**/*.{h,m,swift}'
      ss.dependency 'JCS_Kit/Category'
      ss.dependency 'MJExtension'
    end
    
    s.subspec 'Router' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_Router/**/*.{h,m,swift}'
      ss.dependency 'JCS_Kit/Category'
      ss.dependency 'JCS_Kit/BaseLib'
    end
    
    s.subspec 'Create' do |ss|
      ss.source_files = 'JCS_Kit/JCS_Kit/JCS_Create/**/*.{h,m,swift}'
      ss.dependency "JCS_Kit/BaseLib"
      ss.dependency "JCS_Kit/Category"
      ss.dependency "JCS_Kit/Router"
      ss.dependency "JCS_Kit/Injection"
      ss.dependency "JCS_Kit/EventBus"
      ss.dependency "Masonry"
      ss.dependency "SDWebImage"
      ss.dependency "ReactiveObjC"
      ss.dependency "MJRefresh"
    end
  
  s.requires_arc = true
  
  s.dependency 'FastCoding'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'ReactiveObjC'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'

end
