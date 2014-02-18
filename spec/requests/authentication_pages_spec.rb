require 'spec_helper'

describe "AuthenticationPages" do

	subject { page }

	describe "strona logowania" do
		before { visit new_session_path }

		it { should have_content("Zaloguj się") }

	end

end
