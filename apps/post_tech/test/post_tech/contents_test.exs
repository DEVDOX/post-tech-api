defmodule PostTech.ContentsTest do
  use PostTech.DataCase

  alias PostTech.Contents

  describe "posts" do
    alias PostTech.Contents.Post

    @valid_attrs %{body: "some body", title: "some title", url: "some url", uuid: "some uuid"}
    @update_attrs %{body: "some updated body", title: "some updated title", url: "some updated url", uuid: "some updated uuid"}
    @invalid_attrs %{body: nil, title: nil, url: nil, uuid: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contents.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Contents.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Contents.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Contents.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.title == "some title"
      assert post.url == "some url"
      assert post.uuid == "some uuid"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Contents.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.title == "some updated title"
      assert post.url == "some updated url"
      assert post.uuid == "some updated uuid"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Contents.update_post(post, @invalid_attrs)
      assert post == Contents.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Contents.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Contents.change_post(post)
    end
  end
end
