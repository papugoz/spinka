require 'spec_helper'

describe Post do

	let(:category1)  { FactoryGirl.create(:category) }
	let(:user1) { FactoryGirl.create(:user) }
	let!(:topic1) { FactoryGirl.create(:topic, category_id: category1.id, user_id: user1.id) }
	let(:post1) { FactoryGirl.create(:post, topic_id: topic1.id, user_id: user1.id) }

	subject { post1 }

	it { should respond_to(:content) }
	it { should respond_to(:topic_id) }
	it { should respond_to(:topic) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }

	its(:user)	{ should eq user1 }
	its(:topic) { should eq topic1 }

end