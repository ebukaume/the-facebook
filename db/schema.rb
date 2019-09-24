# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_23_174522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "author_id"
    t.string "post_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "post_id"], name: "index_comments_on_author_id_and_post_id"
    t.index ["id"], name: "index_comments_on_id", unique: true
  end

  create_table "friends", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "user_id"
    t.string "friend_id"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_friends_on_id", unique: true
    t.index ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id"
  end

  create_table "friendships", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "user_id"
    t.string "friend_id"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_friendships_on_id", unique: true
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id"
  end

  create_table "likes", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "liker_id"
    t.string "likeable_id"
    t.string "likeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_likes_on_id", unique: true
    t.index ["likeable_id", "likeable_type", "liker_id"], name: "index_likes_on_likeable_id_and_likeable_type_and_liker_id"
  end

  create_table "posts", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "author_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_posts_on_id", unique: true
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "sex"
    t.date "dob"
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
