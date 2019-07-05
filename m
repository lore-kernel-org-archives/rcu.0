Return-Path: <SRS0=HKaF=VC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A40C0650E
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 01:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0020449
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 01:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGEB6E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:58:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727267AbfGEB6D (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 4 Jul 2019 21:58:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x651upPD069762;
        Thu, 4 Jul 2019 21:57:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thq4urxre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 21:57:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x651mn2m009524;
        Fri, 5 Jul 2019 01:57:27 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2tdym7h02e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 01:57:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x651vQp254460720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jul 2019 01:57:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F19E4B2065;
        Fri,  5 Jul 2019 01:57:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE6E4B2066;
        Fri,  5 Jul 2019 01:57:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.225.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jul 2019 01:57:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 02F5D16C6AD7; Thu,  4 Jul 2019 18:57:26 -0700 (PDT)
Date:   Thu, 4 Jul 2019 18:57:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190705015726.GN26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190705000830.GB12919@google.com>
 <20190705013045.GA141984@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705013045.GA141984@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050025
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 09:30:45PM -0400, Joel Fernandes wrote:
> On Thu, Jul 04, 2019 at 08:08:30PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> > > > On Thu, Jul 04, 2019 at 10:13:15AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> > > > > > On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > > > > > > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> > > > > 
> > > > > [ . . . ]
> > > > > 
> > > > > > > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > > > > > > 
> > > > > > > > Still can't explain that :)
> > > > > > > > 
> > > > > > > > 	do {
> > > > > > > > 		...
> > > > > > > > 		...
> > > > > > > > +               rcu_perf_wait_shutdown();
> > > > > > > >         } while (!torture_must_stop());
> > > > > > > 
> > > > > > > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > > > > > > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > > > > > > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > > > > > > rcu_perf_wait_shutdown()?
> > > > > > 
> > > > > > I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> > > > > > help. Only calling rcu_perf_wait_shutdown() cures it.
> > > > > 
> > > > > My eyes seem to be working better today.
> > > > > 
> > > > > Here is rcu_perf_wait_shutdown():
> > > > > 
> > > > > 	static void rcu_perf_wait_shutdown(void)
> > > > > 	{
> > > > > 		cond_resched_tasks_rcu_qs();
> > > > > 		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
> > > > > 			return;
> > > > > 		while (!torture_must_stop())
> > > > > 			schedule_timeout_uninterruptible(1);
> > > > > 	}
> > > > > 
> > > > > Take a close look at the "while" loop.  It is effectively ending your
> > > > > test prematurely and thus rendering the code no longer CPU-bound.  ;-)
> > > > 
> > > > That makes a lot of sense. I also found that I can drop
> > > > 'rcu_perf_wait_shutdown' in my preempt-disable loop as long as I don't do an
> > > > ftrace trace. I suspect the trace dump happening at the end is messing with
> > > > the last iteration of the writer loops. My preempt disable loop probably
> > > > disables preemption for a long time without rescheduling during this ftrace
> > > > dump.
> > > 
> > > Agreed, although rcutorture does have special handling for ftrace dumps,
> > > they still kick out the occasional RCU CPU stall warning and the like.
> > > 
> > > > Anyway, having the rcu_perf_wait_shutdown without doing the ftrace dump seems
> > > > to solve it.
> > > 
> > > Did you mean "leaving out both the rcu_perf_wait_shutdown() and the
> > > ftrace dump"?
> > 
> > Sorry, will be more clear next time. I meant, with rcu_perf_wait_shutdown()
> > after every preempt disable/enable in my loop, there are no outliers whether
> > ftrace dumping is enabled or not. This is pretty repeatable.

Agreed, given that the first time you enter rcu_perf_wait_shutdown() after
initialization is complete, you don't ever come back out until the test is
over.  Putting rcu_perf_wait_shutdown() has the effect of disabling your
test completely.  ;-)

> > However, if I remove rcu_perf_wait_shutdown() it is still fine if don't do
> > ftrace dumping.

Got it, thank you!

> > The fatal outlier situation arises when rcu_perf_wait_shutdown() is not
> > there in the loop, while ftrace dump is on.
> > 
> > However, if I also just do a set_preempt_need_resched() in my loop without a
> > rcu_perf_wait_shutdown(), then that also cures the outlier issue (while
> > ftrace dump is on).

Ah, good to know!  I figured that something would help.  ;-)

> > > Another approach would be to set a global variable prior to the call
> > > to ftrace_dump() -- and there might already be such a variable -- and
> > > making a load of that variable be part of the termination condition for
> > > your loop.  With appropriate ordering added, of course.
> > 
> > Yes, I tried this but it did not work. I tried something like:
> > if (atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
> > 	return;
> > ...in my busy_wait() code (my busy_wait() function loops waiting for time to
> > elapse). I was hoping that the busy_wait() loop would break out of the
> > preempt disable section if it detected that all writers were done.
> > 
> > This is also precisely the condition checked before the rcu_ftrace_dump()
> > function runs. So it is odd that didn't work. I'll keep digging.

But your strategy is vulnerable to changes in shutdown order.
You instead need a variable that you set before the first call
to torture_stop_kthread().

> I tried again, if I make sure the ftrace dump absolutely does not happen
> until the preempt-disable loop is done marked by a new global variable as you
> pointed, then it fixes it. And I don't need any set_preempt_need_resched() or
> rcu_perf_shutdown_wait() in my preempt disable loop to fix it. Basically the
> below diff. However, it still does answer the question about why a parallel
> ftrace dump running in parallel with the still running preempt-disable loop
> caused some writers to have multi-second grace periods. I think something
> during the ftrace dump prevented the tick path of that loop CPU to set the
> need-resched flag. It is quite hard to trace because the problem itself is
> caused by tracing, so by the time the dump starts, the traces cannot be seen
> after that which are what would give a clue here.

Hmmm...  Doesn't ftrace_dump() iterate through the trace buffer with
interrupts disabled or some such?  If so, that would fully explain
its delaying RCU grace periods.

> Anyway, I think we have beaten this one to death for now ;)

No argument here.  ;-)

> thanks a lot!
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 67208b844128..9acbe5f65730 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -443,7 +443,8 @@ rcu_perf_writer(void *arg)
>  				 perf_type, PERF_FLAG, me, MIN_MEAS);
>  			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
>  			    nrealwriters) {
> -				schedule_timeout_interruptible(10);
> +				while(!pd_loop_done)
> +					schedule_timeout_interruptible(10);
>  				rcu_ftrace_dump(DUMP_ALL);
>  				PERFOUT_STRING("Test complete");
>  				t_rcu_perf_writer_finished = t;
> ----
> (And this is my loop, by breaking out of the loop when needed and setting a
> global variable, the outliers go away).
> 
> @@ -515,18 +516,10 @@ rcu_perf_preempt_disable(void *arg)
>  	do {
>  		preempt_disable();
>  		busy_wait(pd_busy_wait);
>  		preempt_enable();
>  
> +		if (atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
> +			break;
>  	} while (!torture_must_stop());
>  
> +	pd_loop_done = true;
> +
>  	torture_kthread_stopping("rcu_perf_preempt_disable");
>  	return 0;
>  }

Got it, thank you!

							Thanx, Paul
