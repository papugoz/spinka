require 'spec_helper'

describe Topic do

	let(:category1)  { FactoryGirl.create(:category) }
	let(:user1) { FactoryGirl.create(:user) }
	let!(:topic1) { FactoryGirl.create(:topic, category_id: category1.id, user_id: user1.id) }


	subject { topic1 }

	it { should respond_to(:title) }
	it { should respond_to(:content) }
	it { should respond_to(:category_id) }
	it { should respond_to(:category) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	it { should respond_to(:posts) }
	it { should respond_to(:last_post) }
	it { should respond_to(:post_count) }

	its(:user) { should eq user1 }
	its(:category) { should eq category1 }
end
