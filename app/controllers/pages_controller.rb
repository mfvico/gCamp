class PagesController <ApplicationController
  def index
    @quotes_authors = [
      [" - Arnold Schwarzenegger",["\"Failure is not an option. Everyone has to succeed\"", "\"I am the Governator\""]],
      [" - Steve Jobs",["\"Your time is limited, so don't waste it living someone else's life\""]],
      [" - Papa John",["\"Better Ingredients, Better Pizza\""]]
      ]
      render 'home'
  end
end
