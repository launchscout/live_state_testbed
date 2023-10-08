defmodule HigherOrder do
  def higher_order_function(callback) do
    callback.("foo")
  end
end

defmodule Callback do
  def callback_function(arg) do
    arg <> " I was called!"
  end
end
