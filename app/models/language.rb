class Language < ApplicationRecord
  scope :is_active, -> { where(pause: false) }

  # Type
  LIVING = 1
  EXTINCT = 2
  HISTORICAL = 3

  TYPES = {
    LIVING => 'living',
    EXTINCT => 'extinct',
    HISTORICAL => 'historical'
  }.freeze

  validates_inclusion_of :language_type, in: TYPES.keys, message: "{{value}} must be in #{TYPES.values.join ','}"

  def type_name
    TYPES[status]
  end

  # Scope
  INDIVIDUAL = 1

  SCOPES = {
    INDIVIDUAL => 'individual'
  }.freeze

  validates_inclusion_of :language_scope, in: SCOPES.keys, message: "{{value}} must be in #{SCOPES.values.join ','}"

  def scope_name
    SCOPES[status]
  end
end
