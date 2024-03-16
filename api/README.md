# X-Api

Simple API made with Elixir, GraphQL and Absinthe to achieve a Twitter-like experience.

## Example Queries

In this section, you'll find examples of GraphQL queries and mutations that can be executed against the API. For more comprehensive information and all available responses, please refer to the documentation accessible at `localhost:4000/api/graphiql` after starting the Phoenix server.

### Read User

```graphql
{
  user(id: 2) {
    nickname
    email
    posts(page: 1, perPage: 5) {
      id
      text
    }
    followers {
      followerId
      follower {
        nickname
        id
      }
    }
    following {
      followingId
      following {
        nickname
        id
      }
    }
  }
}
```

### Create User

```graphql
mutation {
  createUser(
    input: { nickname: "Fulano2", email: "fulano2@ful.com", age: 41 }
  ) {
    id
    nickname
    email
  }
}
```

### Update User

```graphql
mutation {
  updateUser(input: { id: 1, email: "yan3@yan.com" }) {
    id
    nickname
    email
    age
  }
}
```

### Create Post

```graphql
mutation {
  createPost(input: { userId: 1, text: "Hello, World!" }) {
    id
    text
    likes
  }
}
```

### Add Like to Post

```graphql
mutation {
  addLikeToPost(id: 99) {
    text
    likes
  }
}
```

### Add Follower

```graphql
mutation {
  addFollower(input: { followerId: 6, userId: 7 }) {
    followingId
    followerId
  }
}
```

### New Subscription (Only in simple mode)

To enable testing of subscriptions in GraphiQL, you should run GraphiQL in simple mode. To do this, modify the `/graphiql` route in your `router.ex` file by adding the `interface: :simple` option.

```graphql
subscription {
  newFollow {
    followerId
    userId
  }
}
```
