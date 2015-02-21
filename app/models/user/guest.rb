User::Guest = Naught.build do |config|
  config.mimic User
  config.predicates_return false

  def present?
    false
  end
end
