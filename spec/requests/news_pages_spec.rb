require 'spec_helper'

describe "News pages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:user_admin) { FactoryGirl.create(:admin) }

	describe "tworzenie newsa" do

		describe "niezalogowany uzytkownik probuje utworzyc newsa" do
			before { visit new_news_path }
			it { should_not have_title("Nowy news") }
		end

		describe "nieupowazniony uzytkownik probuje utworzyc newsa" do
			before do
				sign_in user
				visit new_news_path
			end
			it { should_not have_title("Nowy news") }
		end
		describe "upwazniony uzytkownik probuje utworzyc newsa" do
			before do
				sign_in user_admin
				visit new_news_path
			end
			it { should have_title("Nowy news") }

			describe "probuje dodac niepoprawnego newsa" do
				before do
					fill_in "news_title", with: " "
					fill_in "news_content", with: "lipsum"
					click_button "Dodaj"
				end
				it { should have_title("Nowy news") }
				it { should have_selector('div.alert.alert-danger') }
			end

			describe "probuje dodac poprawnego newsa" do
				before do
					fill_in "news_title", with: "Lorem"
					fill_in "news_content", with: "Ipsum"
					click_button "Dodaj"
				end
				it { should have_title("Lorem") }
				it { should have_content("Ipsum") }
			end
		end
	end

	describe "Edycja newsa" do
		let!(:news1) { FactoryGirl.create(:news) }

		describe "niezalogowany uzytkownik chce zobaczyc newsa" do
			before { visit news_path(news1) }
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
		end

		describe "zwykly uzytkownik chce zobaczyc newsa" do
			before do
				sign_in user
				visit news_path(news1)
			end
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }

			describe "chce go zedytowac" do
				before { visit edit_news_path(news1) }
				it { should_not have_title "edycja" }
			end
		end
		describe "administrator chce zobaczyc newsa" do
			before do
				sign_in user_admin
				visit news_path(news1)
			end
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should have_link("edytuj") }
			it { should have_link("usuń") }

			describe "chce go zedytowac" do
				before { visit edit_news_path(news1) }
				it { should have_title "edycja" }

				describe "chce zmienic" do
					before do
						fill_in "news_content", with: "new content"
						click_button "Aktualizuj"
					end
					it { should have_selector('div.alert.alert-success') }
				end
			end
			describe "chce usunac newsa" do
				before do
					@tytul = news1.title
					click_link "usuń"
				end
				it { should_not have_title(@tytul) }
			end
		end
	end
end