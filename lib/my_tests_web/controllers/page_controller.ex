defmodule MyTestsWeb.PageController do
  use MyTestsWeb, :controller

  def index(conn, _params) do
    file = "static/image/phoenix.png"
    render conn, "index.html", file: file
  end
end
