# X-Api

Simple API made with Elixir, GraphQL and Absinthe to achieve a Twitter-like experience.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Elixir 1.10+ installed
- Erlang/OTP 22+ installed
- PostgreSQL installed and running

## Setup

Follow these steps to get your development environment set up:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yantavares/x-api
   cd x-api/api
   ```

2. **Install Elixir Dependencies**

   Run the following command to install the Elixir dependencies specified in `mix.exs`:

   ```bash
   mix deps.get
   ```

3. **Create and Migrate Your Database**

   Make sure your PostgreSQL service is running.

   From `dev.exs`:
   
   ```ex
   config :api, Api.Repo,
      username: "postgres",
      password: "postgres",
      hostname: "localhost",
      database: "api_dev",
   ```

   Then, create and migrate your database:

   ```bash
   mix ecto.setup
   ```

   This command is a shortcut for `mix ecto.create`, `mix ecto.migrate`, and `mix run priv/repo/seeds.exs` to seed the database.

5. **Start the Phoenix Server**

   You can start your Phoenix app in one of two ways:

   - To start the server normally:

     ```bash
     mix phx.server
     ```

   - To start within an interactive Elixir shell (IEx):

     ```bash
     iex -S mix phx.server
     ```

   Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to see the running application.

## Exploring the API + Documentation

To explore the GraphQL API and documentation, visit [`http://localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) in your web browser. This interface allows you to execute queries and mutations against your API in real-time.

To see query examples, please read the [`README`](api/README.md) file inside `api` folder.

## Running Tests

To run the tests, use the following command:

```bash
mix test
```

## Learn More

- **Phoenix Framework**: [Official website](https://www.phoenixframework.org/)
- **Absinthe GraphQL**: [Documentation](https://hexdocs.pm/absinthe)
- **Elixir Language**: [Official website](https://elixir-lang.org/)
- **Elixir Forum**: [Phoenix Forum](https://elixirforum.com/c/phoenix-forum)
