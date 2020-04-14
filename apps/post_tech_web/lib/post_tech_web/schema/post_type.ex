defmodule PostTechWeb.Schema.PostType do
  @moduledoc false
  use Absinthe.Schema.Notation

  import PostTechWeb.Schema.CustomTypes
  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias PostTechWeb.{Data, Resolvers}
  alias PostTechWeb.Middlewares.Authentication

  import_types AbsintheErrorPayload.ValidationMessageTypes

  object :tag_type do
    field :id, :id
    field :name, :string
    field :url_name, :string
  end

  object :like_type do
    field :id, :id
    field :inserted_at, :string
    field :updated_at, :string
  end

  object :post_type do
    field :id, :id
    field :title, :string
    field :body, :string
    field :url, :string
    field :uuid, :string
    field :state, :string

    field :author, :user_detail_type,
      resolve: dataloader(Data, :user_detail, [])

    field :tags, list_of(:tag_type),
      resolve: dataloader(Data, :tags, [])

    field :likes, list_of(:like_type),
      resolve: dataloader(Data, :likes, [])

    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :like_count, :integer
  end

  @desc """
  Input params for tags
  """
  input_object :tag_params do
    field :id, :id
    field :name, non_null(:string)
  end

  @desc """
  Input params for creating new post
  """
  input_object :create_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :state, non_null(:string)
    field :tags, list_of(:tag_params)
  end

  @desc """
  Input params to be used when updating a post
  """
  input_object :update_post_params do
    field :url, non_null(:string)
    field :title, :string
    field :body, :string
    field :state, :string
    field :tags, list_of(:tag_params)
  end

  @desc """
    Post payload object types for mutations
  """
  payload_object(:post_payload_type, :post_type)

  @desc """
    Liek payload object types for mutations
  """
  payload_object(:like_payload_type, :like_type)

  @desc """
    Pagination object for post
  """
  paginate_object(:post_pagination_type, :post_type)

  # Queries
  object :post_queries do
    @desc """
    Search every tag by any characters.
    """
    field :search_tags, type: list_of(:tag_type) do
      arg :char, :string
      resolve &Resolvers.PostResolver.search_tags/3
    end

    @desc """
    Finds a like from a given url
    """
    field :like, type: :like_type do
      arg :url, :string, description: "Url of a post"

      middlew Authentication
      resolve &Resolvers.PostResolver.get_like/3
    end

    @desc """
    Find a specific post by url
    """
    field :post_by_url, type: :post_type do
      arg :url, :string

      middlew Authentication
      resolve &Resolvers.PostResolver.get_post/3
    end

    @desc """
    Fetch 10 posts where state is published
    """
    field :public_posts, type: :post_pagination_type do
      arg :metadata, :metadata_input
      resolve &Resolvers.PostResolver.get_public_posts/3
    end

    @desc """
    Fetch 10 posts from a user where state is published
    """
    field :user_posts_by_id, type: :post_pagination_type do
      arg :metadata, :metadata_input
      arg :user_id, non_null(:integer)
      resolve &Resolvers.PostResolver.get_user_posts/3
    end

    @desc """
    Fetch 10 liked posts from a user where state is published
    """
    field :user_liked_posts, type: :post_pagination_type do
      arg :metadata, :metadata_input
      arg :unique_name, non_null(:string)
      resolve &Resolvers.PostResolver.get_user_liked_posts/3
    end

    @desc """
    Fetch posts from a user
    """
    field :user_posts_by_u_name, type: :post_pagination_type do
      arg :metadata, :metadata_input
      arg :unique_name, non_null(:string)
      resolve &Resolvers.PostResolver.get_user_posts/3
    end

    @desc """
    Fetch 10 posts by tag
    """
    field :posts_by_tag, type: :post_pagination_type do
      arg :metadata, :metadata_input
      arg :url, non_null(:string)
      resolve &Resolvers.PostResolver.get_posts_by_tag/3
    end

    @desc """
    Fetch 10 liked posts from a user where state is published
    """
    field :user_liked_posts, type: :post_pagination_type do
      arg :metadata, :metadata_input
      arg :unique_name, non_null(:string)
      resolve &Resolvers.PostResolver.get_user_liked_posts/3
    end
  end

  # Mutations
  object :post_mutations do
    field :create_post, type: :post_payload_type do
      arg :params, non_null(:create_post_params)
      middleware Authentication
      resolve &Resolvers.PostResolver.create_post/3
      middleware &build_payload/2
    end

    field :update_post, type: :post_payload_type do
      arg :params, non_null(:update_post_params)
      middleware Authentication
      resolve &Resolvers.PostResolver.update_post/3
      middleware &build_payload/2
    end

    field :delete_post, type: :post_payload_type do
      arg :url, non_null(:string)
      middleware Authentication
      resolve &Resolvers.PostResolver.delete_post/3
      middleware &build_payload/2
    end

    field :add_like, type: :like_payload_type do
      arg :url, non_null(:string)
      middleware Authentication
      resolve &Resolvers.PostResolver.create_like/3
      middleware &build_payload/2
    end

    field :delete_like, type: :like_payload_type do
      arg :url, non_null(:string)
      middlew Authentication
      resolve &Resolvers.PostResolver.delete_like/3
      middleware &build_payload/2
    end
  end
end
