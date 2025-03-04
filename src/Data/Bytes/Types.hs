{-# language BangPatterns #-}
{-# language DataKinds #-}
{-# language MagicHash #-}
{-# language TypeFamilies #-}
{-# language DuplicateRecordFields #-}

module Data.Bytes.Types
  ( Bytes(..)
  , Bytes#(..)
  , MutableBytes(..)
  , UnmanagedBytes(..)
  , BytesN(..)
  , ByteArrayN(..)
  ) where

import Data.Bytes.Internal (Bytes(..))
import Data.Primitive (ByteArray(..),MutableByteArray(..))
import Data.Primitive.Addr (Addr)
import GHC.TypeNats (Nat)
import Reps (Bytes#(..))

-- | A slice of a 'ByteArray' whose compile-time-known length is represented
-- by a phantom type variable. Consumers of this data constructor must be
-- careful to preserve the expected invariant.
data BytesN (n :: Nat) = BytesN
  { array :: {-# UNPACK #-} !ByteArray
  , offset :: {-# UNPACK #-} !Int
  }

-- | A 'ByteArray' whose compile-time-known length is represented
-- by a phantom type variable. Consumers of this data constructor must be
-- careful to preserve the expected invariant.
newtype ByteArrayN (n :: Nat) = ByteArrayN
  { array :: ByteArray
  }

-- | A slice of a 'MutableByteArray'.
data MutableBytes s = MutableBytes
  { array :: {-# UNPACK #-} !(MutableByteArray s)
  , offset :: {-# UNPACK #-} !Int
  , length :: {-# UNPACK #-} !Int
  }

-- | A slice of unmanaged memory.
data UnmanagedBytes = UnmanagedBytes
  { address :: {-# UNPACK #-} !Addr
  , length :: {-# UNPACK #-} !Int
  }
