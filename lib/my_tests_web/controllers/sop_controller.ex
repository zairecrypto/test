defmodule MyTestsWeb.SopController do
  use MyTestsWeb, :controller
  import Ecto
  alias MyTests.{
    Repo,
    Sop,
    Accounts
  }

  plug :check_auth when action in [:new, :create, :edit, :update, :delete]

  defp check_auth(conn, _args) do
    if user_id = get_session(conn, :current_user_id) do
    current_user = Accounts.get_user!(user_id)

    conn
      |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:error, "You need to be signed in to access that page.")
      |> redirect(to: sop_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    changeset = Sop.changeset(%Sop{}, %{})
    sops = Repo.all(Sop)
    render conn, "index.html", changeset: changeset, sops: sops
  end

  def create(conn, params = %{"_csrf_token" => token, "sop" => sop}) do
    # To be fixed
    # 1. save without choosing a file


    changeset = Sop.changeset(%Sop{}, %{})
    sops = Repo.all(Sop)

    if sop["file"] do

      if upload = sop["file"] do

        # 1. upload the file
        # file_name_prefix = String.slice sop["location"], 0..3
        file_name_prefix = "LOC"
        extension = Path.extname(upload.filename)
        file      = "/images/sop_#{file_name_prefix}_#{:os.system_time(:millisecond)}_#{extension}"

        # 2. build the changeset
        new_sop = %{
          "file_title" => file
        }

        # 3. add the sop to database
        changeset = Sop.changeset(%Sop{}, new_sop)
        case Repo.insert(changeset) do
          {:ok, _sop} ->
            File.cp(upload.path, "priv/static#{file}")
            conn
            |> put_flash(:info, "New SoP Succesfully Uploaded on the server")
            |> render("index.html", changeset: changeset, sops: sops)
          {:error, changeset} ->
            conn
            |> put_flash(:error, "Something went wrong")
            |> render("index.html", changeset: changeset, sops: sops)
        end

      else

        # could not find a matching  clause to process request
        conn
        |> put_flash(:error, "No files to be uploaded")
        |> render("index.html", changeset: changeset, sops: sops)

      end

    end
  end

end
