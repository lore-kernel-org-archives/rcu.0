Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F13C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 22:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2986B2087C
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 22:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfCKWrq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:47:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfCKWrq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 11 Mar 2019 18:47:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BMiRHp077760
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 18:47:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r5x8w63as-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 18:47:44 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Mar 2019 22:47:44 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 22:47:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BMleR14391050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 22:47:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 797A3B2064;
        Mon, 11 Mar 2019 22:47:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C56DB205F;
        Mon, 11 Mar 2019 22:47:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 22:47:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4210C16C0828; Mon, 11 Mar 2019 15:47:42 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:47:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Default jiffies_to_sched_qs to
 jiffies_till_sched_qs
Reply-To: paulmck@linux.ibm.com
References: <1552297571-5617-1-git-send-email-neeraju@codeaurora.org>
 <20190311151854.GG13351@linux.ibm.com>
 <20190311151947.GA8862@linux.ibm.com>
 <20190311173540.GA80041@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311173540.GA80041@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031122-0068-0000-0000-000003A3C1DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173010; UDB=6.00613261; IPR=6.00953664;
 MB=3.00025936; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-11 22:47:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031122-0069-0000-0000-000047C98F6D
Message-Id: <20190311224742.GS13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110154
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 11, 2019 at 01:35:40PM -0400, Joel Fernandes wrote:
> On Mon, Mar 11, 2019 at 08:19:47AM -0700, Paul E. McKenney wrote:
> > This time keeping the CC list...
> > 
> > 							Thanx, Paul
> > 
> > On Mon, Mar 11, 2019 at 08:18:54AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 11, 2019 at 03:16:11PM +0530, Neeraj Upadhyay wrote:
> > > > Current code does not call adjust_jiffies_till_sched_qs(),
> > > > if jiffies_till_sched_qs is specified. For the case, where
> > > > jiffies_till_first_fqs and jiffies_till_next_fqs are default,
> > > > jiffies_to_sched_qs won't be a correct adjustment of
> > > > jiffies_till_sched_qs.
> > > > 
> > > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > 
> > > Good catch!  Queued and pushed.  Please see below for updated
> > > commit log.  On future patches, could you please first describe
> > > the problem and consequences, then what the fix is?  This approach
> > > makes it much easier for people later on who will be trying to
> > > figure out what is going on, and who might or might not have much
> > > understanding of RCU.  (For example, they might be doing a bisection
> > > or some such.)
> > > 
> > > Not a big deal, as I can touch this up, but a good habit to get into.
> > > 
> > > And no, rcutorture currently does not specify non-default values
> > > for jiffies_till_sched_qs.  Which should probably be fixed.  I could
> > > make rcu_implicit_dynticks_qs() complain if jiffies_to_sched_qs is
> > > zero, but that feels a bit hacky and specific.  :-/
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit ee474b85fa0815be940ed89a91e0d84a110a0a92
> > > Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Date:   Mon Mar 11 15:16:11 2019 +0530
> > > 
> > >     rcu: Default jiffies_to_sched_qs to jiffies_till_sched_qs
> > >     
> > >     The current code only calls adjust_jiffies_till_sched_qs() if
> > >     jiffies_till_sched_qs is left at its default value, so when the
> > >     jiffies_till_sched_qs kernel-boot parameter actually is specified,
> > >     jiffies_to_sched_qs will be left with the value zero, which
> > >     will result in useless slowdowns of cond_resched().  This commit
> > >     therefore changes rcu_init_geometry() to unconditionally invoke
> > >     adjust_jiffies_till_sched_qs(), which ensures that jiffies_to_sched_qs
> > >     will be initialized in all cases, thus maintaining good cond_resched()
> > >     performance.
> > >     
> > >     Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ddd5c74e386b..10aeb89395ea 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3259,8 +3259,7 @@ static void __init rcu_init_geometry(void)
> > >  		jiffies_till_first_fqs = d;
> > >  	if (jiffies_till_next_fqs == ULONG_MAX)
> > >  		jiffies_till_next_fqs = d;
> > > -	if (jiffies_till_sched_qs == ULONG_MAX)
> > > -		adjust_jiffies_till_sched_qs();
> > > +	adjust_jiffies_till_sched_qs();
> > >  
> > >  	/* If the compile-time values are accurate, just leave. */
> > >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> > 
> 
> Makes sense to me.
> 
> Also the comment here needs an update too I think:
> 
> static ulong jiffies_to_sched_qs; /* Adjusted version of above if not default */
> 
> Seems to me, after your patch jiffies_to_sched_qs will always be an adjusted
> value of some sort, unless jiffies_till_sched_qs is specified.
> 
> Comment should be some thing like this then?
> 
> /* Either the above, or an adjusted default version based on
>  * jiffies_till_{first,next}_fqs if it is not specified */

Good point, but how about the patch below?

							Thanx, Paul

------------------------------------------------------------------------

commit b1d5aaf8eff7872a63531f35aa0490f2fc8118d6
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Mar 11 15:45:13 2019 -0700

    rcu: Update jiffies_to_sched_qs and adjust_jiffies_till_sched_qs() comments
    
    This commit better documents the jiffies_to_sched_qs default-value
    strategy used by adjust_jiffies_till_sched_qs()
    
    Reported-by: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 10aeb89395ea..355775a82581 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -400,7 +400,7 @@ static bool rcu_kick_kthreads;
  */
 static ulong jiffies_till_sched_qs = ULONG_MAX;
 module_param(jiffies_till_sched_qs, ulong, 0444);
-static ulong jiffies_to_sched_qs; /* Adjusted version of above if not default */
+static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
 module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
 
 /*
@@ -418,6 +418,7 @@ static void adjust_jiffies_till_sched_qs(void)
 		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
 		return;
 	}
+	/* Otherwise, set to third fqs scan, but bound below on large system. */
 	j = READ_ONCE(jiffies_till_first_fqs) +
 		      2 * READ_ONCE(jiffies_till_next_fqs);
 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)

