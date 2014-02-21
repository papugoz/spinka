require 'spec_helper'

describe News do

	let(:user) { FactoryGirl.create(:user) }

	before do
		@news = user.news.build(title: "News#1", content: "Lorem ipsum")
	end

	subject { @news }

	it { should respond_to(:title) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	it { should respond_to(:content) }

	describe "sprawdzanie czy autor jest dobry" do
		its(:user) { should eq user }
		its(:user_id) { should eq user.id }
	end

	describe "uzytkownik pisze posta" do

		let!(:nowyNews1) { FactoryGirl.create(:news, user_id: user.id) }
		let!(:nowyNews2) { FactoryGirl.create(:news, user_id: user.id) }

		it "powinien miec newsy w kolejnosci" do
			expect(user.news.to_a).to eq [nowyNews2, nowyNews1, @news]
		end
	end
end
