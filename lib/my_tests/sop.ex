defmodule MyTests.Sop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sops" do
    field :title, :string, null: false

    timestamps()
  end

  def changeset(sop, params \\ %{}) do
    sop
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
