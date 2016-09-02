defmodule ErlangElixir do
  def erlang_float_to_string_2_decimal do
    :io.format("~.2f~n", [2.0/3.0])
  end

  def elixir_get_env_variable do
    System.get_env("HOME")
  end

  def elixir_get_file_extension do
    Path.extname("./modules_and_functions_7.exs");
  end

  def elixir_get_current_working_directory do
    System.cwd
  end

  def elixir_convert_json_to_elixir_data_structure do
    """
    Convert a string containing JSON into Elixir data structures
    There are many options. Some, such as https://github.com/guedes/exjson,
    are specifically for Elixir. Others, such as https://github.com/hio/erlang-json
    are Elnag libraries that are usable from Elixir.
    """
  end

  def elixir_execute_command_in_os_shell do
    System.cmd("echo", ["hello"])
  end
end

IO.inspect ErlangElixir.erlang_float_to_string_2_decimal
IO.inspect ErlangElixir.elixir_get_env_variable
IO.inspect ErlangElixir.elixir_get_current_working_directory
IO.inspect ErlangElixir.elixir_convert_json_to_elixir_data_structure
IO.inspect ErlangElixir.elixir_execute_command_in_os_shell
