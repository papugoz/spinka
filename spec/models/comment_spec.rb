require 'spec_helper'

describe Comment do

	let(:user) { FactoryGirl.create(:user) }
	let(:news) { FactoryGirl.create(:news, user_id: user.id) }

	before do	
		@comment = user.news.find_by(id: news.id).comments.new(user_id: user.id, content: "Lorem")
		@comment.save
	end

	subject { @comment }

	it { should respond_to(:news_id) }
	it { should respond_to(:news) }
	it { should respond_to(:user_id) }
	it { should respond_to(:content) }

	describe "prawidlowy uzytkownik" do
		it "wywolanie uzytkownika" do
			expect(@comment.news.user).to eq user
		end
		its(:user_id) { should eq user.id }
	end

	describe "prawidlowy news" do
		its(:news) { should eq news }
		its(:news_id) { should eq news.id }
	end

end