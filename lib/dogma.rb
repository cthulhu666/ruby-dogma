require 'ffi'

require "dogma/version"
require 'dogma/functions'
require 'dogma/context'

module Dogma

  STATE_ONLINE = 17
  STATE_ACTIVE = 31
  STATE_OVERLOADED = 63

  class DogmaContext < FFI::Struct
    layout :fleet, :pointer,
           :gang, :pointer,
           :area, :pointer, # dogma_env_t*
           :character, :pointer, # dogma_env_t*
           :ship, :pointer, # dogma_env_t*
           :default_skill_level, :uint8, # uint8_t
           :skill_levels, :pointer, # dogma_array_t (Pvoid_t)
           :drone_map, :pointer # dogma_array_t (Pvoid_t)
  end

  def self.context
    p = FFI::MemoryPointer.new(:pointer)
    Functions.dogma_init_context p
    ctx = Context.new(DogmaContext.new(p.read_pointer))
  end

  def self.assert_ok(&block)
    fail "Dogma call returned non-zero" unless block.call == 0
  end

end
