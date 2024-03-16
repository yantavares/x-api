defmodule ApiWeb.Resolvers.User do
  def get(%{id: id}, _context), do: Api.get_user(id)
  def create(%{input: params}, _context), do: Api.create_user(params)
  def update(%{input: params}, _context), do: Api.update_user(params)

  def add_follower(%{input: %{user_id: user_id, follower_id: follower_id}}, _context) do
    Api.add_follower(user_id, follower_id)
  end

  # User can be found because Post is child of User, so it receives parent in Resolver
  def get_user_posts(user, %{page: page, per_page: per_page}, _context) do
    Api.get_user_posts(user, page, per_page)
  end
end
