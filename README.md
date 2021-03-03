# README

## userテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| user_name          | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many :posts
- has_many :comments

## postテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| text               | string     | null: false, unique: true      |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :comments

## commentテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| text               | string     | null: false, unique: true      |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post