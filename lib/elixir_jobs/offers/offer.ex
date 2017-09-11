defmodule ElixirJobs.Offers.Offer do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirJobs.{
    Offers.Offer,
    EctoEnums.JobTime,
    EctoEnums.JobType
  }


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "offers" do
    field :title, :string
    field :description, :string
    field :location, :string
    field :url, :string

    field :job_time, JobTime
    field :job_type, JobType

    timestamps()
  end

  @required_attrs [:title, :description, :location, :url, :job_time, :job_type]
  @optional_attrs []
  @attributes @required_attrs ++ @optional_attrs

  @doc false
  def changeset(%Offer{} = offer, attrs) do
    offer
    |> cast(attrs, @attributes)
    |> validate_required(@required_attrs)
    |> validate_length(:title, min: 10, max: 80)
    |> validate_length(:description, min: 10, max: 500)
    |> validate_length(:location, min: 3, max: 50)
    |> validate_length(:url, min: 1, max: 255)
    |> validate_format(:url, ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
    |> validate_inclusion(:job_time, JobTime.__valid_values__())
    |> validate_inclusion(:job_type, JobType.__valid_values__())
  end
end
