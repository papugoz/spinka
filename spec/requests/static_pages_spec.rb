require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "glowna strona" do
		before { visit root_path }

		it { should have_title "SPiNKa" }
	end
end
