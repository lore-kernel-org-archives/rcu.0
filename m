Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04429C77B61
	for <rcu@archiver.kernel.org>; Mon, 17 Apr 2023 05:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDQF2s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Apr 2023 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQF2r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Apr 2023 01:28:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B626B2
        for <rcu@vger.kernel.org>; Sun, 16 Apr 2023 22:28:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H2F8mg008075;
        Mon, 17 Apr 2023 05:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0oBbVn2Z7A387vS5pc2VEKnKN3ZgSZI7xMQVfeCoZJs=;
 b=RLfc5egCKSZqdAIrXrX9MdyZNd9AiwfjmURfSdrl6SAsIIONxSfjpGj9guzKlLJ62ctY
 ixcL4xsKnEfLXXiL41xar8c+fZTcxHP7m6W0CuktSfaHuyrKO1/P4vVyTKBd294gX3oq
 ef5E001zOLdsQKJoodQc7xD4XfCte1xLFjOdxSIl61ksUTqOIB4yFmKtNkQ3gxFln8m4
 n7eP4KD6OMcAPlQugJ3Z1BuTajaKQ5laiyj/i46zzkX6IvgGGm7dQKnqr1Y26+w65c65
 DSrJby4BIDG4GtNqjTLzmLB/kDg2ylX5/iAeZ8tF+RxnV9REh92BsSj8R6viARPkdvDA RQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4anex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:28:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H5ShYH009840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:28:43 GMT
Received: from [10.50.16.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 22:28:42 -0700
Message-ID: <fd1c65f0-e4a1-4377-2767-c541395b1a8b@quicinc.com>
Date:   Mon, 17 Apr 2023 10:58:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Question: Why the definition of ULONG_CMP_LE is different with
 time_before?
To:     Alan Huang <mmpgouride@gmail.com>, <rcu@vger.kernel.org>
References: <59BEC41C-E025-47EE-AA47-9B9795234415@gmail.com>
Content-Language: en-US
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <59BEC41C-E025-47EE-AA47-9B9795234415@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4IU_0COoj0Pr9zmuuYIL70fPj4PTNxMH
X-Proofpoint-ORIG-GUID: 4IU_0COoj0Pr9zmuuYIL70fPj4PTNxMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=339 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170049
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Alan,

The reason for a different implementation looks to be due to the fact 
that the C standard does not specify the result of an operation that
overflows a signed integer. This is described in lwn article: 
https://lwn.net/Articles/511259/ . On 32-bit systems, overflow would be 
common for counters used by RCU. So, RCU subsystem uses unsigned 
integers checks - ULONG_CMP_GE , ULONG_CMP_LT , to avoid any compiler 
optimization, which would cause results of these checks to have a 
different result, in the event of counter overflows.


Thanks
Neeraj


On 4/16/2023 2:19 PM, Alan Huang wrote:
> Hi,
> 
> I noticed that the definition of ULONG_CMP_LE in rcupdate.h is different with time_before.
> 
> I can’t figure it out that why their definition is different. Does the two definition are the same thing?
> 
> Thanks,
> Alan
> 
> 
> 
