require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.create({
    name: "test", 
    email: "test@test.com",
    password: "testing",
    password_confirmation: "testing"
  })
  end

  describe 'Validations' do
    it 'should have all fields' do
      expect(@user.valid?).to be_truthy
    end
    
    it 'should return error where password confirmation is not matching' do
      @user.password = 'incorrect'
      @user.save
      expect(@user.errors.full_messages).to_not be_empty
  end

    it 'should throw error if email already exist' do
    @user_exists = User.create({
    name: "test", 
    email: "test@test.com",
    password: "testing",
    password_confirmation: "testing"
    })
    expect(@user_exists.errors.full_messages).to_not be_present
    end

    it "return false if name fields are not provided" do
    @user_fields_nil = User.create({
      name: "", 
      email: "test@test.com",
      password: "testing",
      password_confirmation: "testing"
      })
      expect(@user_fields_nil.errors.full_messages).to_not be_empty
    end
    it "return false if email fields are not provided" do
      @user_fields_nil = User.create({
        name: "biggy", 
        email: "",
        password: "testing",
        password_confirmation: "testing"
        })
        expect(@user_fields_nil.errors.full_messages).to_not be_empty
      end
      it "return false if password fields are not provided" do
        @user_fields_nil = User.create({
          name: "", 
          email: "test@test.com",
          password: "",
          password_confirmation: ""
          })
          expect(@user_fields_nil.errors.full_messages).to_not be_empty
        end

        it "returns false if password if less than 5 characters" do
          @user.password = "t"
          @user.password_confirmation = "tl"
          @user.valid?
          expect(@user.errors).to_not be_empty
        end

        it "returns false if password if greater than 5 characters" do
          @user.password = "notTiny:)"
          @user.password_confirmation = "notTiny:)"
          @user.save
          expect(@user.errors).to be_empty
        end

        describe "authenticate" do
          it 'authenticates with valid credentials' do
            @user = User.authenticate_with_credentials(@user.email, @user.password)
            expect(@user).to_not be(nil)
          end
          it "authenticares with invalid passwords" do
            @user = User.authenticate_with_credentials(@user.email, 'BADPASS')
            expect(@user).to be(nil)
          end
          it "authenticates with correct white-spaces email addresss" do
            @user = User.authenticate_with_credentials(' test@test.com    ', @user.password)
            expect(@user).to be(nil)
          end
          it "authenticates with valid email address that is not case sensitive" do
            @user = User.authenticate_with_credentials('TeSt@teSt.com', @user.password)
            expect(@user).to be(nil)
          end
     end
  end
end
