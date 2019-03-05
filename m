Return-Path: <SRS0=kldB=RI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69BCC43381
	for <rcu@archiver.kernel.org>; Tue,  5 Mar 2019 01:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2520675
	for <rcu@archiver.kernel.org>; Tue,  5 Mar 2019 01:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfCEBdV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:33:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbfCEBdV (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 Mar 2019 20:33:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x251TAC3143303
        for <rcu@vger.kernel.org>; Mon, 4 Mar 2019 20:33:19 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r1ekssrun-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2019 20:33:19 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 5 Mar 2019 01:33:18 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 01:33:15 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x251XE5811731150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 01:33:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35330B2064;
        Tue,  5 Mar 2019 01:33:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225C8B2067;
        Tue,  5 Mar 2019 01:33:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 01:33:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B8D0416C5C3F; Mon,  4 Mar 2019 17:33:18 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:33:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Move common code out of if-else block
Reply-To: paulmck@linux.ibm.com
References: <9ee20ff4-c91a-89ce-eab3-62064ec31855@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee20ff4-c91a-89ce-eab3-62064ec31855@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19030501-0064-0000-0000-000003B3DFF3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010706; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01169736; UDB=6.00611280; IPR=6.00950365;
 MB=3.00025832; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-05 01:33:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030501-0065-0000-0000-00003C9D49A6
Message-Id: <20190305013318.GS13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050008
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 02, 2019 at 05:57:17PM +0900, Akira Yokosawa wrote:
> >From 97f4bcece9a9beb792b623f847570144a0a71ccc Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Sat, 2 Mar 2019 17:25:19 +0900
> Subject: [PATCH] rcu: Move common code out of if-else block
> 
> As the result of recent addition of "rdp->core_needs_qs = false;" in
> the "if" block, now both branches of the if-else have the same
> assignment.
> 
> Factor it out and reduce line count.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Queued and pushed, thank you both!

It passes (very) light rcutorture testing.  I will hit it harder
this evening.

							Thanx, Paul

> ---
> Hi Paul,
> 
> This patch is supposed to do the change mentioned in off-the-list
> correspondence.  As the earlier change by Joel has not landed on
> tip tree, I avoided mentioning the commit id of the change
> (ac2baf64948d in -rcu as of today) in the change log.
> 
> Does this work for you? 
> 
>         Thanks, Akira
> --
>  kernel/rcu/tree.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7273ef0..449e8a4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1910,12 +1910,10 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
>  		return;
>  	}
>  	mask = rdp->grpmask;
> +	rdp->core_needs_qs = false;
>  	if ((rnp->qsmask & mask) == 0) {
> -		rdp->core_needs_qs = false;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	} else {
> -		rdp->core_needs_qs = false;
> -
>  		/*
>  		 * This GP can't end until cpu checks in, so all of our
>  		 * callbacks can be processed during the next GP.
> -- 
> 2.7.4
> 

