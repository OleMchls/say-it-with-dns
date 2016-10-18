defmodule DnsayTest do
  use ExUnit.Case, async: true

  import Dnsay
  doctest Dnsay

  describe "Dnsay.transform_to_dns_valid_string/1" do
    test "replaces spaces with configured character" do
      assert transform_to_dns_valid_string("hello world") == "hello-world"
    end
    test "normalizes utf-8 characters" do
      transformed = transform_to_dns_valid_string("árboles más grandes überfall")
      assert transformed == "arboles-mas-grandes-uberfall"
    end
  end

  describe "Dnsay.chunk/2" do
    test "splits words into buckets of given size" do
       assert chunk("hello world", 1) == ["hello", "world"]
    end
    test "splits big sentences into similar sized buckets" do
       assert chunk("hello world foo bar baz", 3) == ["hello world foo", "bar baz"]
    end
  end

  describe "Dnsay.build_tuple_list/2" do
    test "build a tuple list with previous and target tuple" do
      assert build_tuple_list(["a", "b"], "foo") == [{"foo", "a"}, {"a", "b"}]
    end
  end
end
