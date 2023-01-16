class ContactsController < ApplicationController

  def show
    @contacts = Contact.all
  end
end
