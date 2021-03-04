require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "新規登録/ユーザー情報" do
    context '新規登録できるとき' do
      it "一連の登録" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'nicknameが空だと登録できない' do
        @user.user_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("User name can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailに@を含める必要があるということ" do
        @user.email = "email.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "emailが一意性であること" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空だと登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードとパスワード（確認用）は、値の一致が必須であること" do
        @user.password = '000a00'
        @user.password_confirmation = '0101a0'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが6文字以上の入力が必要だということ" do
        @user.password = '0a000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードは、確認用を含めて2回入力すること" do
        @user.password = '0a0000'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "パスワードは、半角英語のみでは登録できないこと" do
        @user.password = 'aaaaaaa'
        @user.password_confirmation = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードは、半角数字のみでは登録できないこと" do
        @user.password = '0000000'
        @user.password_confirmation = '0000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードは、全角英数混合では登録できないこと" do
        @user.password = 'AAAA１１'
        @user.password_confirmation = 'AAAA１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end
  end
end
