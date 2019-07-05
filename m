Return-Path: <SRS0=HKaF=VC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A5C0650E
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 00:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EB621852
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 00:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dFkjQkTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfGEAIe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:08:34 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44042 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfGEAIe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Jul 2019 20:08:34 -0400
Received: by mail-pl1-f178.google.com with SMTP id t14so629811plr.11
        for <rcu@vger.kernel.org>; Thu, 04 Jul 2019 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KeWcUlmovzHEHNtWqoqOyFk2NSQA6s10T/4WitSbtM=;
        b=dFkjQkTF0EVJRS6D6gxhGVc5IpO6zRVrTiufoAdE/D/yPzRPfJYEUp+2aRisY/R9rq
         PH+5atYmlR7So5eRoptz4LYBNB1JcnbGcUqTgOCE+WV01rwAiilxuu/xC5rlm0LfitDJ
         IWtxsJzLDXqiWSoabjQ2n4pMR/6TiMpWo7zDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KeWcUlmovzHEHNtWqoqOyFk2NSQA6s10T/4WitSbtM=;
        b=NzeUr07NbZ/tMPbsJ/nCbSJZ7bykEkfyeGeS+YiWmLG09rkX/mIwORE+rSeKZ8A6FR
         ERLafFNf+pT9DZ/ds5Gg4Dqn8JO348aD4XpO+AUIgW1tTkIhgXWK0O85xqw3svthBT57
         v+c+6VuWteBlM0jnC70mbW0iV3w26EYnI/YFj0j1nIaQ8Q+9Ilegsc5dLoMxsBHeOCG3
         i97Lzy2teVFtRxeuq0/L6AS0HgCqcNEb7JZELPdJVHPU+mZgaPWFBUxetrp956sLFwvL
         TLEU8NAA18wZd9ij0RD2ZG7PuJ/FOSwW/Fpl0eLXIn82fTXF0yIkuyDdpw/Ytbgbda/1
         vq7A==
X-Gm-Message-State: APjAAAXwMBAPUIvsRMao8CHORJ2mMfg5xrqfdsx87vBXH547Fm2ZJLqY
        Xfoz9KmOtKE2a7sCxd5IC605DoGnzZk=
X-Google-Smtp-Source: APXvYqwail3U+KSI9+/fBneZd34MokRVxhus8hXiyWx94O4UV9cr5mP0PyEj7xBG1EdbCZRgyau5UQ==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr986375plz.38.1562285313018;
        Thu, 04 Jul 2019 17:08:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 3sm3973010pfg.186.2019.07.04.17.08.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 17:08:31 -0700 (PDT)
Date:   Thu, 4 Jul 2019 20:08:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190705000830.GB12919@google.com>
References: <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704221702.GL26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> > On Thu, Jul 04, 2019 at 10:13:15AM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> > > > On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > > > > 
> > > > > > Still can't explain that :)
> > > > > > 
> > > > > > 	do {
> > > > > > 		...
> > > > > > 		...
> > > > > > +               rcu_perf_wait_shutdown();
> > > > > >         } while (!torture_must_stop());
> > > > > 
> > > > > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > > > > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > > > > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > > > > rcu_perf_wait_shutdown()?
> > > > 
> > > > I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> > > > help. Only calling rcu_perf_wait_shutdown() cures it.
> > > 
> > > My eyes seem to be working better today.
> > > 
> > > Here is rcu_perf_wait_shutdown():
> > > 
> > > 	static void rcu_perf_wait_shutdown(void)
> > > 	{
> > > 		cond_resched_tasks_rcu_qs();
> > > 		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
> > > 			return;
> > > 		while (!torture_must_stop())
> > > 			schedule_timeout_uninterruptible(1);
> > > 	}
> > > 
> > > Take a close look at the "while" loop.  It is effectively ending your
> > > test prematurely and thus rendering the code no longer CPU-bound.  ;-)
> > 
> > That makes a lot of sense. I also found that I can drop
> > 'rcu_perf_wait_shutdown' in my preempt-disable loop as long as I don't do an
> > ftrace trace. I suspect the trace dump happening at the end is messing with
> > the last iteration of the writer loops. My preempt disable loop probably
> > disables preemption for a long time without rescheduling during this ftrace
> > dump.
> 
> Agreed, although rcutorture does have special handling for ftrace dumps,
> they still kick out the occasional RCU CPU stall warning and the like.
> 
> > Anyway, having the rcu_perf_wait_shutdown without doing the ftrace dump seems
> > to solve it.
> 
> Did you mean "leaving out both the rcu_perf_wait_shutdown() and the
> ftrace dump"?

