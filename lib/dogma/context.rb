module Dogma
  class Context
    include Functions

    attr_reader :dogma_context

    def initialize(dogma_context)
      @dogma_context = dogma_context
    end

    def destroy!
      dogma_free_context @dogma_context
    end

    def set_ship(type_id)
      Dogma.assert_ok { dogma_set_ship(dogma_context, type_id) }
    end

    def add_module(type_id, state: STATE_ONLINE, charge: nil)
      idx = with_pointer(:ulong) do |p|
        if charge
          dogma_add_module_sc(dogma_context, type_id, p, state, charge)
        else
          dogma_add_module_s(dogma_context, type_id, p, state)
        end
      end
      idx.read_long
    end

    def ship_attribute(attr_id)
      read_double do |p|
        dogma_get_ship_attribute(dogma_context, attr_id, p)
      end
    end

    def character_attribute(attr_id)
      read_double do |p|
        dogma_get_character_attribute(dogma_context, attr_id, p)
      end
    end

    def module_attribute(attr_id, idx)
      read_double do |p|
        dogma_get_module_attribute(dogma_context, idx, attr_id, p)
      end
    end

    def charge_attribute(attr_id, idx)
      read_double do |p|
        dogma_get_charge_attribute(dogma_context, idx, attr_id, p)
      end
    end

    private

    def with_pointer(type, &block)
      p = FFI::MemoryPointer.new(type)
      Dogma.assert_ok { block.call(p) }
      p
    end

    def read_double(&block)
      with_pointer(:double, &block).read_double
    end

  end
end