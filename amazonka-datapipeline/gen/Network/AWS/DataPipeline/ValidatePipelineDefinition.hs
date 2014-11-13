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

-- Module      : Network.AWS.DataPipeline.ValidatePipelineDefinition
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Tests the pipeline definition with a set of validation checks to ensure
-- that it is well formed and can run without error.
module Network.AWS.DataPipeline.ValidatePipelineDefinition
    (
    -- * Request
      ValidatePipelineDefinition
    -- ** Request constructor
    , validatePipelineDefinition
    -- ** Request lenses
    , vpdPipelineId
    , vpdPipelineObjects

    -- * Response
    , ValidatePipelineDefinitionResponse
    -- ** Response constructor
    , validatePipelineDefinitionResponse
    -- ** Response lenses
    , vpdrErrored
    , vpdrValidationErrors
    , vpdrValidationWarnings
    ) where

import Data.Aeson
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.DataPipeline.Types

data ValidatePipelineDefinition = ValidatePipelineDefinition
    { _vpdPipelineId      :: Text
    , _vpdPipelineObjects :: [PipelineObject]
    } deriving (Eq, Show, Generic)

-- | 'ValidatePipelineDefinition' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'vpdPipelineId' @::@ 'Text'
--
-- * 'vpdPipelineObjects' @::@ ['PipelineObject']
--
validatePipelineDefinition :: Text -- ^ 'vpdPipelineId'
                           -> ValidatePipelineDefinition
validatePipelineDefinition p1 = ValidatePipelineDefinition
    { _vpdPipelineId      = p1
    , _vpdPipelineObjects = mempty
    }

-- | Identifies the pipeline whose definition is to be validated.
vpdPipelineId :: Lens' ValidatePipelineDefinition Text
vpdPipelineId = lens _vpdPipelineId (\s a -> s { _vpdPipelineId = a })

-- | A list of objects that define the pipeline changes to validate against
-- the pipeline.
vpdPipelineObjects :: Lens' ValidatePipelineDefinition [PipelineObject]
vpdPipelineObjects =
    lens _vpdPipelineObjects (\s a -> s { _vpdPipelineObjects = a })

instance ToPath ValidatePipelineDefinition where
    toPath = const "/"

instance ToQuery ValidatePipelineDefinition where
    toQuery = const mempty

instance ToHeaders ValidatePipelineDefinition

instance ToBody ValidatePipelineDefinition where
    toBody = toBody . encode . _vpdPipelineId

data ValidatePipelineDefinitionResponse = ValidatePipelineDefinitionResponse
    { _vpdrErrored            :: Bool
    , _vpdrValidationErrors   :: [ValidationError]
    , _vpdrValidationWarnings :: [ValidationWarning]
    } deriving (Eq, Show, Generic)

-- | 'ValidatePipelineDefinitionResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'vpdrErrored' @::@ 'Bool'
--
-- * 'vpdrValidationErrors' @::@ ['ValidationError']
--
-- * 'vpdrValidationWarnings' @::@ ['ValidationWarning']
--
validatePipelineDefinitionResponse :: Bool -- ^ 'vpdrErrored'
                                   -> ValidatePipelineDefinitionResponse
validatePipelineDefinitionResponse p1 = ValidatePipelineDefinitionResponse
    { _vpdrErrored            = p1
    , _vpdrValidationErrors   = mempty
    , _vpdrValidationWarnings = mempty
    }

-- | If True, there were validation errors.
vpdrErrored :: Lens' ValidatePipelineDefinitionResponse Bool
vpdrErrored = lens _vpdrErrored (\s a -> s { _vpdrErrored = a })

-- | Lists the validation errors that were found by
-- ValidatePipelineDefinition.
vpdrValidationErrors :: Lens' ValidatePipelineDefinitionResponse [ValidationError]
vpdrValidationErrors =
    lens _vpdrValidationErrors (\s a -> s { _vpdrValidationErrors = a })

-- | Lists the validation warnings that were found by
-- ValidatePipelineDefinition.
vpdrValidationWarnings :: Lens' ValidatePipelineDefinitionResponse [ValidationWarning]
vpdrValidationWarnings =
    lens _vpdrValidationWarnings (\s a -> s { _vpdrValidationWarnings = a })

-- FromJSON

instance AWSRequest ValidatePipelineDefinition where
    type Sv ValidatePipelineDefinition = DataPipeline
    type Rs ValidatePipelineDefinition = ValidatePipelineDefinitionResponse

    request  = post'
    response = jsonResponse $ \h o -> ValidatePipelineDefinitionResponse
        <$> o .: "errored"
        <*> o .: "validationErrors"
        <*> o .: "validationWarnings"
