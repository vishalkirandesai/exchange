# The mother of all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
