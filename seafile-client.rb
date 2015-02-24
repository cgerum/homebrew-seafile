require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.7.tar.gz"
  sha1 "60805439ca157345547ceb27a397447e03a825a9"

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :snow_leopard

  option "without-app", "Build without app bundle"

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
