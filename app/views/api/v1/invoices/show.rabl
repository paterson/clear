object @invoice
attributes :id, :amount, :currency, :description, :status, :created_at, :refunded?, :paid?, :due?, :due_since
child(@invoice.payment => :payment) do
  extends "api/v1/payments/show"
end