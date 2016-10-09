defmodule Atendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(atendee = %Atendee{}) do
    atendee.paid && atendee.over_18
  end

  def print_vip_badge(%Atendee{name : name}) when name != "" do
    IO.puts "very cheep badge for #{name}"
  end

  def print_vip_badge(%Atendee{})  do
    raise "missing name for badge"
  end
end
