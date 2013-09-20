object @card
attributes :id, :name, :card_type, :last_four, :expires, :expired?
child(@card.payments => :payments) do
  extends "api/v1/payments/show"
end