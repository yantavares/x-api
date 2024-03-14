defmodule ApiWeb.Resolvers.Post do
  def create(%{input: params}, _context), do: Api.create_post(params)
  def add_like(%{id: id}, _context), do: Api.add_like_to_post(id)
end
