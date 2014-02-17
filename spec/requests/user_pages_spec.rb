describe "user pages" do

	subject { page }

	describe "registering user" do

		before { visit rejestracja_path }

		it { should have_content("Rejestracja") }
		it { should have_button("stwórz") }

		describe "submitting valid form" do

			before do
				fill_in "user_username", with: "foobar"
				fill_in "user_email", with: "foobar@example.com"
				fill_in "user_password", with: "foobar"
				fill_in "user_password_confirmation", with: "foobar"
				click_button "stwórz"
			end

			it { should have_text("Tutaj") }

		end
	end

end