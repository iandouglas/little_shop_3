require 'rails_helper'
RSpec.describe 'As an admin user' do
  before :each do
    @merchant = create(:user, role: 1)
    @user = create(:user, role: 0)
    @admin = create(:user, role: 2)
    @item = create(:item, user: @merchant)
  end
  describe "When I visit a merchant's dashboard" do #/admin/merchants/6
    xit 'sees a link to downgrade the merchant account' do# to become a regular user
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit login_path

      fill_in 'Email', with: @admin.email
      fill_in 'Password', with: @admin.password
      click_on "Log in"

      visit admin_merchant_dashboard_path(@merchant)
      click_on "Downgrade" #The merchant themselves do NOT see this link

      expect(current_path).to eq(admin_user_path(@merchant)) #because the merchant is now a regular user
      expect(page).to have_content("This user has been downgraded.")

      visit merchant_dashboard_items_path(@merchant)
      expect(page).to_not have_content(@item.name)
    end

    it "sees a link to this merchant's items" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_merchant_dashboard_path(@merchant)

      expect(page).to have_link("#{@merchant.username}'s Items"
    end

    xit "can cli" do

    end
  end
  describe 'I visit a merchant dashboard, but that merchant is a regular user' do
    xit 'is redirectred to the user profile' do
      visit login_path

      fill_in 'Email', with: @admin.email
      fill_in 'Password', with: @admin.password
      click_on "Log in"

      visit admin_merchant_dashboard_path(@user)
      expect(current_path).to eq(admin_user_path(@user))
      # expect(page).to have_current_path(admin_user_path(@merchant))      # Then I am redirected to the appropriate user profile page.
    end
  end
end
