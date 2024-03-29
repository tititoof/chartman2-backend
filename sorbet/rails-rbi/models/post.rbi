# This is an autogenerated file for dynamic methods in Post
# Please rerun bundle exec rake rails_rbi:models[Post] to regenerate.

# typed: strong
module Post::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Post::GeneratedAttributeMethods
  sig { returns(String) }
  def content; end

  sig { params(value: T.any(String, Symbol)).void }
  def content=(value); end

  sig { returns(T::Boolean) }
  def content?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(String) }
  def description; end

  sig { params(value: T.any(String, Symbol)).void }
  def description=(value); end

  sig { returns(T::Boolean) }
  def description?; end

  sig { returns(String) }
  def id; end

  sig { params(value: T.any(String, Symbol)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def published_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def published_at=(value); end

  sig { returns(T::Boolean) }
  def published_at?; end

  sig { returns(String) }
  def title; end

  sig { params(value: T.any(String, Symbol)).void }
  def title=(value); end

  sig { returns(T::Boolean) }
  def title?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end

  sig { returns(String) }
  def user_id; end

  sig { params(value: T.any(String, Symbol)).void }
  def user_id=(value); end

  sig { returns(T::Boolean) }
  def user_id?; end
end

module Post::GeneratedAssociationMethods
  sig { returns(::Article::ActiveRecord_Associations_CollectionProxy) }
  def articles; end

  sig { returns(T::Array[String]) }
  def article_ids; end

  sig { params(value: T::Enumerable[::Article]).void }
  def articles=(value); end

  sig { returns(::Category::ActiveRecord_Associations_CollectionProxy) }
  def categories; end

  sig { returns(T::Array[String]) }
  def category_ids; end

  sig { params(value: T::Enumerable[::Category]).void }
  def categories=(value); end

  sig { returns(::User) }
  def user; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user!(*args, &block); end

  sig { params(value: ::User).void }
  def user=(value); end

  sig { returns(::User) }
  def reload_user; end
end

module Post::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Post]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Post]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Post]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Post)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Post) }
  def find_by_id!(id); end
end

class Post < ApplicationRecord
  include Post::GeneratedAttributeMethods
  include Post::GeneratedAssociationMethods
  extend Post::CustomFinderMethods
  extend Post::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Post::ActiveRecord_Relation, Post::ActiveRecord_Associations_CollectionProxy, Post::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def self.from_category(*args); end
end

class Post::ActiveRecord_Relation < ActiveRecord::Relation
  include Post::ActiveRelation_WhereNot
  include Post::CustomFinderMethods
  include Post::QueryMethodsReturningRelation
  Elem = type_member(fixed: Post)

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def from_category(*args); end
end

class Post::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Post::ActiveRelation_WhereNot
  include Post::CustomFinderMethods
  include Post::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Post)

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def from_category(*args); end
end

class Post::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Post::CustomFinderMethods
  include Post::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Post)

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def from_category(*args); end

  sig { params(records: T.any(Post, T::Array[Post])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Post, T::Array[Post])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Post, T::Array[Post])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Post, T::Array[Post])).returns(T.self_type) }
  def concat(*records); end
end

module Post::QueryMethodsReturningRelation
  sig { returns(Post::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Post::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Post).returns(T::Boolean)).returns(T::Array[Post]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Post::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Post::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Post::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Post::QueryMethodsReturningAssociationRelation
  sig { returns(Post::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Post::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Post::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Post).returns(T::Boolean)).returns(T::Array[Post]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Post::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Post::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Post::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end
