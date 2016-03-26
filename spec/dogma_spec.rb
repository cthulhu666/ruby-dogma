# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Dogma' do
  include_context 'dogma'

  context 'Rifter' do
    before do
      ctx.set_ship 587 # Rifter
    end

    context 'without any modules' do
      it 'has proper shield capacity' do
        shield_capacity = ctx.ship_attribute 263
        expect(shield_capacity).to eq 562.5
      end
    end

    context 'with shield extender' do
      before { ctx.add_module 3831 } # Medium Shield Extender II

      it 'has proper shield capacity' do
        shield_capacity = ctx.ship_attribute 263
        expect(shield_capacity).to eq 1937.5
      end
    end

    context 'with autocannons' do
      let(:idx) do
        [
          # TYPE_150mmLightAutoCannonII + TYPE_ArchAngelPhasedPlasmaS
          ctx.add_module(2881, charge: 19_988, state: Dogma::STATE_ACTIVE),
          # TYPE_200mmLightAutoCannonII + TYPE_ArchAngelPhasedPlasmaS
          ctx.add_module(2889, charge: 19_988, state: Dogma::STATE_ACTIVE)
        ]
      end

      it 'has proper attributes' do
        falloffs = idx.map { |i| ctx.module_attribute 158, i } # ATT_Falloff
        expect(falloffs).to eq [8868.75, 9675.00]
      end
    end
  end
end
