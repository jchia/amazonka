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

-- Module      : Network.AWS.CodeDeploy.ListApplicationRevisions
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Lists information about revisions for an application.
module Network.AWS.CodeDeploy.ListApplicationRevisions
    (
    -- * Request
      ListApplicationRevisions
    -- ** Request constructor
    , listApplicationRevisions
    -- ** Request lenses
    , larApplicationName
    , larDeployed
    , larNextToken
    , larS3Bucket
    , larS3KeyPrefix
    , larSortBy
    , larSortOrder

    -- * Response
    , ListApplicationRevisionsResponse
    -- ** Response constructor
    , listApplicationRevisionsResponse
    -- ** Response lenses
    , larrNextToken
    , larrRevisions
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.CodeDeploy.Types

data ListApplicationRevisions = ListApplicationRevisions
    { _larApplicationName :: Text
    , _larDeployed        :: Maybe Text
    , _larNextToken       :: Maybe Text
    , _larS3Bucket        :: Maybe Text
    , _larS3KeyPrefix     :: Maybe Text
    , _larSortBy          :: Maybe Text
    , _larSortOrder       :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'ListApplicationRevisions' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'larApplicationName' @::@ 'Text'
--
-- * 'larDeployed' @::@ 'Maybe' 'Text'
--
-- * 'larNextToken' @::@ 'Maybe' 'Text'
--
-- * 'larS3Bucket' @::@ 'Maybe' 'Text'
--
-- * 'larS3KeyPrefix' @::@ 'Maybe' 'Text'
--
-- * 'larSortBy' @::@ 'Maybe' 'Text'
--
-- * 'larSortOrder' @::@ 'Maybe' 'Text'
--
listApplicationRevisions :: Text -- ^ 'larApplicationName'
                         -> ListApplicationRevisions
listApplicationRevisions p1 = ListApplicationRevisions
    { _larApplicationName = p1
    , _larSortBy          = Nothing
    , _larSortOrder       = Nothing
    , _larS3Bucket        = Nothing
    , _larS3KeyPrefix     = Nothing
    , _larDeployed        = Nothing
    , _larNextToken       = Nothing
    }

-- | The name of an existing AWS CodeDeploy application within the AWS user
-- account.
larApplicationName :: Lens' ListApplicationRevisions Text
larApplicationName =
    lens _larApplicationName (\s a -> s { _larApplicationName = a })

-- | Whether to list revisions based on whether the revision is the target
-- revision of an deployment group: include: List revisions that are target
-- revisions of a deployment group. exclude: Do not list revisions that are
-- target revisions of a deployment group. ignore: List all revisions,
-- regardless of whether they are target revisions of a deployment group.
larDeployed :: Lens' ListApplicationRevisions (Maybe Text)
larDeployed = lens _larDeployed (\s a -> s { _larDeployed = a })

-- | An identifier that was returned from the previous list application
-- revisions call, which can be used to return the next set of applications
-- in the list.
larNextToken :: Lens' ListApplicationRevisions (Maybe Text)
larNextToken = lens _larNextToken (\s a -> s { _larNextToken = a })

-- | A specific Amazon S3 bucket name to limit the search for revisions. If
-- set to null, then all of the user's buckets will be searched.
larS3Bucket :: Lens' ListApplicationRevisions (Maybe Text)
larS3Bucket = lens _larS3Bucket (\s a -> s { _larS3Bucket = a })

-- | A specific key prefix for the set of Amazon S3 objects to limit the
-- search for revisions.
larS3KeyPrefix :: Lens' ListApplicationRevisions (Maybe Text)
larS3KeyPrefix = lens _larS3KeyPrefix (\s a -> s { _larS3KeyPrefix = a })

-- | The column name to sort the list results by: registerTime: Sort the list
-- results by when the revisions were registered with AWS CodeDeploy.
-- firstUsedTime: Sort the list results by when the revisions were first
-- used by in a deployment. lastUsedTime: Sort the list results by when the
-- revisions were last used in a deployment. If not specified or set to
-- null, the results will be returned in an arbitrary order.
larSortBy :: Lens' ListApplicationRevisions (Maybe Text)
larSortBy = lens _larSortBy (\s a -> s { _larSortBy = a })

-- | The order to sort the list results by: ascending: Sort the list results
-- in ascending order. descending: Sort the list results in descending
-- order. If not specified, the results will be sorted in ascending order.
-- If set to null, the results will be sorted in an arbitrary order.
larSortOrder :: Lens' ListApplicationRevisions (Maybe Text)
larSortOrder = lens _larSortOrder (\s a -> s { _larSortOrder = a })

instance ToPath ListApplicationRevisions where
    toPath = const "/"

instance ToQuery ListApplicationRevisions where
    toQuery = const mempty

instance ToHeaders ListApplicationRevisions

instance ToBody ListApplicationRevisions where
    toBody = toBody . encode . _larApplicationName

data ListApplicationRevisionsResponse = ListApplicationRevisionsResponse
    { _larrNextToken :: Maybe Text
    , _larrRevisions :: [RevisionLocation]
    } deriving (Eq, Show, Generic)

-- | 'ListApplicationRevisionsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'larrNextToken' @::@ 'Maybe' 'Text'
--
-- * 'larrRevisions' @::@ ['RevisionLocation']
--
listApplicationRevisionsResponse :: ListApplicationRevisionsResponse
listApplicationRevisionsResponse = ListApplicationRevisionsResponse
    { _larrRevisions = mempty
    , _larrNextToken = Nothing
    }

-- | If the amount of information that is returned is significantly large, an
-- identifier will also be returned, which can be used in a subsequent list
-- application revisions call to return the next set of application
-- revisions in the list.
larrNextToken :: Lens' ListApplicationRevisionsResponse (Maybe Text)
larrNextToken = lens _larrNextToken (\s a -> s { _larrNextToken = a })

-- | A list of revision locations that contain the matching revisions.
larrRevisions :: Lens' ListApplicationRevisionsResponse [RevisionLocation]
larrRevisions = lens _larrRevisions (\s a -> s { _larrRevisions = a })

-- FromJSON

instance AWSRequest ListApplicationRevisions where
    type Sv ListApplicationRevisions = CodeDeploy
    type Rs ListApplicationRevisions = ListApplicationRevisionsResponse

    request  = post'
    response = jsonResponse $ \h o -> ListApplicationRevisionsResponse
        <$> o .: "nextToken"
        <*> o .: "revisions"
