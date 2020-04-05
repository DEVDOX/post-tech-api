defmodule PostTechWeb.Schema.CustomTypes do
  @enforce_keys [:metadata]
  defstruct entries: [], messages: [], metadata: %{}

  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.ChangesetParser

  alias __MODULE__

  defmacro paginate_object(pagination_name, object_name) do
    quote location: :keep do
      object unquote(pagination_name) do
        field :entries, list_of(unquote(object_name))
        field :metadata, non_null(:metadata_type)
      end
    end
  end
end
