Return-Path: <SRS0=HKaF=VC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC26C0650E
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 01:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5FD2184C
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 01:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xENGmkau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGEBat (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:30:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40605 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGEBat (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Jul 2019 21:30:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so3551275pfp.7
        for <rcu@vger.kernel.org>; Thu, 04 Jul 2019 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dXUsEGBcEbzxdDrghPkx1UFR7Xzd3df6VwvTjqkCivM=;
        b=xENGmkau1WFhaOisUsHv5eyL79YUNStHtyPmeGbVAtLiNcTyC5leWsGm27ypTY+yil
         WOUT6PypGhAjqxAx/z3whzx6aVF/U0737SDvzGblNXEoY8ZAdlVcIl8IJS+aHmjhb4U+
         n701itp/+qJtAAF7ErIBSdJ4K0iysi2pyhjQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dXUsEGBcEbzxdDrghPkx1UFR7Xzd3df6VwvTjqkCivM=;
        b=b45SqoHwP/s4dQx3SepvA/y0ewXvIvMrt5YbBrj0EQUUYSZP8OJeJWsPP18sUox5E8
         5ITMV/e4/g/nLZhfFe7Dd80oDKiNgFAoMEz0a/iAyG0qQaODP6I3wEHdHeOaUe00xyoI
         aCjei1Hqf9HxtLNAc6cRN/AgR9mGS9CBYId8U4uuoRHQYm1zGAKQY38wowdwQQ3Kx3Im
         LNrXTciQBaPzfSWkbuB1kcC2kshHZzdCiSw9ntRQ/XF0G8WZzrmxXCsaadztcFgqqnpu
         YJPb/xbb77sgYHRv9Okli0+WLMTVk1H6hXedAphuw6znUNLv1i8I1rgJTR1ttWHArp12
         UZsw==
X-Gm-Message-State: APjAAAXcHpzq1xPZZBq98A9ZDoU9S3bB5qtrzIyiCi/j2XyNywIEALiB
        hcNsicc9Vhw6c+0c6UVoJDq0rqkgWGw=
X-Google-Smtp-Source: APXvYqwFDq1QGii5+AyLS4/POHHkb4AdhtDEPpJ4bdH8q+xWIQjyMM/q4qLgiBnkyRGbNpuAdWLCnw==
X-Received: by 2002:a65:62ca:: with SMTP id m10mr1410086pgv.57.1562290248494;
        Thu, 04 Jul 2019 18:30:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm6720289pff.122.2019.07.04.18.30.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 18:30:47 -0700 (PDT)
Date:   Thu, 4 Jul 2019 21:30:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190705013045.GA141984@google.com>
References: <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190705000830.GB12919@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705000830.GB12919@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 08:08:30PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> > > On Thu, Jul 04, 2019 at 10:13:15AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> > > > 
> > > > [ . . . ]
> > > > 
> > > > > > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > > > > > 
> > > > > > > Still can't explain that :)
> > > > > > > 
> > > > > > > 	do {
> > > > > > > 		...
> > > > > > > 		...
> > > > > > > +               rcu_perf_wait_shutdown();
> > > > > > >         } while (!torture_must_stop());
> > > > > > 
> > > > > > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > > > > > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > > > > > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > > > > > rcu_perf_wait_shutdown()?
> > > > > 
> > > > > I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> > > > > help. Only calling rcu_perf_wait_shutdown() cures it.
> > > > 
> > > > My eyes seem to be working better today.
> > > > 
> > > > Here is rcu_perf_wait_shutdown():
> > > > 
> > > > 	static void rcu_perf_wait_shutdown(void)
> > > > 	{
> > > > 		cond_resched_tasks_rcu_qs();
> > > > 		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
> > > > 			return;
> > > > 		while (!torture_must_stop())
> > > > 			schedule_timeout_uninterruptible(1);
> > > > 	}
> > > > 
> > > > Take a close look at the "while" loop.  It is effectively ending your
> > > > test prematurely and thus rendering the code no longer CPU-bound.  ;-)
> > > 
> > > That makes a lot of sense. I also found that I can drop
> > > 'rcu_perf_wait_shutdown' in my preempt-disable loop as long as I don't do an
> > > ftrace trace. I suspect the trace dump happening at the end is messing with
> > > the last iteration of the writer loops. My preempt disable loop probably
> > > disables preemption for a long time without rescheduling during this ftrace
> > > dump.
> > 
> > Agreed, although rcutorture does have special handling for ftrace dumps,
> > they still kick out the occasional RCU CPU stall warning and the like.
> > 
> > > Anyway, having the rcu_perf_wait_shutdown without doing the ftrace dump seems
> > > to solve it.
> > 
> > Did you mean "leaving out both the rcu_perf_wait_shutdown() and the
> > ftrace dump"?
> 
> Sorry, will be more clear next time. I meant, with rcu_perf_wait_shutdown()
> after every preempt disable/enable in my loop, there are no outliers whether
> ftrace dumping is enabled or not. This is pretty repeatable.
> 
> However, if I remove rcu_perf_wait_shutdown() it is still fine if don't do
> ftrace dumping.
> 
> The fatal outlier situation arises when rcu_perf_wait_shutdown() is not
> there in the loop, while ftrace dump is on.
> 
> However, if I also just do a set_preempt_need_resched() in my loop without a
> rcu_perf_wait_shutdown(), then that also cures the outlier issue (while
> ftrace dump is on).
> 
> > Another approach would be to set a global variable prior to the call
> > to ftrace_dump() -- and there might already be such a variable -- and
> > making a load of that variable be part of the termination condition for
> > your loop.  With appropriate ordering added, of course.
> 
> Yes, I tried this but it did not work. I tried something like:
> if (atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
> 	return;
> ...in my busy_wait() code (my busy_wait() function loops waiting for time to
> elapse). I was hoping that the busy_wait() loop would break out of the
> preempt disable section if it detected that all writers were done.
> 
> This is also precisely the condition checked before the rcu_ftrace_dump()
> function runs. So it is odd that didn't work. I'll keep digging.

I tried again, if I make sure the ftrace dump absolutely does not happen
until the preempt-disable loop is done marked by a new global variable as you
pointed, then it fixes it. And I don't need any set_preempt_need_resched() or
rcu_perf_shutdown_wait() in my preempt disable loop to fix it. Basically the
below diff. However, it still does answer the question about why a parallel
ftrace dump running in parallel with the still running preempt-disable loop
caused some writers to have multi-second grace periods. I think something
during the ftrace dump prevented the tick path of that loop CPU to set the
need-resched flag. It is quite hard to trace because the problem itself is
caused by tracing, so by the time the dump starts, the traces cannot be seen
after that which are what would give a clue here.

Anyway, I think we have beaten this one to death for now ;)

thanks a lot!

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 67208b844128..9acbe5f65730 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -443,7 +443,8 @@ rcu_perf_writer(void *arg)
 				 perf_type, PERF_FLAG, me, MIN_MEAS);
 			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
 			    nrealwriters) {
-				schedule_timeout_interruptible(10);
+				while(!pd_loop_done)
+					schedule_timeout_interruptible(10);
 				rcu_ftrace_dump(DUMP_ALL);
 				PERFOUT_STRING("Test complete");
 				t_rcu_perf_writer_finished = t;
----
(And this is my loop, by breaking out of the loop when needed and setting a
global variable, the outliers go away).

@@ -515,18 +516,10 @@ rcu_perf_preempt_disable(void *arg)
 	do {
 		preempt_disable();
 		busy_wait(pd_busy_wait);
 		preempt_enable();
 
+		if (atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
+			break;
 	} while (!torture_must_stop());
 
+	pd_loop_done = true;
+
 	torture_kthread_stopping("rcu_perf_preempt_disable");
 	return 0;
 }
