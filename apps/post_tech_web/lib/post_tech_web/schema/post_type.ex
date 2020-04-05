defmodule PostTechWeb.Schema.PostType do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Resolvers
  alias PostTechWeb.Middlewares.Authentication

  import PostTechWeb.Schema.CustomTypes
  import AbsintheErrorPayload.Payload

  import_types AbsintheErrorPayload.ValidationMessageTypes

  object :tags do
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
    field :user_detail, :user_detail_type
    field :state, :string
    field :tags, list_of(:tags)
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  input_object :tag_params do
    field :name, non_null(:string)
  end

  input_object :tag_params do
    field :name, non_null(:string)
  end

  input_object :create_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :state, non_null(:string)
    field :tags, list_of(:tag_params)
  end

  # Mutation Result payload
  payload_object(:post_payload_type, :post_type)
  payload_object(:like_payload_type, :like_type)

  # Pagination payload
  paginate_object(:post_pagination_type, :post_type)

  # Queries
  object :post_queries do
    field :get_post_by_url, type: :post_type do
      arg :url, :string
      resolve &Resolvers.PostResolver.get_post/3
    end

    field :get_public_posts, type: :post_pagination_type do
      arg :after, :string
      arg :before, :string
      arg :limit, :string
      resolve &Resolvers.PostResolver.get_public_posts/3
    end

    field :get_user_posts_by_id, type: :post_pagination_type do
      arg :after, :string
      arg :before, :string
      arg :limit, :string
      arg :user_id, non_null(:integer)
      resolve &Resolvers.PostResolver.get_user_posts/3
    end

    field :get_user_posts_by_u_name, type: :post_pagination_type do
      arg :after, :string
      arg :before, :string
      arg :limit, :string
      arg :unique_name, non_null(:string)
      resolve &Resolvers.PostResolver.get_user_posts/3
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

    field :like_post, type: :like_payload_type do
      arg :post_url, non_null(:string)
      middleware Authentication
      resolve &Resolvers.PostResolver.create_like/3
      middleware &build_payload/2
    end
  end
end
