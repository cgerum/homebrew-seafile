require "formula"

class Ccnet31 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/ccnet/archive/v3.1.11.tar.gz"
  version "3.1.11"
  sha1 "96bede14da1c37648cc576f2cd37a7469e4e3ce4"

  head "https://github.com/haiwen/ccnet.git"

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/48610f08.diff"
    sha1 "af5a53ffb9fca0d4918b9d2ef1afd54959ecf186"
  end

  #[FIX] openssl build
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/4bede362.diff"
    sha1 "e6c540344dfa4d4650cf3e370f2421d897319ab6"
  end

  option "with-brewed-sqlite", "Build with Homebrew sqlite3"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "vala" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "libzdb"
  depends_on "libevent"
  depends_on "openssl"
  depends_on "sqlite" if build.with? "brewed-sqlite"
  depends_on "libsearpc31"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-client
      --disable-server
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
