require "application_system_test_case"

class WordsTest < ApplicationSystemTestCase
  setup do
    @word = words(:one)
  end

  test "visiting the index" do
    visit words_url
    assert_selector "h1", text: "Words"
  end

  test "creating a Word" do
    visit words_url
    click_on "New Word"

    fill_in "Also matches", with: @word.also_matches
    fill_in "Definition", with: @word.definition
    fill_in "Phonetic", with: @word.phonetic
    fill_in "Prefix", with: @word.prefix
    fill_in "Slug", with: @word.slug
    fill_in "Syllables", with: @word.syllables
    fill_in "Word", with: @word.word
    click_on "Create Word"

    assert_text "Word was successfully created"
    click_on "Back"
  end

  test "updating a Word" do
    visit words_url
    click_on "Edit", match: :first

    fill_in "Also matches", with: @word.also_matches
    fill_in "Definition", with: @word.definition
    fill_in "Phonetic", with: @word.phonetic
    fill_in "Prefix", with: @word.prefix
    fill_in "Slug", with: @word.slug
    fill_in "Syllables", with: @word.syllables
    fill_in "Word", with: @word.word
    click_on "Update Word"

    assert_text "Word was successfully updated"
    click_on "Back"
  end

  test "destroying a Word" do
    visit words_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Word was successfully destroyed"
  end
end
