require "formula"

class SeafileClient31 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v3.1.11.tar.gz"
  sha1 "5fb33b5f63e11fb768ac5a3c26b5c5a7e6145aa8"
  version "3.1.11"

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

  depends_on "libsearpc31"
  depends_on "ccnet31"
  depends_on "seafile31"

  conflicts_with "seafile-client"

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
