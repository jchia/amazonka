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

-- Module      : Network.AWS.Support.DescribeCommunications
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns communications (and attachments) for one or more support cases. You
-- can use the AfterTime and BeforeTime parameters to filter by date. You can
-- use the CaseId parameter to restrict the results to a particular case. Case
-- data is available for 12 months after creation. If a case was created more
-- than 12 months ago, a request for data might cause an error. You can use
-- the MaxResults and NextToken parameters to control the pagination of the
-- result set. Set MaxResults to the number of cases you want displayed on
-- each page, and use NextToken to specify the resumption of pagination.
module Network.AWS.Support.DescribeCommunications
    (
    -- * Request
      DescribeCommunications
    -- ** Request constructor
    , describeCommunications
    -- ** Request lenses
    , dc1AfterTime
    , dc1BeforeTime
    , dc1CaseId
    , dc1MaxResults
    , dc1NextToken

    -- * Response
    , DescribeCommunicationsResponse
    -- ** Response constructor
    , describeCommunicationsResponse
    -- ** Response lenses
    , dcrCommunications
    , dcrNextToken
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Support.Types

data DescribeCommunications = DescribeCommunications
    { _dc1AfterTime  :: Maybe Text
    , _dc1BeforeTime :: Maybe Text
    , _dc1CaseId     :: Text
    , _dc1MaxResults :: Maybe Natural
    , _dc1NextToken  :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribeCommunications' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dc1AfterTime' @::@ 'Maybe' 'Text'
--
-- * 'dc1BeforeTime' @::@ 'Maybe' 'Text'
--
-- * 'dc1CaseId' @::@ 'Text'
--
-- * 'dc1MaxResults' @::@ 'Maybe' 'Natural'
--
-- * 'dc1NextToken' @::@ 'Maybe' 'Text'
--
describeCommunications :: Text -- ^ 'dc1CaseId'
                       -> DescribeCommunications
describeCommunications p1 = DescribeCommunications
    { _dc1CaseId     = p1
    , _dc1BeforeTime = Nothing
    , _dc1AfterTime  = Nothing
    , _dc1NextToken  = Nothing
    , _dc1MaxResults = Nothing
    }

-- | The start date for a filtered date search on support case communications.
-- Case communications are available for 12 months after creation.
dc1AfterTime :: Lens' DescribeCommunications (Maybe Text)
dc1AfterTime = lens _dc1AfterTime (\s a -> s { _dc1AfterTime = a })

-- | The end date for a filtered date search on support case communications.
-- Case communications are available for 12 months after creation.
dc1BeforeTime :: Lens' DescribeCommunications (Maybe Text)
dc1BeforeTime = lens _dc1BeforeTime (\s a -> s { _dc1BeforeTime = a })

-- | The AWS Support case ID requested or returned in the call. The case ID is
-- an alphanumeric string formatted as shown in this example:
-- case-12345678910-2013-c4c1d2bf33c5cf47.
dc1CaseId :: Lens' DescribeCommunications Text
dc1CaseId = lens _dc1CaseId (\s a -> s { _dc1CaseId = a })

-- | The maximum number of results to return before paginating.
dc1MaxResults :: Lens' DescribeCommunications (Maybe Natural)
dc1MaxResults = lens _dc1MaxResults (\s a -> s { _dc1MaxResults = a })

-- | A resumption point for pagination.
dc1NextToken :: Lens' DescribeCommunications (Maybe Text)
dc1NextToken = lens _dc1NextToken (\s a -> s { _dc1NextToken = a })

instance ToPath DescribeCommunications where
    toPath = const "/"

instance ToQuery DescribeCommunications where
    toQuery = const mempty

instance ToHeaders DescribeCommunications

instance ToBody DescribeCommunications where
    toBody = toBody . encode . _dc1CaseId

data DescribeCommunicationsResponse = DescribeCommunicationsResponse
    { _dcrCommunications :: [Communication]
    , _dcrNextToken      :: Maybe Text
    } deriving (Eq, Show, Generic)

-- | 'DescribeCommunicationsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcrCommunications' @::@ ['Communication']
--
-- * 'dcrNextToken' @::@ 'Maybe' 'Text'
--
describeCommunicationsResponse :: DescribeCommunicationsResponse
describeCommunicationsResponse = DescribeCommunicationsResponse
    { _dcrCommunications = mempty
    , _dcrNextToken      = Nothing
    }

-- | The communications for the case.
dcrCommunications :: Lens' DescribeCommunicationsResponse [Communication]
dcrCommunications =
    lens _dcrCommunications (\s a -> s { _dcrCommunications = a })

-- | A resumption point for pagination.
dcrNextToken :: Lens' DescribeCommunicationsResponse (Maybe Text)
dcrNextToken = lens _dcrNextToken (\s a -> s { _dcrNextToken = a })

-- FromJSON

instance AWSRequest DescribeCommunications where
    type Sv DescribeCommunications = Support
    type Rs DescribeCommunications = DescribeCommunicationsResponse

    request  = post'
    response = jsonResponse $ \h o -> DescribeCommunicationsResponse
        <$> o .: "communications"
        <*> o .: "nextToken"
