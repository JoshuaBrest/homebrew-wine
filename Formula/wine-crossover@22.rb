  revision 2
    root_url "https://github.com/Gcenx/homebrew-wine/releases/download/wine-crossover@22-22.1.1_2"
    sha256 monterey: "f6985a085c6790c8a333ad31cad8c19a4291a2b7ae859a83228b6fae0a257239"
    # Homebrew replaces wine's rpath names with absolute paths, we need to change them back to @rpath relative paths
    # Wine relies on @rpath names to cause dlopen to always return the first dylib with that name loaded into
    # the process rather than the actual dylib found using rpath lookup.
    Dir["#{lib}/wine/{x86_64-unix,x86_32on64-unix}/*.so"].each do |dylib|
      chmod 0664, dylib
      MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
      MachO.codesign!(dylib)
      chmod 0444, dylib
    end

    # Install wine-gecko into place
diff --git a/include/distversion.h b/include/distversion.h