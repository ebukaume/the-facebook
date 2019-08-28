class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  before_save { self.id = SecureRandom.uuid.tr('-', '') }
end
