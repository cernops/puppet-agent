component "rubygem-multi_xml" do |pkg, settings, platform|
  pkg.version "0.6.0"
  pkg.md5sum "0798774f9cc6848f03085b5488f8b6c6"
  pkg.url "https://rubygems.org/downloads/multi_xml-#{pkg.get_version}.gem"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME" => settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB" => "#{settings[:ruby_vendordir]}:$$RUBYLIB"

  pkg.install do
    ["#{settings[:gem_install]} multi_xml-#{pkg.get_version}.gem"]
  end
end
