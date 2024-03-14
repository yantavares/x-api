defmodule ApiWeb.Schema do
  use Absinthe.Schema
  import_types ApiWeb.Schema.Types.Root

  query do
    import_fields :root_query
  end
end
