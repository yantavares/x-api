defmodule Api.Posts.AddLike do
  alias Api.Posts.Post
  alias Api.Repo

  alias Ecto.Changeset

  def call(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> add_like(post)
    end
  end

  defp add_like(post) do
    likes = post.likes + 1
    post = Changeset.change(post, likes: likes)

    case Repo.update(post) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
