defmodule Dnsay do

  def transform_to_dns_valid_string(string) do
    string
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
    |> String.replace(~r/\s/, Application.get_env(:dnsay, :whitespace))
  end

  def chunk(string, chunk_size) do
    string
    |> String.split
    |> Enum.chunk(chunk_size, chunk_size, [])
    |> Enum.map(&(Enum.join(&1, " ")))
  end

  def build_tuple_list(list, start) do
    do_build_tuple_list(start, list, [])
  end

  defp do_build_tuple_list(prev, [], result), do: Enum.reverse(result)
  defp do_build_tuple_list(prev, [target| rest], result) do
     do_build_tuple_list(target, rest, [{prev, target} | result])
  end

end
