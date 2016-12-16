component "rubygem-sshkeyauth" do |pkg, settings, platform|
  pkg.version "0.0.11"
  pkg.md5sum "82a0da8ac8a3c795f363a175abbafddd"
  pkg.url "https://rubygems.org/downloads/sshkeyauth-#{pkg.get_version}.gem"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME" => settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB" => "#{settings[:ruby_vendordir]}:$$RUBYLIB"

  pkg.install do
    ["#{settings[:gem_install]} sshkeyauth-#{pkg.get_version}.gem"]
  end
end
