class ChargesController < ApplicationController
  def create


    # Creates a stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Blocipedia Premium Membership Upgrade - #{current_user.email}",
    currency: 'usd'
    )

    current_user.update_attributes(role: "premium")

    flash[:success] = "Thanks for upgrading, #{current_user.name}!  Enjoy the benefits of your new membership and start a private wiki and add on some collaborators!"
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key:"#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership Upgrade - #{current_user.email}",
      amount: Amount.default
    }
  end

  private

  class Amount
    @default = 15_00

    def self.default
      @default
    end
  end
end
