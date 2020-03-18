defmodule MyTestsWeb.PageController do
  use MyTestsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
