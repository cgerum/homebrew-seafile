require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.5.tar.gz"
  sha1 "bb9e793e587a29a2883bf218247b6a1bde592468"

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :snow_leopard

  option "with-xcode", "Build with XCODE_APP Flags"

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
      cmake_args << "-DCMAKE_CXX_FLAGS=\"-DXCODE_APP\""
    end
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "install"
  end
end
