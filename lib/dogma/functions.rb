# frozen_string_literal: true
module Dogma
  module Functions
    extend FFI::Library

    ffi_lib ENV.fetch('LIBDOGMA', '/usr/local/lib/libdogma.so')

    attach_function :dogma_init, [], :int

    attach_function :dogma_init_context, [:pointer], :int

    attach_function :dogma_free_context, [:pointer], :int

    attach_function :dogma_set_ship, [:pointer, :uint32], :int

    # Combines the effects of dogma_add_module() followed by
    # dogma_set_module_state(), for brevity in hand-written programs.
    # int dogma_add_module_s(dogma_context_t*, dogma_typeid_t, dogma_key_t*, dogma_state_t);
    attach_function :dogma_add_module_s, [:pointer, :uint32, :pointer, :uint8], :int

    # Combines the effects of dogma_add_module(), dogma_set_module_state()
    # then dogma_add_charge(), for brevity in hand-written programs.
    # int dogma_add_module_sc(dogma_context_t*, dogma_typeid_t, dogma_key_t*, dogma_state_t, dogma_typeid_t);
    attach_function :dogma_add_module_sc, [:pointer, :uint32, :pointer, :uint8, :uint32], :int

    # Get an attribute of the ship.
    # int dogma_get_ship_attribute(dogma_context_t*, dogma_attributeid_t, double*);
    attach_function :dogma_get_ship_attribute, [:pointer, :uint16, :pointer], :int

    # Get an attribute of the character.
    # int dogma_get_character_attribute(dogma_context_t*, dogma_attributeid_t, double*);
    attach_function :dogma_get_character_attribute, [:pointer, :uint16, :pointer], :int

    # Get an attribute of a module. Use the index generated by dogma_add_module().
    # int dogma_get_module_attribute(dogma_context_t*, dogma_key_t, dogma_attributeid_t, double*);
    attach_function :dogma_get_module_attribute, [:pointer, :ulong, :uint16, :pointer], :int

    # Get an attribute of a charge. Use the index generated by dogma_add_module().
    # int dogma_get_charge_attribute(dogma_context_t*, dogma_key_t, dogma_attributeid_t, double*);
    attach_function :dogma_get_charge_attribute, [:pointer, :ulong, :uint16, :pointer], :int

    # Add a given number of drones to a loadout context. The drones are
    # assumed to be "launched" (ie not in the drone bay doing nothing).
    # int dogma_add_drone(dogma_context_t*, dogma_typeid_t, unsigned int);
    attach_function :dogma_add_drone, [:pointer, :uint32, :uint], :int

    # Remove a module. Use the index generated by dogma_add_module()
    # int dogma_remove_module(dogma_context_t*, dogma_key_t);
    attach_function :dogma_remove_module, [:pointer, :ulong], :int

    # Remove a charge. Use the index generated by dogma_add_module(). No
    # effect if there is no charge in the module. */
    # int dogma_remove_charge(dogma_context_t*, dogma_key_t);
    attach_function :dogma_remove_charge, [:pointer, :ulong], :int
  end
end
