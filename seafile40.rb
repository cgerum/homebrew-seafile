require "formula"

class Seafile40 < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/seafile/archive/v4.0.7.tar.gz"
  sha1 "a1253304d46dd85b9fb5f45a75eaf2623aafc59f"

  head "https://github.com/haiwen/seafile.git"

  #[FIX] fix openssl build
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/79fc942d.diff"
    sha1 "a4c81dbf6e131502b2c229b9cab2f324e8c51e5d"
  end

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/5848eb75.diff"
    sha1 "b8b0d17ae03474e996ce7e2a42aefe0edb80d159"
  end

  #[FIX] use system zlib
  patch :p1 do
    url "https://github.com/Chilledheart/seafile/commit/239c148b.diff"
    sha1 "da429338d1726b95e26b70f7a9ce1bfa3a7392ae"
  end

  depends_on MinimumMacOSRequirement => :snow_leopard

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "vala" => :build
  depends_on "glib"
  depends_on "jansson"
  depends_on "libevent"
  depends_on "openssl"
  depends_on "sqlite"
  depends_on "curl"

  depends_on "libsearpc40"
  depends_on "ccnet40"

  conflicts_with "seafile"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-client
      --disable-server
      --disable-fuse
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
