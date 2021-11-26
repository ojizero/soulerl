defmodule Soulerl.Calculator do
  def sum_to(13), do: raise("Oh no!")
  def sum_to(number), do: do_sum_to(1, number + 1, 0)

  defp do_sum_to(current, max, acc) when current == max, do: acc
  defp do_sum_to(current, max, acc), do: do_sum_to(current + 1, max, acc + current)
end

defmodule Soulerl.Calculator.Task do
  alias Soulerl.Calculator

  def sum_to(number) do
    Task.Supervisor.async_nolink(:calc, fn -> Calculator.sum_to(number) end)
  end
end
