Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A4C48BD5
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F23C208CB
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 16:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfFYQEB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:04:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731274AbfFYQEB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Jun 2019 12:04:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PG2VFa021443
        for <rcu@vger.kernel.org>; Tue, 25 Jun 2019 12:04:00 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbnrbk7w8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Tue, 25 Jun 2019 12:03:59 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 25 Jun 2019 17:03:58 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 17:03:55 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PG3srp45416790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 16:03:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D9AB2064;
        Tue, 25 Jun 2019 16:03:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD4BCB2066;
        Tue, 25 Jun 2019 16:03:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 16:03:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C901416C1854; Tue, 25 Jun 2019 09:03:54 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:03:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: Re: [Linux-kernel-mentees][PATCH v3 3/6] Documentation: RCU: Convert
 RCU UP systems to reST
Reply-To: paulmck@linux.ibm.com
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
 <20190625062627.26378-4-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625062627.26378-4-c0d1n61at3@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062516-0052-0000-0000-000003D60EA6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011328; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223124; UDB=6.00643648; IPR=6.01004296;
 MB=3.00027464; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-25 16:03:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062516-0053-0000-0000-00006174C8F8
Message-Id: <20190625160354.GB26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250121
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 25, 2019 at 01:26:24AM -0500, Jiunn Chang wrote:
> RCU UP systems reST markup.
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/RCU/UP.txt | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
> index 53bde717017b..67715a47ae89 100644
> --- a/Documentation/RCU/UP.txt
> +++ b/Documentation/RCU/UP.txt
> @@ -1,17 +1,19 @@
> -RCU on Uniprocessor Systems
> +.. _up_doc:
>  
> +RCU on Uniprocessor Systems
> +===========================
>  
>  A common misconception is that, on UP systems, the call_rcu() primitive
>  may immediately invoke its function.  The basis of this misconception
>  is that since there is only one CPU, it should not be necessary to
>  wait for anything else to get done, since there are no other CPUs for
> -anything else to be happening on.  Although this approach will -sort- -of-
> +anything else to be happening on.  Although this approach will *sort of*
>  work a surprising amount of the time, it is a very bad idea in general.
>  This document presents three examples that demonstrate exactly how bad
>  an idea this is.
>  
> -
>  Example 1: softirq Suicide
> +--------------------------
>  
>  Suppose that an RCU-based algorithm scans a linked list containing
>  elements A, B, and C in process context, and can delete elements from
> @@ -28,8 +30,8 @@ your kernel.
>  This same problem can occur if call_rcu() is invoked from a hardware
>  interrupt handler.
>  
> -
>  Example 2: Function-Call Fatality
> +---------------------------------
>  
>  Of course, one could avert the suicide described in the preceding example
>  by having call_rcu() directly invoke its arguments only if it was called
> @@ -46,11 +48,13 @@ its arguments would cause it to fail to make the fundamental guarantee
>  underlying RCU, namely that call_rcu() defers invoking its arguments until
>  all RCU read-side critical sections currently executing have completed.
>  
> -Quick Quiz #1: why is it -not- legal to invoke synchronize_rcu() in
> -	this case?
> +Quick Quiz #1:
> +	Why is it *not* legal to invoke synchronize_rcu() in this case?
>  
> +:ref:`Answers to Quick Quiz <answer_quick_quiz_up>`
>  
>  Example 3: Death by Deadlock
> +----------------------------
>  
>  Suppose that call_rcu() is invoked while holding a lock, and that the
>  callback function must acquire this same lock.  In this case, if
> @@ -76,25 +80,30 @@ there are cases where this can be quite ugly:
>  If call_rcu() directly invokes the callback, painful locking restrictions
>  or API changes would be required.
>  
> -Quick Quiz #2: What locking restriction must RCU callbacks respect?
> +Quick Quiz #2:
> +	What locking restriction must RCU callbacks respect?
>  
> +:ref:`Answers to Quick Quiz <answer_quick_quiz_up>`
>  
>  Summary
> +-------
>  
>  Permitting call_rcu() to immediately invoke its arguments breaks RCU,
>  even on a UP system.  So do not do it!  Even on a UP system, the RCU
> -infrastructure -must- respect grace periods, and -must- invoke callbacks
> +infrastructure *must* respect grace periods, and *must* invoke callbacks
>  from a known environment in which no locks are held.
>  
> -Note that it -is- safe for synchronize_rcu() to return immediately on
> -UP systems, including !PREEMPT SMP builds running on UP systems.
> +Note that it *is* safe for synchronize_rcu() to return immediately on
> +UP systems, including PREEMPT SMP builds running on UP systems.
>  
> -Quick Quiz #3: Why can't synchronize_rcu() return immediately on
> -	UP systems running preemptable RCU?
> +Quick Quiz #3:
> +	Why can't synchronize_rcu() return immediately on UP systems running
> +	preemptable RCU?
>  
> +.. _answer_quick_quiz_up:

As long as you are in the area, the answer is overly constraining.
The locking primitives could use either _irq suffixes (as stated) or
_bh suffixes.  This is obviously not your fault, but please feel free
to fix this with an additional patch.

							Thanx, Paul

>  Answer to Quick Quiz #1:
> -	Why is it -not- legal to invoke synchronize_rcu() in this case?
> +	Why is it *not* legal to invoke synchronize_rcu() in this case?
>  
>  	Because the calling function is scanning an RCU-protected linked
>  	list, and is therefore within an RCU read-side critical section.
> @@ -119,7 +128,7 @@ Answer to Quick Quiz #2:
>  
>  	This restriction might seem gratuitous, since very few RCU
>  	callbacks acquire locks directly.  However, a great many RCU
> -	callbacks do acquire locks -indirectly-, for example, via
> +	callbacks do acquire locks *indirectly*, for example, via
>  	the kfree() primitive.
>  
>  Answer to Quick Quiz #3:
> -- 
> 2.22.0
> 

