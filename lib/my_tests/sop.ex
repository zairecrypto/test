defmodule MyTests.Sop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sops" do
    field :file_title, :string, null: false

    timestamps()
  end

  def changeset(sop, params \\ %{}) do
    sop
    |> cast(params, [:file_title])
    |> validate_required([:file_title])
  end
end
