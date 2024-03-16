defmodule Api.Users.Get do
  alias Api.Repo
  alias Api.Users.User

  def call(id) do
    case(Repo.get(User, id)) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, Repo.preload(user, followers: [:follower], following: [:following])}
    end
  end
end
