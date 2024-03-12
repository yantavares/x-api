defmodule Api.Users.Create do
  alias Api.Users.User
  alias Api.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