Sorry, will be more clear next time. I meant, with rcu_perf_wait_shutdown()
after every preempt disable/enable in my loop, there are no outliers whether
ftrace dumping is enabled or not. This is pretty repeatable.

However, if I remove rcu_perf_wait_shutdown() it is still fine if don't do
ftrace dumping.

The fatal outlier situation arises when rcu_perf_wait_shutdown() is not
there in the loop, while ftrace dump is on.

However, if I also just do a set_preempt_need_resched() in my loop without a
rcu_perf_wait_shutdown(), then that also cures the outlier issue (while
ftrace dump is on).

> Another approach would be to set a global variable prior to the call
> to ftrace_dump() -- and there might already be such a variable -- and
> making a load of that variable be part of the termination condition for
> your loop.  With appropriate ordering added, of course.

Yes, I tried this but it did not work. I tried something like:
if (atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
	return;
...in my busy_wait() code (my busy_wait() function loops waiting for time to
elapse). I was hoping that the busy_wait() loop would break out of the
preempt disable section if it detected that all writers were done.

This is also precisely the condition checked before the rcu_ftrace_dump()
function runs. So it is odd that didn't work. I'll keep digging.

> > So actually the point of all my testing was (other than learning) was to
> > compare how RCU pre-consolidated vs post-consolidated does. As predicted,
> > with post-consolidated RCU, the preempt-disable / enable does manage to slow
> > down the grace periods. This is not an issue per-se as you said that even
> > 100s of ms of grace period delay is within acceptable RCU latencies. The
> > results are as below:
> 
> And thank you for checking this out!

My pleasure! Thanks for the discussions.

> And the 1.2-second outliers were due to the ftrace dump?  If not, it would
> be good to understand what was happening in that case.

Sounds great, I will work on it. And thanks a lot for the below explanation, I
will spend some time to understand it and I appreciate that.

thanks,
 - Joel



> > I am happy to try out any other test scenarios as well if you would like me
> > to. I am open to any other suggestions you may have to improve the rcuperf
> > tests in this (deferred/consolidated RCU) or other regards.
> > 
> > I did have a request, could you help me understand why is the grace period
> > duration double that of my busy wait time? You mentioned this has something
> > to do with the thread not waking up before another GP is started. But I did
> > not follow this. Thanks a lot!!
> 
> Let's look at a normal grace period, and assume the ->gp_seq grace-period
> sequence counter is initially 0x1, so that a grace period is already
> in progress (keep in mind that the low-order two bits of ->gp_seq are
> the phase within the grace period and the rest of the bits are the
> grace-period number, so we are in phase 1 of the grace period following
> grace period #0).  This grace period was started via synchronize_rcu()
> by Task A.
> 
> Then we have the following sequence of events:
> 
> o	Task B does call_rcu(), but is too late to use the already-started
> 	grace period, so it needs another one.	The ->gp_seq_needed
> 	counter thus becomes 0x8.
> 
> o	The current grace period completes, so that the ->gp_seq
> 	counter becomes 0x4.  Callback invocation commences.
> 
> o	The grace-period kthread notices that ->gp_seq_needed is greater
> 	than ->gp_seq, so it starts a new grace period.  The ->gp_seq
> 	counter therefore becomes 0x5.
> 
> o	The callback for Task A's synchronize_rcu() is invoked, awakening
> 	Task A.  This happens almost immediately after the new grace
> 	period starts, but does definitely happen -after- that grace
> 	period starts.
> 
> o	Task A, being part of rcuperf, almost immediately does another
> 	synchronize_rcu().  So ->gp_seq_needed becomes 0xc.
> 
> If you play out the rest of this sequence, you should see how Task A
> waits for almost two full grace periods.
> 
> > Performance changes in consolidated vs regular
> > -------------------------------------------
> > I ran a thread on a reserved CPU doing preempt disable + busy wait + preempt enable
> > in a loop and measured the difference in rcuperf between conslidated and regular.
> > nreaders = nwriters = 10.
> > 
> > 		(preempt disable duration)
> > 		5ms	10ms	20ms	50ms
> > v4.19
> > median (usecs)	12000.3	12001	11000	12000
> > 
> > v5.1 (deferred)
> > median (usecs)	13000	19999   40000   100000
> > 
> > All of this is still within spec of RCU.
> > 
> > Note as discussed:
> > These results are independent of the value of jiffies_to_sched_qs. However,
> > in my preempt-disable + enable loop, if I don't do a
> > set_preempt_need_resched() in my loop, then I need to lower
> > jiffies_to_sched_qs to bring down the grace period durations. This is
> > understandable because the tick may not know sooner that it needs to resched
> > the preempt disable busy loop.
> 
> Good stuff!  Again, thank you for doing this!!!
> 
> 							Thanx, Paul
