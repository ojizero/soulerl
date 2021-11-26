defmodule SoulerWeb.Live.CalculatorView do
  use Phoenix.LiveView

  def render(assigns \\ [results: %{}]) do
    ~L"""
    <form phx-submit="calculate">
      <input type="number" name="number" placeholder="You number" autocomplete="off"/>
      <button type="submit">Do the math!</button>
    </form>

    <div>
    <%= for {eq, res} <- @results do %>
      <div><%= eq %> = <%= res %></div>
    <%= end %>
    </div>
    """
  end

  def handle_event("calculate", %{"number" => number}, socket) do
    eq = "1..#{number}"
    task = number |> String.to_integer() |> Soulerl.Calculator.Task.sum_to()
    Process.put(task.ref, eq)

    results = Map.put(socket.assigns.results, eq, "calculating")

    {:noreply, assign(socket, results: results)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, results: %{})}
  end

  def handle_info({ref, res}, socket) do
    eq = Process.get(ref)

    results = Map.put(socket.assigns.results, eq, to_string(res))

    {:noreply, assign(socket, results: results)}
  end

  def handle_info(
        {:DOWN, ref, :process, _pid, {%RuntimeError{}, _stacktrace}},
        socket
      ) do
    eq = Process.get(ref)

    results = Map.put(socket.assigns.results, eq, "error")

    {:noreply, assign(socket, results: results)}
  end

  def handle_info(_whatever, socket) do
    {:noreply, socket}
  end
end
