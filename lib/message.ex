defmodule FakeLogger.Message do
  @moduledoc """
  The module is in responsible for generating random messages based on predefined templates.
  """
  require Logger

  @logger_type ~w(info warn error)a
  @message_templates [
    "{emoji}  We should have called \"{super_hero}\" if we were in trouble.",
    "{emoji}  {super_hero} has the ability to throw {super_hero_power}.",
    "{emoji}  {pokemon} is the best Pokemon to have on your squad.",
    "{emoji}  The order will be delivered to {street}.",
    "{emoji}  {color} is my favorite color.",
    "{emoji}  You must try {food}.",
    "{emoji}  My favorite pizza flavor is {pizza}.",
    "{emoji}  Don't buy {car} unless you want to spend a lot of money on repairs.",
    "{emoji}  Have you had the opportunity to try {beer}?",
    "{emoji}  {start_wars_quote}",
    "{emoji}  I'm an awesome hacker. Your IP address may be {ipv6}, no?"
  ]
  @emojis [
    "💣",
    "🐖",
    "🐕‍🦺",
    "🫏",
    "🦭",
    "🐅",
    "🐘",
    "🤗",
    "❤️",
    "🔥",
    "😂",
    "🤩",
    "👀",
    "✨",
    "🫶",
    "💀",
    "🤔",
    "😭",
    "🥹",
    "🚀",
    "😉",
    "🎉"
  ]

  @doc """
  This function produces a message at random.

  ## Examples

      iex> is_bitstring(FakeLogger.Message.build())
      true

      iex> FakeLogger.Message.build("Nothing to change.")
      "Nothing to change."

      iex> template = "Some Pokemon: {pokemon}"
      iex> FakeLogger.Message.build(template) != template
      true

  """
  def build() do
    @message_templates
    |> Enum.random()
    |> build()
  end

  def build(template_message) when is_bitstring(template_message) do
    translate_message(template_message)
  end

  def print(message) do
    case Enum.random(@logger_type) do
      :info -> Logger.info(message)
      :warn -> Logger.warning(message)
      :error -> Logger.error(message)
    end
  end

  defp translate_message(message_template) do
    Regex.replace(~r/\{(\w+)\}/, message_template, fn _, message_type ->
      translate_message_type(message_type)
    end)
  end

  defp translate_message_type("super_hero"), do: Faker.Superhero.name()
  defp translate_message_type("super_hero_power"), do: Faker.Superhero.power()
  defp translate_message_type("pokemon"), do: Faker.Pokemon.name()
  defp translate_message_type("street"), do: Faker.Address.street_address()
  defp translate_message_type("food"), do: Faker.Food.En.dish()
  defp translate_message_type("pizza"), do: Faker.Pizza.topping()
  defp translate_message_type("car"), do: Faker.Vehicle.make_and_model()
  defp translate_message_type("beer"), do: Faker.Beer.name()
  defp translate_message_type("start_wars_quote"), do: Faker.StarWars.quote()
  defp translate_message_type("ipv6"), do: Faker.Internet.ip_v6_address()
  defp translate_message_type("color"), do: Faker.Color.name()
  defp translate_message_type("emoji"), do: Enum.random(@emojis)
  defp translate_message_type(_), do: Faker.Person.name()
end
