# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Dogma' do
  include_context 'dogma'

  context 'Rifter' do
    before do
      ctx.set_ship 587 # Rifter
    end

    describe 'shield capacity' do
      let(:shield_capacity) { ctx.ship_attribute 263 }
      subject { shield_capacity }

      context 'without any modules' do
        it { is_expected.to eq 562.5 }
      end

      context 'with shield extender' do
        before { ctx.add_module 3831 } # Medium Shield Extender II

        it {   is_expected.to eq 1937.5 }
      end
    end

    describe 'falloff' do
      let(:falloffs) do
        idx.map { |i| ctx.module_attribute 158, i } # ATT_Falloff
      end
      subject { falloffs }

      context 'with autocannons' do
        let(:idx) do
          [
            # TYPE_150mmLightAutoCannonII + TYPE_ArchAngelPhasedPlasmaS
            ctx.add_module(2881, charge: 19_988, state: Dogma::STATE_ACTIVE),
            # TYPE_200mmLightAutoCannonII + TYPE_ArchAngelPhasedPlasmaS
            ctx.add_module(2889, charge: 19_988, state: Dogma::STATE_ACTIVE)
          ]
        end

        it { is_expected.to eq [8868.75, 9675.00] }
      end
    end
  end
end
