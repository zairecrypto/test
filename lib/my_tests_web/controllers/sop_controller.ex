defmodule MyTestsWeb.SopController do
  use MyTestsWeb, :controller
  import Ecto
  alias MyTests.{
    Repo,
    Sop
  }

  def index(conn, _params) do
    changeset = Sop.changeset(%Sop{}, %{})
    render conn, "index.html", changeset: changeset
  end

  def create(conn, params = %{"_csrf_token" => token, "sop" => sop}) do
    # To be fixed
    # 1. save without choosing a file


    IO.inspect params

    changeset = Sop.changeset(%Sop{}, %{})
    if sop["file"] do

      if upload = sop["file"] do

        extension = Path.extname(upload.filename)
        File.cp(upload.path, "priv/static/uploads/t#{extension}")

        IO.inspect extension

        conn
        |> put_flash(:info, "File exist, it will uploaded")
        |> render("index.html", changeset: changeset)

      else

        # could not find a matching  clause to process request
        conn
        |> put_flash(:error, "No files to be uploaded")
        |> render("index.html", changeset: changeset)

      end

    end
  end


  # def create(conn, %{"sop" => sop}) do
  #   IO.inspect sop
  #   if upload = sop["file"] do
  #     extension = Path.extname(upload.filename)
  #     File.cp(upload.path, "priv/static/uploads/TTTTTTTTTTTTTTTTTT#{extension}")
  #   end
  #   # Plug.Conn.send_file(conn, 200, "README.md")
  #   changeset = Sop.changeset(%Sop{}, %{})
  #   render conn, "index.html", changeset: changeset
  # end

end
