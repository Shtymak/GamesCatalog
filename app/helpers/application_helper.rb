module ApplicationHelper
  def get_locale
(I18n.locale || I18n.default_locale).to_s
  end
end
