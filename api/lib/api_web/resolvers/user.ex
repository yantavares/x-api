defmodule ApiWeb.Resolvers.User do
  def get(%{id: id}, _context), do: Api.get_user(id)
  def create(%{input: params}, _context), do: Api.create_user(params)
  def update(%{input: params}, _context), do: Api.update_user(params)
end
