FactoryGirl.define do
	factory :user do
		sequence(:username)		{ |n| "Person #{n}" }
		sequence(:email)	{ |n| "person_#{n}@example.com" }
		password							"foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :news do
		sequence(:title) { |n| "News##{n}" }
		user
		teaser "Lorem"
		content "Lorem Ipsum"
	end

	factory :comment do
		content "Lorem Ipsum"
		user
		news
	end
end