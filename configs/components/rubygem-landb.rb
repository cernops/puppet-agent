component "rubygem-landb" do |pkg, settings, platform|
  pkg.load_from_json("configs/components/rubygem-landb.json")

  pkg.build_requires "ruby-#{settings[:ruby_version]}"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME" => settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB" => "#{settings[:ruby_vendordir]}:$$RUBYLIB"

  pkg.install do
    ["pwd",
     "#{settings[:host_gem]} build landb.gemspec",
     "#{settings[:gem_install]} landb-0.1.2.gem",
    ]
  end
end
