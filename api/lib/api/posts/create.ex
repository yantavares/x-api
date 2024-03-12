defmodule Api.Posts.Create do
  alias Api.Posts.Post
  alias Api.Repo

  def call(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
  end
end
