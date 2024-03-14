defmodule ApiWeb.Resolvers.User do
  def get(%{id: id}, _context), do: Api.get_user(id)
end
