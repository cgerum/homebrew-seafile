require "formula"

class SeafileClient40 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.7.tar.gz"
  sha1 "60805439ca157345547ceb27a397447e03a825a9"
  revision 1

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :snow_leopard

  option "without-app", "Build without app bundle"

  depends_on "cmake" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "qt4"
  depends_on "openssl"
  depends_on "sqlite"
  depends_on "libsearpc40"
  depends_on "ccnet40"
  depends_on "seafile40"

  conflicts_with "seafile-client"

  def install

    cmake_args = std_cmake_args
    if build.with? "app"
      cmake_args << "-G" << "Xcode" << "-DCMAKE_BUILD_TYPE=Release"
      system "cmake", ".", *cmake_args
      system "xcodebuild", "-target", "ALL_BUILD", "-configuration", "Release"
      File.rename "Release/seafile-applet.app", "Release/Seafile Client.app"
      prefix.install "Release/Seafile Client.app"
      app = prefix/"Seafile Client.app/Contents"
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
