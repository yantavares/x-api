defmodule SchemaTest do
  use ApiWeb.ConnCase, async: true

  describe "users query" do
    test "returns a user", %{conn: conn} do
      user_params = %{nickname: "foo", age: 22, email: "foo@bar.com"}

      {:ok, user} = Api.create_user(user_params)

      query = """
      {
        user(id: #{user.id}){
          nickname,
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => %{"email" => "foo@bar.com", "nickname" => "foo"}}
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end

    test "when error, returns error", %{conn: conn} do
      query = """
      {
        user(id: 999){
          nickname,
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "not_found",
            "path" => ["user"]
          }
        ]
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when params are valid, create user", %{conn: conn} do
      query = """
      mutation{
        createUser(input: {nickname: "foo", email: "foo@bar.com", age: 41}){
          id,
          nickname,
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert %{
               "data" => %{
                 "createUser" => %{"id" => _id, "nickname" => "foo"}
               }
             } = response
    end
  end

  describe "new subscription" do
    test "new follow", %{socket: socket} do
      user_params1 = %{nickname: "foo", age: 22, email: "foo@bar.com"}
      {:ok, user1} = Api.create_user(user_params1)

      user_params2 = %{nickname: "bar", age: 33, email: "bar@foo.com"}
      {:ok, user2} = Api.create_user(user_params2)

      mutation = """
      mutation{
        addFollower(input: {followerId: #{user1.id}, userId: #{user2.id}}){
          followingId,
          followerId
        }
      }
      """

      subscription = """
      subscription{
        newFollow{
          followerId,
          followingId
        }
      }
      """

      # Setup -> Subscription
      socket_ref = push_doc(socket, subscription)
      assert_reply socket_ref, :ok, %{subscriptionId: subscription_id}

      # Setup -> Mutation
      socket_ref = push_doc(socket, mutation)
      assert_reply socket_ref, :ok, mutation_response

      expected_mutation_response = %{
        data: %{"addFollower" => %{"followerId" => "#{user1.id}", "followingId" => "#{user2.id}"}}
      }

      assert mutation_response == expected_mutation_response

      expected_subscription_response = %{
        result: %{
          data: %{"newFollow" => %{"followerId" => "#{user1.id}", "followingId" => "#{user2.id}"}}
        },
        subscriptionId: "#{subscription_id}"
      }

      assert_push("subscription:data", subscription_response)

      assert subscription_response == expected_subscription_response
    end
  end
end
