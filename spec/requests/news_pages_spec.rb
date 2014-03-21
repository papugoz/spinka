require 'spec_helper'

describe "News pages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:comment_user) { FactoryGirl.create(:user) }
	let(:user_admin) { FactoryGirl.create(:admin) }

	describe "news creation" do

		describe "not logged in user want to create news" do
			before { visit new_news_path }
			it { should_not have_title("Nowy news") }
		end

		describe "not permited user want to create news" do
			before do
				sign_in user
				visit new_news_path
			end
			it { should_not have_title("Nowy news") }
		end
		describe "permited user want to create news" do
			before do
				sign_in user_admin
				visit new_news_path
			end
			it { should have_title("Nowy news") }

			describe "with wrong data" do
				before do
					fill_in "news_title", with: " "
					fill_in "news_content", with: "lipsum"
					click_button "Dodaj"
				end
				it { should have_title("Nowy news") }
				it { should have_selector('div.alert.alert-danger') }
			end

			describe "with good data" do
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

		describe "not logged in user want to see uncommented news" do
			before { visit news_path(news2) }
			it { should have_title(news2.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
			it { should_not have_selector('#comment') }
			it { should have_content('Artykuł nie został jeszcze skomentowany, bądź pierwszy') }
			it { should have_content('Aby skomentować artykuł musisz być zalogowany') }
		end

		describe "not logged in user want to see commented news" do
			before { visit news_path(news1) }
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
			it { should have_selector('div.panel-default.entry#comment-1') }
			it { should have_content('Aby skomentować artykuł musisz być zalogowany') }
		end

		describe "user want to see news" do
			before do
				sign_in user
				visit news_path(news1)
			end
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it { should_not have_link("edytuj") }
			it { should_not have_link("usuń") }
			it { should have_selector('div.panel-default.entry#comment-1') }
			it { should have_selector('section#news-comments-add') }

			describe "try to edit" do
				before { visit edit_news_path(news1) }
				it { should_not have_title "edycja" }
			end

			describe "try to add blank comment" do
				before { fill_in 'comment_content', with: "" }
				it "try to add" do
					expect { click_button "Dodaj komentarz" }.not_to change(Comment, :count)
				end
			end

			describe "try to add good comment" do
				before { fill_in 'comment_content', with: "comment content" }
				it "try to add" do
					expect { click_button "Dodaj komentarz" }.to change(Comment, :count).by(1)
				end
				describe "check if comment is added to news" do
					before { click_button "Dodaj komentarz" }
					it {should have_content("comment content") }
					it "powinien miec edytuj" do
						within '#comment-2' do
							should have_link("edytuj")
						end
					end
				end
			end

		end
		describe "admin user want to see news" do
			before do
				sign_in user_admin
				visit news_path(news1)
			end
			it { should have_title(news1.title) }
			it { should have_link("na górę") }
			it "should have edit news link" do
				within '#news-content' do
					should have_link("edytuj")
				end
			end
			it "should have delete news link" do
				within '#news-content' do
					should have_link("usuń")
				end
			end
			it "should have edit comment link" do
				within '#comment-1' do
					should have_link("edytuj")
				end
			end

			it "try to delete comment" do
				within '#comment-1' do
					expect { click_link "usuń" }.to change(Comment, :count).by(-1)
				end
			end

			describe "try to edit" do
				before { visit edit_news_path(news1) }
				it { should have_title "edycja" }

				describe "submit changes" do
					before do
						fill_in "news_content", with: "new content"
						click_button "Aktualizuj"
					end
					it { should have_selector('div.alert.alert-success') }
					it { should have_content("new content") }
				end
			end
			it "try to delete" do
				within '#news-content' do
					expect { click_link "usuń" }.to change(News, :count).by(-1)
				end
			end
		end
	end
end