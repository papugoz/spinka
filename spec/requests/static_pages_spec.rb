require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "glowna strona" do
		let!(:news1) { FactoryGirl.create(:news) }

		before { visit root_path }

		it { should have_link("Poznaj nas", onas_path) }
		it { should have_link("Pomoc",			pomoc_path) }
		it { should have_link("Kontakt",		kontakt_path) }
		it { should have_link("SPiNKa",			root_path) }
		it { should have_selector('div.news') }
	end

	describe "tytuly" do
		describe "domyslny" do
			before { visit root_path }

			it { should have_title "SPiNKa" }
		end

		describe "o nas" do
			before { visit onas_path }

			it { should have_title "SPiNKa | O nas" }
		end

		describe "kontakt" do
			before { visit kontakt_path }

			it { should have_title "SPiNKa | Kontakt" }
		end

		describe "pomoc" do
			before { visit pomoc_path }

			it { should have_title "SPiNKa | Pomoc" }
		end

	end
end
