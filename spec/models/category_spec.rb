require 'spec_helper'

describe Category do

	let(:category1) { FactoryGirl.create(:category) }

	subject { category1 }

	it { should respond_to(:title) }
	it { should respond_to(:topics) }

end
