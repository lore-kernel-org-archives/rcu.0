Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92141C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4F20657
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKPso (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:48:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726820AbfCKPso (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 11 Mar 2019 11:48:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BFjtbQ118093
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 11:48:42 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r5q7bjxmj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 11:48:42 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Mar 2019 15:48:41 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 15:48:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BFmb7P19660812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 15:48:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A57B206E;
        Mon, 11 Mar 2019 15:48:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E50B2068;
        Mon, 11 Mar 2019 15:48:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 15:48:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7998F16C5F74; Mon, 11 Mar 2019 08:48:39 -0700 (PDT)
Date:   Mon, 11 Mar 2019 08:48:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcuupdate: Do a single rhp->func read in
 rcu_head_after_call_rcu
Reply-To: paulmck@linux.ibm.com
References: <1552305483-15846-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552305483-15846-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031115-0064-0000-0000-000003B8203C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010739; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01172871; UDB=6.00613177; IPR=6.00953525;
 MB=3.00025929; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-11 15:48:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031115-0065-0000-0000-00003CAF981A
Message-Id: <20190311154839.GH13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110113
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 11, 2019 at 05:28:03PM +0530, Neeraj Upadhyay wrote:
> Read rhp->func pointer in rcu_head_after_call_rcu() only once,
> to avoid warning in the case, where call_rcu() happens between
> two reads of rhp->func.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

This would more gracefully handle racing rcu_head_after_call_rcu()
with call_rcu().

But this thing is not yet used, so let's see what Neil Brown says.
If he isn't going to use it, my thought is to instead just remove
this.

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 6cdb1db..174768e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -878,9 +878,10 @@ static inline void rcu_head_init(struct rcu_head *rhp)
>  static inline bool
>  rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  {
> -	if (READ_ONCE(rhp->func) == f)
> +	rcu_callback_t func = READ_ONCE(rhp->func);
> +	if (func == f)
>  		return true;
> -	WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
> +	WARN_ON_ONCE(func != (rcu_callback_t)~0L);
>  	return false;
>  }
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

