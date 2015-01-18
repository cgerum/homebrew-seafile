require "formula"

class SeafileClient < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile-client/archive/v4.0.6.tar.gz"
  sha1 "507c7034ab402796e1015403cff796f2ac872820"

  head "https://github.com/haiwen/seafile-client.git"

  depends_on MinimumMacOSRequirement => :snow_leopard

  option "with-xcode", "Build with XCODE_APP Flags"

  #[FIX] fix possible crash when starting program
  patch :p1 do
    url "https://github.com/Chilledheart/seafile-client/commit/8bd1224.diff"
    sha1 "b54cafbadb7b3d738bfed33fdaf602982285be88"
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

    # todo use xcode generator to build a app bundle
    cmake_args = std_cmake_args
    if build.with? "xcode"
      cmake_args << "-DCMAKE_CXX_FLAGS=\"-DXCODE_APP\""
    end
    system "cmake", ".", *cmake_args
    system "make"
    system "make", "install"
  end
end
