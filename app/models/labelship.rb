class Labelship < ApplicationRecord
  belongs_to :label
  belongs_to :article
end
