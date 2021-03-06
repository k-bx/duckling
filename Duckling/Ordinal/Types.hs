-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Duckling.Ordinal.Types where

import Control.DeepSeq
import Data.Aeson
import Data.Hashable
import Data.Text (Text)
import GHC.Generics
import Prelude

import Duckling.Resolve (Resolve(..))

newtype OrdinalData = OrdinalData { value :: Int }
  deriving (Eq, Generic, Hashable, Show, Ord, NFData)

instance Resolve OrdinalData where
  type ResolvedValue OrdinalData = OrdinalData
  resolve _ x = Just x

instance ToJSON OrdinalData where
  toJSON (OrdinalData value) = object
    [ "type" .= ("value" :: Text)
    , "value" .= value
    ]

isBetween :: Ord a => a -> a -> a -> Bool
isBetween x low high = low <= x && x <= high
