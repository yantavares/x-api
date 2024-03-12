defmodule Api.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Posts.Post

  @required_params [:nickname, :email, :age]

  schema "users" do
    field :nickname, :string
    field :email, :string
    field :age, :integer

    has_many :posts, Post
    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:nickname, min: 3, max: 20)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:email)
    |> unique_constraint(:nickname)
  end
end
