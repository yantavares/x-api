defmodule Api.Posts.Get do
  alias Api.Posts.Post
  alias Api.Repo

  import Ecto.Query

  def call(user, page, per_page) do
    posts_query =
      from p in Post,
        where: p.user_id == ^user.id,
        order_by: [desc: p.id],
        offset: (^page - 1) * ^per_page,
        limit: ^per_page

    {:ok, Repo.all(posts_query)}
  end
end
