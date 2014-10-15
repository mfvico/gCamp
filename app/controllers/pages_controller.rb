class PagesController <ApplicationController
  def index

    quote1 = Quote.new
    quote1.text = "\"Failure is not an option. Everyone has to succeed\""
    quote1.author = " - Arnold Schwarzenegger"

    quote2 = Quote.new
    quote2.text = "\"Your time is limited, so don't waste it living someone else's life\""
    quote2.author = " - Steve Jobs"

    quote3 = Quote.new
    quote3.text = "\"Better Ingredients, Better Pizza\""
    quote3.author = " - Papa John"

    @quotes = [quote1, quote2, quote3]
    render 'home'# This must be at the bottom of the method
  end
  def faq
    question1 = Faq.new
    question1.question = "What is gCamp?"
    question1.answer = "gCamp is an awesome tool that will change your life. How, you ask? To be honest we're not quite sure of that yet, but once we do, you'll be the first to know :)"

    question2 = Faq.new
    question2.question = "How do I use gCamp?"
    question2.answer = "You don't...yet. But mark my words, you will be able to do almost anything (Within legal/ethical reason)"

    question3 = Faq.new
    question3.question = "When will gCamp be finished?"
    question3.answer = "When it's good and ready. don't rush us, we have a psychopath of a programmer on our staff, and he doesn't take kindly to being rushed. He WILL find where you live, and trust me, you don't want to be on his bad side."
    @questions = [question1, question2, question3]
  end

end
