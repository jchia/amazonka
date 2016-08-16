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
-- Module      : Network.AWS.ELBV2.DescribeLoadBalancers
-- Copyright   : (c) 2013-2016 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Describes the specified Application load balancers or all of your Application load balancers.
--
-- To describe the listeners for a load balancer, use < DescribeListeners>. To describe the attributes for a load balancer, use < DescribeLoadBalancerAttributes>.
module Network.AWS.ELBV2.DescribeLoadBalancers
    (
    -- * Creating a Request
      describeLoadBalancers
    , DescribeLoadBalancers
    -- * Request Lenses
    , dlbNames
    , dlbLoadBalancerARNs
    , dlbMarker
    , dlbPageSize

    -- * Destructuring the Response
    , describeLoadBalancersResponse
    , DescribeLoadBalancersResponse
    -- * Response Lenses
    , dlbrsLoadBalancers
    , dlbrsNextMarker
    , dlbrsResponseStatus
    ) where

import           Network.AWS.ELBV2.Types
import           Network.AWS.ELBV2.Types.Product
import           Network.AWS.Lens
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Contains the parameters for DescribeLoadBalancers.
--
-- /See:/ 'describeLoadBalancers' smart constructor.
data DescribeLoadBalancers = DescribeLoadBalancers'
    { _dlbNames            :: !(Maybe [Text])
    , _dlbLoadBalancerARNs :: !(Maybe [Text])
    , _dlbMarker           :: !(Maybe Text)
    , _dlbPageSize         :: !(Maybe Nat)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'DescribeLoadBalancers' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'dlbNames'
--
-- * 'dlbLoadBalancerARNs'
--
-- * 'dlbMarker'
--
-- * 'dlbPageSize'
describeLoadBalancers
    :: DescribeLoadBalancers
describeLoadBalancers =
    DescribeLoadBalancers'
    { _dlbNames = Nothing
    , _dlbLoadBalancerARNs = Nothing
    , _dlbMarker = Nothing
    , _dlbPageSize = Nothing
    }

-- | The names of the load balancers.
dlbNames :: Lens' DescribeLoadBalancers [Text]
dlbNames = lens _dlbNames (\ s a -> s{_dlbNames = a}) . _Default . _Coerce;

-- | The Amazon Resource Names (ARN) of the load balancers.
dlbLoadBalancerARNs :: Lens' DescribeLoadBalancers [Text]
dlbLoadBalancerARNs = lens _dlbLoadBalancerARNs (\ s a -> s{_dlbLoadBalancerARNs = a}) . _Default . _Coerce;

-- | The marker for the next set of results. (You received this marker from a previous call.)
dlbMarker :: Lens' DescribeLoadBalancers (Maybe Text)
dlbMarker = lens _dlbMarker (\ s a -> s{_dlbMarker = a});

-- | The maximum number of results to return with this call.
dlbPageSize :: Lens' DescribeLoadBalancers (Maybe Natural)
dlbPageSize = lens _dlbPageSize (\ s a -> s{_dlbPageSize = a}) . mapping _Nat;

instance AWSRequest DescribeLoadBalancers where
        type Rs DescribeLoadBalancers =
             DescribeLoadBalancersResponse
        request = postQuery elbv2
        response
          = receiveXMLWrapper "DescribeLoadBalancersResult"
              (\ s h x ->
                 DescribeLoadBalancersResponse' <$>
                   (x .@? "LoadBalancers" .!@ mempty >>=
                      may (parseXMLList "member"))
                     <*> (x .@? "NextMarker")
                     <*> (pure (fromEnum s)))

instance Hashable DescribeLoadBalancers

instance NFData DescribeLoadBalancers

instance ToHeaders DescribeLoadBalancers where
        toHeaders = const mempty

instance ToPath DescribeLoadBalancers where
        toPath = const "/"

instance ToQuery DescribeLoadBalancers where
        toQuery DescribeLoadBalancers'{..}
          = mconcat
              ["Action" =: ("DescribeLoadBalancers" :: ByteString),
               "Version" =: ("2015-12-01" :: ByteString),
               "Names" =:
                 toQuery (toQueryList "member" <$> _dlbNames),
               "LoadBalancerArns" =:
                 toQuery
                   (toQueryList "member" <$> _dlbLoadBalancerARNs),
               "Marker" =: _dlbMarker, "PageSize" =: _dlbPageSize]

-- | Contains the output of DescribeLoadBalancers.
--
-- /See:/ 'describeLoadBalancersResponse' smart constructor.
data DescribeLoadBalancersResponse = DescribeLoadBalancersResponse'
    { _dlbrsLoadBalancers  :: !(Maybe [LoadBalancer])
    , _dlbrsNextMarker     :: !(Maybe Text)
    , _dlbrsResponseStatus :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'DescribeLoadBalancersResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'dlbrsLoadBalancers'
--
-- * 'dlbrsNextMarker'
--
-- * 'dlbrsResponseStatus'
describeLoadBalancersResponse
    :: Int -- ^ 'dlbrsResponseStatus'
    -> DescribeLoadBalancersResponse
describeLoadBalancersResponse pResponseStatus_ =
    DescribeLoadBalancersResponse'
    { _dlbrsLoadBalancers = Nothing
    , _dlbrsNextMarker = Nothing
    , _dlbrsResponseStatus = pResponseStatus_
    }

-- | Information about the load balancers.
dlbrsLoadBalancers :: Lens' DescribeLoadBalancersResponse [LoadBalancer]
dlbrsLoadBalancers = lens _dlbrsLoadBalancers (\ s a -> s{_dlbrsLoadBalancers = a}) . _Default . _Coerce;

-- | The marker to use when requesting the next set of results. If there are no additional results, the string is empty.
dlbrsNextMarker :: Lens' DescribeLoadBalancersResponse (Maybe Text)
dlbrsNextMarker = lens _dlbrsNextMarker (\ s a -> s{_dlbrsNextMarker = a});

-- | The response status code.
dlbrsResponseStatus :: Lens' DescribeLoadBalancersResponse Int
dlbrsResponseStatus = lens _dlbrsResponseStatus (\ s a -> s{_dlbrsResponseStatus = a});

instance NFData DescribeLoadBalancersResponse
