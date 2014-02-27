describe "user pages" do

	subject { page }

	describe "rejestracja uzytkownika" do

		before { visit rejestracja_path }

		it { should have_content("Rejestracja") }
		it { should have_button("stwórz") }

		describe "wyslanie dobrego formulaza" do

			before do
				fill_in "user_username", with: "foobar"
				fill_in "user_email", with: "foobar@example.com"
				fill_in "user_password", with: "foobar"
				fill_in "user_password_confirmation", with: "foobar"
				click_button "stwórz"
			end

			it { should have_selector('div', text: "Pomyslnie zarejestrowany") }

		end

		describe "wyslanie zlego formulaza" do
			before do
				fill_in "user_username", with: ""
				fill_in "user_email", with: "foobar@example.com"
				fill_in "user_password", with: "foobar"
				fill_in "user_password_confirmation", with: "foobar"
				click_button "stwórz"
			end

			it { should have_selector('div.alert.alert-danger') }
		end
	end

	describe "strony profilowe" do
		let(:regular_user) { FactoryGirl.create(:user) }
		let(:admin_user) { FactoryGirl.create(:admin) }
		describe "niezalogowany uzytkownik" do
			describe "ogladanie czyjegos profilu" do
				before { visit user_path(regular_user) }
				it { should have_content(regular_user.username) }
				it { should_not have_link("Edycja") }
			end
		end
		describe "zalogowany zwykly uzytkownik" do
			before { sign_in regular_user }
			describe "ogladanie swojego profilu" do
				before do
					visit user_path(regular_user)
				end
				it { should have_link("Edycja") }
			end
		end
	end
end