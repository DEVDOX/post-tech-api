defmodule PostTech.Utils do
  @moduledoc """
  Utils
  """
  import Ecto.Changeset

  def check_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, UUID.uuid4(:hex))
      _ ->
        changeset
    end
  end

  def generate_url(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        uuid = UUID.uuid4(:hex)
        force_change(changeset, :uuid, uuid)
        force_change(changeset, :url, ShortUUID.encode!(uuid))
      uuid ->
        force_change(changeset, :url, ShortUUID.encode!(uuid))
    end
  end
end
