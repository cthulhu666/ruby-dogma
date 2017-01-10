# frozen_string_literal: true
RSpec.shared_context 'dogma' do
  before(:all) { Dogma::Functions.dogma_init }
  let (:ctx) { Dogma.context }
  after { ctx.destroy! }
end
