# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_twitter_handles = [
  'realDonaldTrump',
  'BarackObama',
  'kanyewest',
  'KimKardashian',
  'justinbieber',
  'selenagomez',
  'rihanna',
  'taylorswift13',
  'BillGates',
  'elonmusk'
]

api_v1_metadata = AnalysisMetadatum.create(api_version: 1)

seed_twitter_handles.each do |twitter_handle|
  account = TwitterAccount.create(handle: twitter_handle)

  twitter_controller = Api::V1::TwitterApiController.new
  input = twitter_controller.get_tweet_text(account.handle)

  watson_controller = Api::V1::WatsonApiController.new
  analysis = watson_controller.analyze(input)

  word_counts = account.build_word_count(analysis[:word_count])
  word_counts.save

  personalities = account.build_personality(analysis[:personality])
  personalities.save

  needs = account.build_need(analysis[:need])
  needs.save

  values = account.build_value(analysis[:value])
  values.save

  consumption_preferences = account.build_consumption_preference(analysis[:consumption_preference])
  consumption_preferences.save
end

api_v1_metadata.personalities_description = {
  "Altruism / Altruistic": "Find that helping others is genuinely rewarding, that doing things for others is a form of self-fulfillment rather than self-sacrifice.",
  "Cooperation / Accommodating / Compliance": "Dislike confrontation. They are perfectly willing to compromise or to deny their own needs to get along with others.",
  "Modesty / Modest": "Are unassuming, rather self-effacing, and humble. However, they do not necessarily lack self-confidence or self-esteem.",
  "Morality / Uncompromising / Sincerity": "See no need for pretense or manipulation when dealing with others and are therefore candid, frank, and genuine.",
  "Sympathy / Empathetic": "Are tender-hearted and compassionate.",
  "Trust / Trusting of others": "Assume that most people are fundamentally fair, honest, and have good intentions. They take people at face value and are willing to forgive and forget.",
  "Achievement striving / Driven": "Try hard to achieve excellence. Their drive to be recognized as successful keeps them on track as they work hard to accomplish their goals.",
  "Cautiousness / Deliberate / Deliberateness": "Are disposed to think through possibilities carefully before acting.",
  "Dutifulness / Dutiful / Sense of responsibility": "Have a strong sense of duty and obligation.",
  "Orderliness / Organized": "Are well-organized, tidy, and neat.",
  "Self-discipline / Persistent": "Have the self-discipline, or 'will-power,' to persist at difficult or unpleasant tasks until they are completed.",
  "Self-efficacy / Self-assured / Sense of competence": "Are confident in their ability to accomplish things.",
  "Activity level / Energetic": "Lead fast-paced and busy lives. They do things and move about quickly, energetically, and vigorously, and they are involved in many activities.",
  "Assertiveness / Assertive": "Like to take charge and direct the activities of others. They tend to be leaders in groups.",
  "Cheerfulness / Cheerful / Positive emotions": "Experience a range of positive feelings, including happiness, enthusiasm, optimism, and joy.",
  "Excitement-seeking": "Are easily bored without high levels of stimulation.",
  "Friendliness / Outgoing / Warmth": "Genuinely like other people and openly demonstrate positive feelings toward others.",
  "Gregariousness / Sociable": "Find the company of others pleasantly stimulating and rewarding. They enjoy the excitement of crowds.",
  "Anger / Fiery": "Have a tendency to feel angry.",
  "Anxiety / Prone to worry": "Often feel like something unpleasant, threatening, or dangerous is about to happen. The 'fight-or-flight' system of their brains is too easily and too often engaged.",
  "Depression / Melancholy / Moodiness": "Tend to react more readily to life's ups and downs.",
  "Immoderation / Self-indulgence": "Feel strong cravings and urges that they have difficulty resisting, even though they know that they are likely to regret them later. They tend to be oriented toward short-term pleasures and rewards rather than long-term consequences.",
  "Self-consciousness": "Are sensitive about what others think of them. Their concerns about rejection and ridicule cause them to feel shy and uncomfortable around others; they are easily embarrassed.",
  "Vulnerability / Susceptible to stress / Sensitivity to stress": "Have difficulty coping with stress. They experience panic, confusion, and helplessness when under pressure or when facing emergency situations.",
  "Adventurousness / Willingness to experiment": "Are eager to try new activities and experience different things. They find familiarity and routine boring.",
  "Artistic interests": "Love beauty, both in art and in nature. They become easily involved and absorbed in artistic and natural events. With intellect, this facet is one of the two most important, central aspects of this characteristic.",
  "Emotionality / Emotionally aware / Depth of emotions": "Have good access to and awareness of their own feelings.",
  "Imagination": "View the real world as often too plain and ordinary. They use fantasy not as an escape but as a way of creating for themselves a richer and more interesting inner-world.",
  "Intellect / Intellectual curiosity": "Are intellectually curious and tend to think in symbols and abstractions. With artistic interests, this facet is one of the two most important, central aspects of this characteristic.",
  "Liberalism / Authority challenging / Tolerance for diversity": "Have a readiness to challenge authority, convention, and traditional values."
}

api_v1_metadata.needs_description = {
  "Excitement":	"Want to get out there and live life, have upbeat emotions, and want to have fun.",
  "Harmony": "Appreciate other people, their viewpoints, and their feelings.",
  "Curiosity": "Have a desire to discover, find out, and grow.",
  "Ideal": "Desire perfection and a sense of community.",
  "Closeness": "Relish being connected to family and setting up a home.",
  "Self-expression": "Enjoy discovering and asserting their own identities.",
  "Liberty": "Have a desire for fashion and new things, as well as the need for escape.",
  "Love": "Enjoy social contact, whether one-to-one or one-to-many. Any brand that is involved in bringing people together taps this need.",
  "Practicality": "Have a desire to get the job done, a desire for skill and efficiency, which can include physical expression and experience.",
  "Stability": "Seek equivalence in the physical world. They favor the sensible, the tried and tested.",
  "Challenge": "Have an urge to achieve, to succeed, and to take on challenges.",
  "Structure": "Exhibit groundedness and a desire to hold things together. They need things to be well organized and under control."
}

api_v1_metadata.values_description = {
  "Self-transcendence / Helping others":	"Show concern for the welfare and interests of others.",
  "Conservation / Tradition":	"Emphasize self-restriction, order, and resistance to change.",
  "Hedonism / Taking pleasure in life":	"Seek pleasure and sensuous gratification for themselves.",
  "Self-enhancement / Achieving success":	"Seek personal success for themselves.",
  "Open to change / Excitement":	"Emphasize independent action, thought, and feeling, as well as a readiness for new experiences."
}

api_v1_metadata.consumption_preferences_description = {
  "100": "The author is very likely to prefer the item. For some preferences, the value indicates a high level of interest.",
  "50": "The author is neutral with respect to the item. For some preferences, the value can mean that the author has a medium level of interest.",
  "0": "The author is very unlikely to prefer the item. For some preferences, you can interpret the value as meaning that the author has a very low level of interest."
}

api_v1_metadata.save
