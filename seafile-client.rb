require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.3.tar.gz"
  sha1 "1091acf159e4f4e9feaba1bd8ab1a2ea8d9e20cc"
  version "4.0.3"

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :lion

  option "with-brewed-sqlite", "Build with Homebrew sqlite3"
  option "with-xcode", "Build with XCODE_APP Flags"

  depends_on "cmake" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "qt4"
  depends_on "openssl"
  depends_on "sqlite" if build.with? "brewed-sqlite"

  depends_on "libsearpc"
  depends_on "ccnet"
  depends_on "seafile"

  def install

    cmake_args = std_cmake_args
    if build.with? "xcode"
      cmake_args << "-DCMAKE_CXX_FLAGS=\"-DXCODE_APP\""
    end
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "install"
  end
end
