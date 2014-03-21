require 'spec_helper'

describe ForumLayout do
	let(:user) { FactoryGirl.create(:user) }
	let!(:category1) { FactoryGirl.create(:category) }
	let(:forum_layout) { ForumLayout.new() }

	subject { forum_layout }

	it { should respond_to(:user_id) }
	it { should respond_to(:category_id) }
	it { should respond_to(:collapsed) }

end
