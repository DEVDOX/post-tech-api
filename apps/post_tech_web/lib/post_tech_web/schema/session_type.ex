defmodule PostTechWeb.Schema.SessionType do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Resolvers

  import AbsintheErrorPayload.Payload
  import_types AbsintheErrorPayload.ValidationMessageTypes

  object :session_type do
    field :token, :string
    field :user_detail, :user_detail_type
  end

  payload_object(:session_payload_type, :session_type)

  input_object :login_params do
    field :strategy, non_null(:string)
    field :strategy_id, non_null(:string)
    field :strategy_token, non_null(:string)

    field :email, non_null(:string)
    field :avatar, non_null(:string)
    field :display_name, non_null(:string)
    field :unique_name, non_null(:string)
  end

  object :session_mutations do
    field :login, type: :session_payload_type do
      arg :params, non_null(:login_params)

      resolve &Resolvers.SessionResolver.login/3
      middleware &build_payload/2
    end
  end
end
