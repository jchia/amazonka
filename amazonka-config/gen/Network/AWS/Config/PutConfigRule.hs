{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.Config.PutConfigRule
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Adds or updates an AWS Config rule for evaluating whether your AWS
-- resources comply with your desired configurations.
--
-- You can use this action for customer managed Config rules and AWS
-- managed Config rules. A customer managed Config rule is a custom rule
-- that you develop and maintain. An AWS managed Config rule is a
-- customizable, predefined rule that is provided by AWS Config.
--
-- If you are adding a new customer managed Config rule, you must first
-- create the AWS Lambda function that the rule invokes to evaluate your
-- resources. When you use the 'PutConfigRule' action to add the rule to
-- AWS Config, you must specify the Amazon Resource Name (ARN) that AWS
-- Lambda assigns to the function. Specify the ARN for the
-- 'SourceIdentifier' key. This key is part of the 'Source' object, which
-- is part of the 'ConfigRule' object.
--
-- If you are adding a new AWS managed Config rule, specify the rule\'s
-- identifier for the 'SourceIdentifier' key. To reference AWS managed
-- Config rule identifiers, see
-- <http://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html Using AWS Managed Config Rules>.
--
-- For any new rule that you add, specify the 'ConfigRuleName' in the
-- 'ConfigRule' object. Do not specify the 'ConfigRuleArn' or the
-- 'ConfigRuleId'. These values are generated by AWS Config for new rules.
--
-- If you are updating a rule that you have added previously, specify the
-- rule\'s 'ConfigRuleName', 'ConfigRuleId', or 'ConfigRuleArn' in the
-- 'ConfigRule' data type that you use in this request.
--
-- The maximum number of rules that AWS Config supports is 25.
--
-- For more information about developing and using AWS Config rules, see
-- <http://docs.aws.amazon.com/config/latest/developerguide/evaluate-config.html Evaluating AWS Resource Configurations with AWS Config>
-- in the /AWS Config Developer Guide/.
--
module Network.AWS.Config.PutConfigRule
    (
    -- * Creating a Request
      putConfigRule
    , PutConfigRule
    -- * Request Lenses
    , pcrConfigRule

    -- * Destructuring the Response
    , putConfigRuleResponse
    , PutConfigRuleResponse
    ) where

import           Network.AWS.Config.Types
import           Network.AWS.Config.Types.Product
import           Network.AWS.Lens
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'putConfigRule' smart constructor.
newtype PutConfigRule = PutConfigRule'
    { _pcrConfigRule :: ConfigRule
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'PutConfigRule' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'pcrConfigRule'
putConfigRule
    :: ConfigRule -- ^ 'pcrConfigRule'
    -> PutConfigRule
putConfigRule pConfigRule_ =
    PutConfigRule'
    { _pcrConfigRule = pConfigRule_
    }

-- | Undocumented member.
pcrConfigRule :: Lens' PutConfigRule ConfigRule
pcrConfigRule = lens _pcrConfigRule (\ s a -> s{_pcrConfigRule = a});

instance AWSRequest PutConfigRule where
        type Rs PutConfigRule = PutConfigRuleResponse
        request = postJSON config
        response = receiveNull PutConfigRuleResponse'

instance ToHeaders PutConfigRule where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("StarlingDoveService.PutConfigRule" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON PutConfigRule where
        toJSON PutConfigRule'{..}
          = object
              (catMaybes [Just ("ConfigRule" .= _pcrConfigRule)])

instance ToPath PutConfigRule where
        toPath = const "/"

instance ToQuery PutConfigRule where
        toQuery = const mempty

-- | /See:/ 'putConfigRuleResponse' smart constructor.
data PutConfigRuleResponse =
    PutConfigRuleResponse'
    deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'PutConfigRuleResponse' with the minimum fields required to make a request.
--
putConfigRuleResponse
    :: PutConfigRuleResponse
putConfigRuleResponse = PutConfigRuleResponse'
