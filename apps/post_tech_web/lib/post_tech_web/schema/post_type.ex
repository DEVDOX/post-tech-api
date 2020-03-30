defmodule PostTechWeb.Schema.PostType do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Resolvers

  import AbsintheErrorPayload.Payload
  import_types AbsintheErrorPayload.ValidationMessageTypes

  object :post_type do
    field :id, :id
    field :title, :string
    field :body, :string
    field :url, :string
    field :uuid, :string
    field :author, :user_detail_type
  end

  input_object :create_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
  end

  payload_object(:post_payload_type, :post_type)

  object :post_mutations do
    field :create_post, type: :post_payload_type do
      arg :params, non_null(:create_post_params)
      resolve &Resolvers.PostResolver.create_post/3
      middleware &build_payload/2
    end
  end
end
