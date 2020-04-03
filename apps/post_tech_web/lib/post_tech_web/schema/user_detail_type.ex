defmodule PostTechWeb.Schema.UserDetailType do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Resolvers

  import AbsintheErrorPayload.Payload
  import_types AbsintheErrorPayload.ValidationMessageTypes

  object :contact_type do
    field :id, :id
    field :type, :string
    field :url, :string
  end

  object :user_detail_type do
    field :id, :id
    field :display_name, :string
    field :avatar, :string
    field :tagline, :string
    field :location, :string
    field :company, :string
    field :unique_name, :string
  end

  input_object :create_user_detail do
    field :display_name, :string
    field :avatar, :string
    field :location, :string
    field :company, :string
    field :unique_name, non_null(:string)
  end

  input_object :create_params do
    field :strategy, non_null(:string)
    field :strategy_id, :string

    field :avatar, :string
    field :email, :string
    field :display_name, :string
    field :unique_name, :string
  end

  input_object :contact_params do
    field :type, non_null :string
    field :url, non_null :string
  end

  payload_object(:user_detail_type_payload, :user_detail_type)
  payload_object(:contact_type_payload, :contact_type)

  object :user_mutations do
    # field :create_user, type: :user_detail_type_payload do
    #   arg :params, non_null(:create_params)
    #   resolve &Resolvers.UserDetailResolver.create_user/3
    #   middleware &build_payload/2
    # end

    field :create_contacts, type: :contact_type_payload do
      arg :params, list_of :contact_params
      resolve &Resolvers.UserDetailResolver.create_contacts/3
      middleware &build_payload/2
    end
  end
end
