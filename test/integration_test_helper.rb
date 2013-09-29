require 'test_helper'

def login
  visit root_path
  click_link "Log in"
  fill_in "Email", with: User.first.email
  click_button "Log in"
end

def submit_result(winner, loser)
  select winner, from: 'result[winner_id]'
  select loser, from: 'result[loser_id]'
  within '.result-form' do
    find('[type=submit]').click
  end
end

def assert_rankings(name1, operator, name2)
  assert_operator ranking_of(name2), operator, ranking_of(name1)
end

def ranking_of(name)
  ranking_names.find do |ranking, names|
    names.include?(name)
  end.first
end

def ranking_names
  all('.rankings-entry').inject({}) do |memo, entry|
    name = entry.find('.rankings-name').text
    ranking = entry.find('.rankings-position').text.to_i
    memo[ranking] ||= []
    memo[ranking] << name
    memo
  end
end
