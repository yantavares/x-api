defmodule ApiWeb.Resolvers.User do
  def get(%{id: id}, _context), do: Api.get_user(id)
  def create(%{input: params}, _context), do: Api.create_user(params)
  def update(%{input: params}, _context), do: Api.update_user(params)

  def add_follower(%{input: %{user_id: user_id, follower_id: follower_id}}, _context) do
    with {:ok, result} <- Api.add_follower(user_id, follower_id) do
      Absinthe.Subscription.publish(ApiWeb.Endpoint, result, new_follow: "new_follow_topic")
      {:ok, result}
    end
  end
end
