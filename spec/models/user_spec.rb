require 'spec_helper'

describe User do

	before { @user = User.new(username: "Foobar", email: "foo@bar.com", password: "foobar", password_confirmation: "foobar") }

	subject { @user }

	it { should respond_to(:username) }
	it { should respond_to(:email) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	describe "niepoprawny uzytkownik" do

		describe "zly login" do

			before { @user.username = " " }

			it { should_not be_valid}

		end

		describe "zly email" do
			describe "pusty" do
				before { @user.email = "" }

				it { should_not be_valid }
			end

			it "z bledami" do
				addresses = %w[user@foo,com foo@bar..com user_at_foo_com example.user@foo. foo@bar_baz.com foo@baz+bar.com]
				addresses.each do |invalid_address|
					@user.email = invalid_address
					expect(@user).not_to be_valid
				end
			end
		end

	end

end
