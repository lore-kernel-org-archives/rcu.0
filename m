Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D9C0650E
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1092070D
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGFSVz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:21:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726889AbfGFSVz (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 6 Jul 2019 14:21:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x66IH3S0014226;
        Sat, 6 Jul 2019 14:21:19 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tjmjugptd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jul 2019 14:21:19 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x66IIlo0029507;
        Sat, 6 Jul 2019 18:21:18 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2tjk96khu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jul 2019 18:21:18 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x66ILHDk46399886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Jul 2019 18:21:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B7BB2064;
        Sat,  6 Jul 2019 18:21:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07396B2065;
        Sat,  6 Jul 2019 18:21:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.215.71])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  6 Jul 2019 18:21:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 946D916C1825; Sat,  6 Jul 2019 11:21:17 -0700 (PDT)
Date:   Sat, 6 Jul 2019 11:21:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190706182117.GY26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190706120230.GA200542@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706120230.GA200542@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907060243
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 06, 2019 at 08:02:30AM -0400, Joel Fernandes wrote:
> On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> [snip] 
> > > I did have a request, could you help me understand why is the grace period
> > > duration double that of my busy wait time? You mentioned this has something
> > > to do with the thread not waking up before another GP is started. But I did
> > > not follow this. Thanks a lot!!
> > 
> > Let's look at a normal grace period, and assume the ->gp_seq grace-period
> > sequence counter is initially 0x1, so that a grace period is already
> > in progress (keep in mind that the low-order two bits of ->gp_seq are
> > the phase within the grace period and the rest of the bits are the
> > grace-period number, so we are in phase 1 of the grace period following
> > grace period #0).  This grace period was started via synchronize_rcu()
> > by Task A.
> > 
> > Then we have the following sequence of events:
> > 
> > o	Task B does call_rcu(), but is too late to use the already-started
> > 	grace period, so it needs another one.	The ->gp_seq_needed
> > 	counter thus becomes 0x8.
> > 
> > o	The current grace period completes, so that the ->gp_seq
> > 	counter becomes 0x4.  Callback invocation commences.
> > 
> > o	The grace-period kthread notices that ->gp_seq_needed is greater
> > 	than ->gp_seq, so it starts a new grace period.  The ->gp_seq
> > 	counter therefore becomes 0x5.
> > 
> > o	The callback for Task A's synchronize_rcu() is invoked, awakening
> > 	Task A.  This happens almost immediately after the new grace
> > 	period starts, but does definitely happen -after- that grace
> > 	period starts.
> 
> Yes, but at this point, we are still at the 1GP mark. But the distribution's
> median below shows a strong correlation with 2 preempt-disable durations and
> grace-period completion. For example, if the duration of the preempt
> disable/enable loop is 50ms, it strongly shows the writer's median time
> difference before and after the synchronize_rcu as 100ms, not really showing
> it is 60 ms or 75 ms or anything.
> 
> > 
> > o	Task A, being part of rcuperf, almost immediately does another
> > 	synchronize_rcu().  So ->gp_seq_needed becomes 0xc.
> 
> Yes, but before that another synchronize_rcu, it also gets the timestamp and
> does a diff between old/new timestamp and has captured the data, so at that
> point the data captured should only be for around 1GPs worth give or take.

But in this case, the "give or take" is almost a full grace period, for
a total of almost two grace periods.

> > If you play out the rest of this sequence, you should see how Task A
> > waits for almost two full grace periods.
> 
> I tried to play this out, still didn't get it :-|. Not that it is an issue
> per-se, but still would like to understand it better.

Let's try it a different way.  Let's skip the state portion of ->gp_seq
and just focus on the number of elapsed grace periods.

o	Let's start with RCU idle, having completed grace-period number
	zero and not yet having started grace-period number 1.
	Let's also abbreviate: GP0 and GP1.

o	Task A wants a grace period.  Because RCU is idle, Task A's
	GP will complete at completion of GP1.

o	RCU starts GP1.

o	Almost immediately thereafter, Task B wants a grace period.
	But it cannot use GP1, because GP1 has already started, even
	if just barely, because some CPU or tasks might already have
	reported a quiescent state for GP1.

	So Task B's GP will not complete until the end of GP2.	And that
	is almost two GPs worth of time from now.

And on a system where RCU is busy, Task B's experience is the common
case if it is in a tight loop doing synchronize_rcu().  Because RCU is
busy, by the end of each grace period, there will always be a request
for another grace period.  And therefore RCU's grace-period kthread
will immediately start a new grace period upon completion of each
grace period.  So the sequence of events from Task B's viewpoint will
be as follows:

o	Task B executes synchronize_rcu(), which requests a new grace
	period.

o	This requested grace period ends, and another immediately starts.

o	Task B's RCU callback is invoked, which does a wakeup.

o	Task B executes another synchronize_rcu(), but just after a new
	grace period has started.  Task B thus has to wait almost two
	full grace periods.

This could be perceived as a problem, but my question back to you would
be "Why on earth are you invoking synchronize_rcu() in a tight loop???"
"Oh, because you are running rcuperf?  Well, that is why rcuperf uses
ftrace data!"

Which might be the point on which we are talking past each other.  You
might have been thinking of the latency of RCU's grace-period computation.
I was thinking of the length of time between the call to synchronize_rcu()
and the corresponding return.

Does that help, or am I missing your point?

							Thanx, Paul

> > > Performance changes in consolidated vs regular
> > > -------------------------------------------
> > > I ran a thread on a reserved CPU doing preempt disable + busy wait + preempt enable
> > > in a loop and measured the difference in rcuperf between conslidated and regular.
> > > nreaders = nwriters = 10.
> > > 
> > > 		(preempt disable duration)
> > > 		5ms	10ms	20ms	50ms
> > > v4.19
> > > median (usecs)	12000.3	12001	11000	12000
> > > 
> > > v5.1 (deferred)
> > > median (usecs)	13000	19999   40000   100000
> > > 
> > > All of this is still within spec of RCU.
> 
> thanks!
> 
>  - Joel
> 
