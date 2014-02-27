require 'spec_helper'

describe "News pages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:comment_user) { FactoryGirl.create(:user) }
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
					fill_in "news_teaser", with: "teaser"
					fill_in "news_content", with: "Ipsum"
					click_button "Dodaj"
				end
				it { should have_title("Lorem") }
				it { should have_content("Ipsum") }
			end
		end
	end

	describe "news" do
		let!(:news1) { FactoryGirl.create(:news) }
		let!(:news2) { FactoryGirl.create(:news) }
		let!(:comment1) { FactoryGirl.create(:comment, news_id: news1.id, user_id: comment_user.id)}

		describe "niezalogowany uzytkownik chce zobaczyc newsa bez komentarza" do
			before { visit news_path(news2) }
			it { should have_title(news2.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
			it { should_not have_selector('#comment') }
			it { should have_content('Artykuł nie został jeszcze skomentowany, bądź pierwszy') }
		end

		describe "niezalogowany uzytkownik chce zobaczyc newsa z komentarzem" do
			before { visit news_path(news1) }
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
			it { should have_selector('div.panel.panel-default.comment#comment-1') }
			it { should_not have_selector('section#news-comments-add') }
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
			it { should have_selector('div.panel.panel-default.comment#comment-1') }
			it { should have_selector('section#news-comments-add') }

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
			it "powinien miec usun" do
				within '#news-content' do
					should have_link("usuń")
				end
			end
			describe "chce go zedytowac" do
				before { visit edit_news_path(news1) }
				it { should have_title "edycja" }

				describe "chce zmienic" do
					before do
						fill_in "news_content", with: "new content"
						click_button "Aktualizuj"
					end
					it { should have_selector('div.alert.alert-success') }
					it { should have_content("new content") }
				end
			end
			it "chce usunac" do
				within '#news-content' do
					expect { click_link "usuń" }.to change(News, :count).by(-1)
				end
			end
		end
	end
end