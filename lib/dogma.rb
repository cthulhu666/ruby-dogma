require "dogma/version"

require 'ffi'

module Dogma
  extend FFI::Library

  STATE_ONLINE = 17
  STATE_ACTIVE = 31
  STATE_OVERLOADED = 63

  ffi_lib ENV.fetch('LIBDOGMA', '/usr/local/lib/libdogma.so')

  attach_function :dogma_init, [], :int

  attach_function :dogma_init_context, [:pointer], :int

  attach_function :dogma_free_context, [:pointer], :int


end
