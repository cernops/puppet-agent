component "rubygem-builder" do |pkg, settings, platform|
  pkg.version "3.2.3"
  pkg.md5sum "24dbb8bc3a17ce24ff65c9af513f5245"
  pkg.url "https://rubygems.org/downloads/builder-#{pkg.get_version}.gem"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME" => settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB" => "#{settings[:ruby_vendordir]}:$$RUBYLIB"

  pkg.install do
    ["#{settings[:gem_install]} builder-#{pkg.get_version}.gem"]
  end
end
