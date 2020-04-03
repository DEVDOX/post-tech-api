defmodule PostTech.Contents.PostState do
import EctoEnum
  defenum PostStateEnum,
    published: "published", private: "private", draft: "draft"
end
