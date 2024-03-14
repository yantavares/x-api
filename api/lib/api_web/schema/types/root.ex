defmodule ApiWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias ApiWeb.Resolvers.User, as: UserResolver
  import_types(ApiWeb.Schema.Types.User)

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)

      resolve &UserResolver.get/2
    end
  end
end
