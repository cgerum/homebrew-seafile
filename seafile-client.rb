require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.6.tar.gz"
  sha1 "507c7034ab402796e1015403cff796f2ac872820"
  revision 1

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :snow_leopard

  option "without-app", "Build without app bundle"

  stable do
    #[FIX] fix possible crash when starting program
    patch :p1 do
      url "https://github.com/Chilledheart/seafile-client/commit/8bd1224.diff"
      sha1 "b54cafbadb7b3d738bfed33fdaf602982285be88"
    end
  end

  depends_on "cmake" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "qt4"
  depends_on "openssl"
  depends_on "sqlite"
  depends_on "libsearpc"
  depends_on "ccnet"
  depends_on "seafile"

  def install

    cmake_args = std_cmake_args
    if build.with? "xcode"
      cmake_args << "-G" << "Xcode"
      system "cmake", ".", *cmake_args
      system "xcodebuild", "-target", "ALL_BUILD", "-configuration", "Release"
      prefix.install "Release/seafile-applet.app"
      app = prefix/"seafile-applet.app/Contents"
      mkdir_p app/"Resources"
      (app/"Resources").install_symlink "#{Formula["ccnet"].opt_prefix}/bin/ccnet"
      (app/"Resources").install_symlink "#{Formula["seafile"].opt_prefix}/bin/seaf-daemon"
    else
      system "cmake", ".", *cmake_args
      system "make"
      system "make", "install"
    end

  end
end
