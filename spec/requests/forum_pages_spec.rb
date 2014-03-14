require 'spec_helper'

describe "ForumPages" do

	let(:user) { FactoryGirl.create(:user) }
	let(:category1) { FactoryGirl.create(:category) }
	11.times do |n|
		let!(:"topic#{n}") { FactoryGirl.create(:topic, title: "topic##{n}", category_id: category1.id)}
	end
	let!(:post1) { FactoryGirl.create(:post, user_id: user.id, topic_id: topic1.id) }

	before { visit forum_path }

	subject { page }

	it { should have_title("Forum") }
	it { should have_selector("div.panel-heading", text: category1.title) }
	it { should have_link('topic#1') }
	it { should have_content(I18n.l(topic1.created_at, format: :short)) }

	describe "opening topic" do
		before { click_link('topic#1') }

		it { should have_title topic1.title }
		it { should have_content topic1.content }
	end
end
