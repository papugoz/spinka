require 'spec_helper'

describe "ForumPages" do

	let(:user) { FactoryGirl.create(:user) }
	let(:category1) { FactoryGirl.create(:category) }
	11.times do |n|
		let!(:"topic#{n}") { FactoryGirl.create(:topic, title: "topic##{n}", category_id: category1.id)}
	end
	let!(:post1) { FactoryGirl.create(:post, user_id: user.id, topic_id: topic1.id) }

	before do 

		sign_in(user)
		visit forum_path

	end

	subject { page }

	it { should have_title("Forum") }
	it { should have_selector("div.panel-heading", text: category1.title) }
	it { should have_link('topic#1') }
	it { should have_content(I18n.l(topic1.created_at, format: :short)) }
	it { should have_selector("span.glyphicon.glyphicon-chevron-down") }
	it { should have_selector("div#collapse_form-#{category1.id}") }
	it { should have_css("form#new_forum_layout") }

	describe "collapse category" do
		before { find("#collapse-#{category1.id}").click }

	it { should have_selector(:link_or_button, "uncollapse-#{category1.id}") }

	end

	describe "opening topic" do
		before { click_link('topic#1') }

		it { should have_title topic1.title }
		it { should have_content topic1.content }
	end
end
