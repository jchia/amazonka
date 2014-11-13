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

-- Module      : Network.AWS.OpsWorks.DescribeElasticLoadBalancers
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes a stack's Elastic Load Balancing instances. Required Permissions:
-- To use this action, an IAM user must have a Show, Deploy, or Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
module Network.AWS.OpsWorks.DescribeElasticLoadBalancers
    (
    -- * Request
      DescribeElasticLoadBalancers
    -- ** Request constructor
    , describeElasticLoadBalancers
    -- ** Request lenses
    , delbLayerIds
    , delbStackId

    -- * Response
    , DescribeElasticLoadBalancersResponse
    -- ** Response constructor
    , describeElasticLoadBalancersResponse
    -- ** Response lenses
    , delbrElasticLoadBalancers
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.OpsWorks.Types

data DescribeElasticLoadBalancers = DescribeElasticLoadBalancers
    { _delbLayerIds :: [Text]
    , _delbStackId  :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribeElasticLoadBalancers' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'delbLayerIds' @::@ ['Text']
--
-- * 'delbStackId' @::@ 'Maybe' 'Text'
--
describeElasticLoadBalancers :: DescribeElasticLoadBalancers
describeElasticLoadBalancers = DescribeElasticLoadBalancers
    { _delbStackId  = Nothing
    , _delbLayerIds = mempty
    }

-- | A list of layer IDs. The action describes the Elastic Load Balancing
-- instances for the specified layers.
delbLayerIds :: Lens' DescribeElasticLoadBalancers [Text]
delbLayerIds = lens _delbLayerIds (\s a -> s { _delbLayerIds = a })

-- | A stack ID. The action describes the stack's Elastic Load Balancing
-- instances.
delbStackId :: Lens' DescribeElasticLoadBalancers (Maybe Text)
delbStackId = lens _delbStackId (\s a -> s { _delbStackId = a })

instance ToPath DescribeElasticLoadBalancers where
    toPath = const "/"

instance ToQuery DescribeElasticLoadBalancers where
    toQuery = const mempty

instance ToHeaders DescribeElasticLoadBalancers

instance ToBody DescribeElasticLoadBalancers where
    toBody = toBody . encode . _delbStackId

newtype DescribeElasticLoadBalancersResponse = DescribeElasticLoadBalancersResponse
    { _delbrElasticLoadBalancers :: [ElasticLoadBalancer]
    } deriving (Eq, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeElasticLoadBalancersResponse where
    type Item DescribeElasticLoadBalancersResponse = ElasticLoadBalancer

    fromList = DescribeElasticLoadBalancersResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _delbrElasticLoadBalancers

-- | 'DescribeElasticLoadBalancersResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'delbrElasticLoadBalancers' @::@ ['ElasticLoadBalancer']
--
describeElasticLoadBalancersResponse :: DescribeElasticLoadBalancersResponse
describeElasticLoadBalancersResponse = DescribeElasticLoadBalancersResponse
    { _delbrElasticLoadBalancers = mempty
    }

-- | A list of ElasticLoadBalancer objects that describe the specified Elastic
-- Load Balancing instances.
delbrElasticLoadBalancers :: Lens' DescribeElasticLoadBalancersResponse [ElasticLoadBalancer]
delbrElasticLoadBalancers =
    lens _delbrElasticLoadBalancers
        (\s a -> s { _delbrElasticLoadBalancers = a })

-- FromJSON

instance AWSRequest DescribeElasticLoadBalancers where
    type Sv DescribeElasticLoadBalancers = OpsWorks
    type Rs DescribeElasticLoadBalancers = DescribeElasticLoadBalancersResponse

    request  = post'
    response = jsonResponse $ \h o -> DescribeElasticLoadBalancersResponse
        <$> o .: "ElasticLoadBalancers"
