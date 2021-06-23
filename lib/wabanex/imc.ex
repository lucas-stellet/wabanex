defmodule Wabanex.IMC do
  @moduledoc false

  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> remove_csv_columns_name()
      |> Enum.map(&parse_line/1)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}), do: {:error, "Error while opening the file!"}

  defp remove_csv_columns_name(content) do
    [_hd | tl] = content
    tl
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight * height / 2}
end
