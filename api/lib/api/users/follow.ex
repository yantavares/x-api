defmodule Api.Users.Follow do
  alias Api.Users.User
  alias Api.Repo
  alias Api.Users.Follower

  def call(user_id, follower_id) do
    with {:ok, _user1} <- get_user(user_id),
         {:ok, _user2} <- get_user(follower_id) do
      create_follower(user_id, follower_id)
    end
  end

  defp create_follower(user_id, follower_id) do
    %{follower_id: follower_id, following_id: user_id}
    |> Follower.changeset()
    |> Repo.insert()
  end

  defp get_user(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
