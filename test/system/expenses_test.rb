require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @expense = expenses(:one)
  end

  test "visiting the index" do
    visit expenses_url
    assert_selector "h1", text: "Expenses"
  end

  test "should create expense" do
    visit expenses_url
    click_on "New expense"

    fill_in "Amount", with: @expense.amount
    fill_in "Category", with: @expense.category
    fill_in "Date", with: @expense.date
    fill_in "Description", with: @expense.description
    fill_in "Month", with: @expense.month
    fill_in "User", with: @expense.user_id
    fill_in "Year", with: @expense.year
    click_on "Create Expense"

    assert_text "Expense was successfully created"
    click_on "Back"
  end

  test "should update Expense" do
    visit expense_url(@expense)
    click_on "Edit this expense", match: :first

    fill_in "Amount", with: @expense.amount
    fill_in "Category", with: @expense.category
    fill_in "Date", with: @expense.date
    fill_in "Description", with: @expense.description
    fill_in "Month", with: @expense.month
    fill_in "User", with: @expense.user_id
    fill_in "Year", with: @expense.year
    click_on "Update Expense"

    assert_text "Expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Expense" do
    visit expense_url(@expense)
    click_on "Destroy this expense", match: :first

    assert_text "Expense was successfully destroyed"
  end
end
