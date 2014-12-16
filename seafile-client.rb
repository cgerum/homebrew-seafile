require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.4.tar.gz"
  sha1 "1b2ac38957b8bd2af8145cf3ee606ceabecc120d"

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :lion

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
