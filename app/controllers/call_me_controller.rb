class CallMeController < ApplicationController
  def create
    call_me = CallMe.new(call_me_params)
    if call_me.save
      text = "Нова заявка на дзвінок \n #{call_me.phone}"
      Telegram::SendMessageJob.perform_later(text)
      redirect_back(fallback_location: root_path)
    else
      pp 'error'
    end
  end

  private

  def call_me_params
    params.require(:call_me).permit(:phone)
  end
end
