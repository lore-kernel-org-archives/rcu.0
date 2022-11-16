Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01528C433FE
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 12:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKPMoF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 07:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKPMoE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 07:44:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1914003
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 04:44:03 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGCXBNg014849;
        Wed, 16 Nov 2022 12:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ldotzJxxeOswMOblS9taG5RKGjVLLo/0tUeLRnhVJlU=;
 b=Pf/3Mv9Al3GruupNgq9ssZifUioX4TqVIo1GQSARZDs1qpgHHAvQxyOeCJxIe/+3rbv2
 iR+6O3NAphY+DynWPVMHuPsdarZErdNQeX5k0V2mgHSCCRBkXLX9n78WFcW+Bp66pPmL
 UOq6Bhtl74boipI1ecfqNyRMRRjhI5+dbM5b43d51VrqxJjyM6E0OBOquguDpPMwxnv1
 qJaxgwOOINAN68VomWf6WwSbufJ+i6TaE7YYd+EAF4/gGA/1PMq9KV90hZUvyEln6ew0
 DcCqlg87r7gPEG3xUoKW+gtJUECL8fOsYeUnsodKk2SWw4MyF1tIDiCYGaspryNTQhfk Uw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvsq6ryvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 12:43:55 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AGChs38012814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 12:43:54 GMT
Received: from [10.216.28.150] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 16 Nov
 2022 04:43:51 -0800
Message-ID: <57caa2bc-5a28-5594-5127-54439258824d@quicinc.com>
Date:   Wed, 16 Nov 2022 18:13:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] srcu: Fix a misspelling in note
Content-Language: en-US
To:     Pingfan Liu <kernelfans@gmail.com>, <rcu@vger.kernel.org>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20221116015244.10539-1-kernelfans@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221116015244.10539-1-kernelfans@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EdmofWbFtGs4k6kTBiY2pvE4hiU_jhQc
X-Proofpoint-GUID: EdmofWbFtGs4k6kTBiY2pvE4hiU_jhQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=718 clxscore=1011 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160088
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 11/16/2022 7:22 AM, Pingfan Liu wrote:
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   include/linux/srcutree.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index e3014319d1ad..f52820e88018 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -48,7 +48,7 @@ struct srcu_data {
>   struct srcu_node {
>   	spinlock_t __private lock;
>   	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
> -						/*  if greater than ->srcu_gq_seq. */
> +						/*  if greater than ->srcu_gp_seq. */
>   	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
>   	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
>   	struct srcu_node *srcu_parent;		/* Next up in tree. */
