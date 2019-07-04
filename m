Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF8C0650E
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 22:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F9721852
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 22:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGDWSt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 18:18:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfGDWSt (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 4 Jul 2019 18:18:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64MH4jC107560;
        Thu, 4 Jul 2019 18:18:18 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thpvuvw2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 18:18:18 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x64M91IP000793;
        Thu, 4 Jul 2019 22:18:17 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2tdym7fu1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 22:18:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64MH1rv18547036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 22:17:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD9AB2065;
        Thu,  4 Jul 2019 22:17:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACFFCB205F;
        Thu,  4 Jul 2019 22:17:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.225.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 22:17:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AB82D16C5DE8; Thu,  4 Jul 2019 15:17:02 -0700 (PDT)
Date:   Thu, 4 Jul 2019 15:17:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190704221702.GL26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704185055.GA12919@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040290
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> On Thu, Jul 04, 2019 at 10:13:15AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> > > On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> > 
> > [ . . . ]
> > 
> > > > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > > > 
> > > > > Still can't explain that :)
> > > > > 
> > > > > 	do {
> > > > > 		...
> > > > > 		...
> > > > > +               rcu_perf_wait_shutdown();
> > > > >         } while (!torture_must_stop());
> > > > 
> > > > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > > > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > > > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > > > rcu_perf_wait_shutdown()?
> > > 
> > > I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> > > help. Only calling rcu_perf_wait_shutdown() cures it.
> > 
> > My eyes seem to be working better today.
> > 
> > Here is rcu_perf_wait_shutdown():
> > 
> > 	static void rcu_perf_wait_shutdown(void)
> > 	{
> > 		cond_resched_tasks_rcu_qs();
> > 		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
> > 			return;
> > 		while (!torture_must_stop())
> > 			schedule_timeout_uninterruptible(1);
> > 	}
> > 
> > Take a close look at the "while" loop.  It is effectively ending your
> > test prematurely and thus rendering the code no longer CPU-bound.  ;-)
> 
> That makes a lot of sense. I also found that I can drop
> 'rcu_perf_wait_shutdown' in my preempt-disable loop as long as I don't do an
> ftrace trace. I suspect the trace dump happening at the end is messing with
> the last iteration of the writer loops. My preempt disable loop probably
> disables preemption for a long time without rescheduling during this ftrace
> dump.

Agreed, although rcutorture does have special handling for ftrace dumps,
they still kick out the occasional RCU CPU stall warning and the like.

> Anyway, having the rcu_perf_wait_shutdown without doing the ftrace dump seems
> to solve it.

Did you mean "leaving out both the rcu_perf_wait_shutdown() and the
ftrace dump"?

Another approach would be to set a global variable prior to the call
to ftrace_dump() -- and there might already be such a variable -- and
making a load of that variable be part of the termination condition for
your loop.  With appropriate ordering added, of course.

> So actually the point of all my testing was (other than learning) was to
> compare how RCU pre-consolidated vs post-consolidated does. As predicted,
> with post-consolidated RCU, the preempt-disable / enable does manage to slow
> down the grace periods. This is not an issue per-se as you said that even
> 100s of ms of grace period delay is within acceptable RCU latencies. The
> results are as below:

And thank you for checking this out!

And the 1.2-second outliers were due to the ftrace dump?  If not, it would
be good to understand what was happening in that case.

> I am happy to try out any other test scenarios as well if you would like me
> to. I am open to any other suggestions you may have to improve the rcuperf
> tests in this (deferred/consolidated RCU) or other regards.
> 
> I did have a request, could you help me understand why is the grace period
> duration double that of my busy wait time? You mentioned this has something
> to do with the thread not waking up before another GP is started. But I did
> not follow this. Thanks a lot!!

Let's look at a normal grace period, and assume the ->gp_seq grace-period
sequence counter is initially 0x1, so that a grace period is already
in progress (keep in mind that the low-order two bits of ->gp_seq are
the phase within the grace period and the rest of the bits are the
grace-period number, so we are in phase 1 of the grace period following
grace period #0).  This grace period was started via synchronize_rcu()
by Task A.

Then we have the following sequence of events:

o	Task B does call_rcu(), but is too late to use the already-started
	grace period, so it needs another one.	The ->gp_seq_needed
	counter thus becomes 0x8.

o	The current grace period completes, so that the ->gp_seq
	counter becomes 0x4.  Callback invocation commences.

o	The grace-period kthread notices that ->gp_seq_needed is greater
	than ->gp_seq, so it starts a new grace period.  The ->gp_seq
	counter therefore becomes 0x5.

o	The callback for Task A's synchronize_rcu() is invoked, awakening
	Task A.  This happens almost immediately after the new grace
	period starts, but does definitely happen -after- that grace
	period starts.

o	Task A, being part of rcuperf, almost immediately does another
	synchronize_rcu().  So ->gp_seq_needed becomes 0xc.

If you play out the rest of this sequence, you should see how Task A
waits for almost two full grace periods.

> Performance changes in consolidated vs regular
> -------------------------------------------
> I ran a thread on a reserved CPU doing preempt disable + busy wait + preempt enable
> in a loop and measured the difference in rcuperf between conslidated and regular.
> nreaders = nwriters = 10.
> 
> 		(preempt disable duration)
> 		5ms	10ms	20ms	50ms
> v4.19
> median (usecs)	12000.3	12001	11000	12000
> 
> v5.1 (deferred)
> median (usecs)	13000	19999   40000   100000
> 
> All of this is still within spec of RCU.
> 
> Note as discussed:
> These results are independent of the value of jiffies_to_sched_qs. However,
> in my preempt-disable + enable loop, if I don't do a
> set_preempt_need_resched() in my loop, then I need to lower
> jiffies_to_sched_qs to bring down the grace period durations. This is
> understandable because the tick may not know sooner that it needs to resched
> the preempt disable busy loop.

Good stuff!  Again, thank you for doing this!!!

							Thanx, Paul
