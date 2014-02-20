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
	it { should respond_to(:admin) }
	it { should respond_to(:news) }

	it { should be_valid }

	describe "niepoprawny uzytkownik" do
		describe "zly login" do
			describe "pusty login" do
				before { @user.username = " " }

				it { should_not be_valid}
			end
			describe "login zajety" do
				before { FactoryGirl.create(:user, username: "Foobar") }

				it { should_not be_valid }
			end
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

			describe "zajety" do
				before { FactoryGirl.create(:user, email: "foo@bar.com") }

				it { should_not be_valid }
			end
		end

		describe "zle haslo" do
			describe "puste" do
				before { @user = User.new(username: "Foobar", email: "foo@bar.com", password: " ", password_confirmation: " ") }

				it { should_not be_valid }
			end
			describe "niepotwierdzone" do

				before { @user.password_confirmation = "foobaz" }

				it { should_not be_valid }
			end
		end
	end

	describe "uzytkownik pisze posta" do
		before { @user.save }

		let!(:nowyNews1) { FactoryGirl.create(:news, user_id: @user.id) }
		let!(:nowyNews2) { FactoryGirl.create(:news, user_id: @user.id) }

		it "powinien miec newsy" do
			expect(@user.news.to_a).to eq [nowyNews1, nowyNews2]
		end
	end
end
