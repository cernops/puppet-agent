component "rubygem-akami" do |pkg, settings, platform|
  pkg.version "1.3.1"
  pkg.md5sum "440f19a02352d3c03cd51ca72bf07efc"
  pkg.url "https://rubygems.org/downloads/akami-#{pkg.get_version}.gem"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME" => settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB" => "#{settings[:ruby_vendordir]}:$$RUBYLIB"

  pkg.install do
    ["#{settings[:gem_install]} akami-#{pkg.get_version}.gem"]
  end
end
