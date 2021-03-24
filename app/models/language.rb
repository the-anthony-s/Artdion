# == Schema Information
#
# Table name: languages
#
#  id             :bigint           not null, primary key
#  common         :boolean          default(FALSE)
#  iso_639_1      :string
#  iso_639_2b     :string
#  iso_639_2t     :string
#  iso_639_3      :string
#  language_scope :integer          default(1)
#  language_type  :integer          default(1)
#  name           :string
#  name_native    :string
#  pause          :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
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
