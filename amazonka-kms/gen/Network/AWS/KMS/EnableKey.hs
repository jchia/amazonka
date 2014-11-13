{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}
-- {-# OPTIONS_GHC -fno-warn-unused-binds  #-} doesnt work if wall is used
{-# OPTIONS_GHC -w #-}

-- Module      : Network.AWS.KMS.EnableKey
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Marks a key as enabled, thereby permitting its use. You can have up to 25
-- enabled keys at one time.
module Network.AWS.KMS.EnableKey
    (
    -- * Request
      EnableKey
    -- ** Request constructor
    , enableKey
    -- ** Request lenses
    , ekKeyId

    -- * Response
    , EnableKeyResponse
    -- ** Response constructor
    , enableKeyResponse
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.KMS.Types

newtype EnableKey = EnableKey
    { _ekKeyId :: Text
    } deriving (Eq, Ord, Show, Generic, Monoid, IsString)

-- | 'EnableKey' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ekKeyId' @::@ 'Text'
--
enableKey :: Text -- ^ 'ekKeyId'
          -> EnableKey
enableKey p1 = EnableKey
    { _ekKeyId = p1
    }

-- | Unique identifier of the customer master key to be enabled. This can be
-- an ARN, an alias, or a globally unique identifier.
ekKeyId :: Lens' EnableKey Text
ekKeyId = lens _ekKeyId (\s a -> s { _ekKeyId = a })

instance ToPath EnableKey where
    toPath = const "/"

instance ToQuery EnableKey where
    toQuery = const mempty

instance ToHeaders EnableKey

instance ToBody EnableKey where
    toBody = toBody . encode . _ekKeyId

data EnableKeyResponse = EnableKeyResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'EnableKeyResponse' constructor.
enableKeyResponse :: EnableKeyResponse
enableKeyResponse = EnableKeyResponse

-- FromJSON

instance AWSRequest EnableKey where
    type Sv EnableKey = KMS
    type Rs EnableKey = EnableKeyResponse

    request  = post'
    response = nullaryResponse EnableKeyResponse
