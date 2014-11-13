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

-- Module      : Network.AWS.EMR.ListInstances
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Provides information about the cluster instances that Amazon EMR provisions
-- on behalf of a user when it creates the cluster. For example, this
-- operation indicates when the EC2 instances reach the Ready state, when
-- instances become available to Amazon EMR to use for jobs, and the IP
-- addresses for cluster instances, etc.
module Network.AWS.EMR.ListInstances
    (
    -- * Request
      ListInstances
    -- ** Request constructor
    , listInstances
    -- ** Request lenses
    , liClusterId
    , liInstanceGroupId
    , liInstanceGroupTypes
    , liMarker

    -- * Response
    , ListInstancesResponse
    -- ** Response constructor
    , listInstancesResponse
    -- ** Response lenses
    , lirInstances
    , lirMarker
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.EMR.Types

data ListInstances = ListInstances
    { _liClusterId          :: Text
    , _liInstanceGroupId    :: Maybe Text
    , _liInstanceGroupTypes :: [Text]
    , _liMarker             :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'ListInstances' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'liClusterId' @::@ 'Text'
--
-- * 'liInstanceGroupId' @::@ 'Maybe' 'Text'
--
-- * 'liInstanceGroupTypes' @::@ ['Text']
--
-- * 'liMarker' @::@ 'Maybe' 'Text'
--
listInstances :: Text -- ^ 'liClusterId'
              -> ListInstances
listInstances p1 = ListInstances
    { _liClusterId          = p1
    , _liInstanceGroupId    = Nothing
    , _liInstanceGroupTypes = mempty
    , _liMarker             = Nothing
    }

-- | The identifier of the cluster for which to list the instances.
liClusterId :: Lens' ListInstances Text
liClusterId = lens _liClusterId (\s a -> s { _liClusterId = a })

-- | The identifier of the instance group for which to list the instances.
liInstanceGroupId :: Lens' ListInstances (Maybe Text)
liInstanceGroupId =
    lens _liInstanceGroupId (\s a -> s { _liInstanceGroupId = a })

-- | The type of instance group for which to list the instances.
liInstanceGroupTypes :: Lens' ListInstances [Text]
liInstanceGroupTypes =
    lens _liInstanceGroupTypes (\s a -> s { _liInstanceGroupTypes = a })

-- | The pagination token that indicates the next set of results to retrieve.
liMarker :: Lens' ListInstances (Maybe Text)
liMarker = lens _liMarker (\s a -> s { _liMarker = a })

instance ToPath ListInstances where
    toPath = const "/"

instance ToQuery ListInstances where
    toQuery = const mempty

instance ToHeaders ListInstances

instance ToBody ListInstances where
    toBody = toBody . encode . _liClusterId

data ListInstancesResponse = ListInstancesResponse
    { _lirInstances :: [Instance]
    , _lirMarker    :: Maybe Text
    } deriving (Eq, Show, Generic)

-- | 'ListInstancesResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lirInstances' @::@ ['Instance']
--
-- * 'lirMarker' @::@ 'Maybe' 'Text'
--
listInstancesResponse :: ListInstancesResponse
listInstancesResponse = ListInstancesResponse
    { _lirInstances = mempty
    , _lirMarker    = Nothing
    }

-- | The list of instances for the cluster and given filters.
lirInstances :: Lens' ListInstancesResponse [Instance]
lirInstances = lens _lirInstances (\s a -> s { _lirInstances = a })

-- | The pagination token that indicates the next set of results to retrieve.
lirMarker :: Lens' ListInstancesResponse (Maybe Text)
lirMarker = lens _lirMarker (\s a -> s { _lirMarker = a })

-- FromJSON

instance AWSRequest ListInstances where
    type Sv ListInstances = EMR
    type Rs ListInstances = ListInstancesResponse

    request  = post'
    response = jsonResponse $ \h o -> ListInstancesResponse
        <$> o .: "Instances"
        <*> o .: "Marker"
