defmodule SoulerlWeb.PageController do
  use SoulerlWeb, :controller

  alias SoulerWeb.Live.CalculatorView

  def index(conn, _params) do
    live_render(conn, CalculatorView, [])
  end
end
