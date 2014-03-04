require 'spec_helper'

describe "AuthenticationPages" do

	subject { page }

	describe "logowanie" do
		let(:user) { FactoryGirl.create(:user) }
		let!(:news1) { FactoryGirl.create(:news) }

		before do
			visit root_url
			click_link("Zaloguj")
		end
		it { should have_content("Zaloguj się") }
		it { should have_field("username") }
		it { should have_field("password") }

		describe "z blednymi danymi" do
			before do
				fill_in("username", with: user.username)
				fill_in("password", with: "wrong")
				click_button("zaloguj")
			end

			it { should have_selector('div.alert.alert-danger') }
			it { should have_field('username') }
		end

		describe "z poprawnymi danymi" do
			before do
				fill_in("username", with: user.username)
				fill_in("password", with: user.password)
				click_button("zaloguj")
			end

			it { should have_selector('div.alert.alert-success', text: "Zalogowano pomyslnie") }
			it { should have_link('Wyloguj') }
			it { should have_link('Profil') }
			it { should_not have_link('Zaloguj') }
			it { should_not have_link('Zarejestruj się') }
			it { should have_selector('div.panel.panel-default.news') }

			describe "proboje sie zarejestrowac" do
				before { visit rejestracja_path }

				it { should have_selector('div.alert.alert-info', text:'Jestes już zalogowany') }
			end

			describe "wyloguje sie" do
				before { click_link('Wyloguj') }

				it { should have_link('Zaloguj') }
				it { should have_link('Zarejestruj się') }
			end
		end
	end
end
