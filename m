Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8DAC35256
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC56254AF
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599242962;
	bh=i3C0cEhoqm4zXBsvgthKMXaFth2wdQw98051BVjTJSA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SZP5NEQetzwm1o3ufw9kPbdLz/9vO6A07uswCN65NHxUa5+fB4f7iSrsJsTvY6G/t
	 7e4qw3y7pGu5ozv/nMbD3umNp/0xZlXRPzjl+UTgf/mXTNOJoBOR0xtip1UjEpdo9y
	 Plf+doD121s6PxzWiSUxTKJZtePXn4R7RbH6l5sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDSJH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgIDSJD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Sep 2020 14:09:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7256B25499;
        Fri,  4 Sep 2020 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599242942;
        bh=i3C0cEhoqm4zXBsvgthKMXaFth2wdQw98051BVjTJSA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i1j5qxOXhRD/TLfnt3g/1zlwqwPMLF+vAkXnEWAFRezRCNj1E+G+1PfOkcisqNpzL
         aAasUdB0kD0LuyC/3oDMAm8kMidBZvv4gnMQcy6yDce6JiZPB/zCs8WoSWy2XxXHaA
         UvQ8dmy0tspVIFizJhmzhrmzzR22dccdl+vID2RE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 26166352162B; Fri,  4 Sep 2020 11:09:02 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:09:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 3/4] kernel/smp: Provide CSD lock timeout
 diagnostics
Message-ID: <20200904180902.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
 <20200831181417.1378-3-paulmck@kernel.org>
 <20200904031953.GB7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904031953.GB7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 04, 2020 at 11:19:53AM +0800, Boqun Feng wrote:
> On Mon, Aug 31, 2020 at 11:14:16AM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit causes csd_lock_wait() to emit diagnostics when a CPU
> > fails to respond quickly enough to one of the smp_call_function()
> > family of function calls.  These diagnostics are enabled by a new
> > CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.
> > 
> > This commit was inspired by an earlier patch by Josef Bacik.
> > 
> > [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> > [ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
> > [ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
> > [ paulmck: Apply Peter Zijlstra feedback. ]
> > Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> > Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/smp.c      | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig.debug |  11 +++++
> >  2 files changed, 143 insertions(+)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index a47382d..c5d3188 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -20,6 +20,9 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/idle.h>
> >  #include <linux/hypervisor.h>
> > +#include <linux/sched/clock.h>
> > +#include <linux/nmi.h>
> > +#include <linux/sched/debug.h>
> >  
> >  #include "smpboot.h"
> >  #include "sched/smp.h"
> > @@ -96,6 +99,103 @@ void __init call_function_init(void)
> >  	smpcfd_prepare_cpu(smp_processor_id());
> >  }
> >  
> > +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > +
> > +static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
> > +static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> > +static DEFINE_PER_CPU(void *, cur_csd_info);
> > +
> > +#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
> > +atomic_t csd_bug_count = ATOMIC_INIT(0);
> > +
> > +/* Record current CSD work for current CPU, NULL to erase. */
> > +static void csd_lock_record(call_single_data_t *csd)
> > +{
> > +	if (!csd) {
> > +		smp_mb(); /* NULL cur_csd after unlock. */
> > +		__this_cpu_write(cur_csd, NULL);
> > +		return;
> > +	}
> > +	__this_cpu_write(cur_csd_func, csd->func);
> > +	__this_cpu_write(cur_csd_info, csd->info);
> > +	smp_wmb(); /* func and info before csd. */
> > +	__this_cpu_write(cur_csd, csd);
> > +	smp_mb(); /* Update cur_csd before function call. */
> > +		  /* Or before unlock, as the case may be. */
> > +}
> > +
> > +static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
> > +{
> > +	unsigned int csd_type;
> > +
> > +	csd_type = CSD_TYPE(csd);
> > +	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
> > +		return csd->dst; /* Other CSD_TYPE_ values might not have ->dst. */
> > +	return -1;
> > +}
> > +
> > +/*
> > + * Complain if too much time spent waiting.  Note that only
> > + * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> > + * so waiting on other types gets much less information.
> > + */
> > +static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> > +{
> > +	int cpu = -1;
> > +	int cpux;
> > +	bool firsttime;
> > +	u64 ts2, ts_delta;
> > +	call_single_data_t *cpu_cur_csd;
> > +	unsigned int flags = READ_ONCE(csd->flags);
> > +
> > +	if (!(flags & CSD_FLAG_LOCK)) {
> > +		if (!unlikely(*bug_id))
> > +			return true;
> > +		cpu = csd_lock_wait_getcpu(csd);
> > +		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> > +			 *bug_id, raw_smp_processor_id(), cpu);
> > +		return true;
> > +	}
> > +
> > +	ts2 = sched_clock();
> > +	ts_delta = ts2 - *ts1;
> > +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> > +		return false;
> > +
> > +	firsttime = !*bug_id;
> > +	if (firsttime)
> > +		*bug_id = atomic_inc_return(&csd_bug_count);
> > +	cpu = csd_lock_wait_getcpu(csd);
> > +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> > +		cpux = 0;
> > +	else
> > +		cpux = cpu;
> > +	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> 
> Should we re-read csd->flags and check CSD_FLAG_LOCK again to improve
> the accuracy or to avoid unnecessary stack dumping? Because cpux may
> just finish the csd in question and clear the CSD_FLAG_LOCK bit, so it's
> late but no so late ;-) Maybe we can put the following check:
> 
> > +	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> > +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> > +		 cpu, csd->func, csd->info);
> 
> 	/*
> 	 * Re-read and check the flag.
> 	 *
> 	 * If destination cpu just handled the csd in question, we want
> 	 * to report the timeout but may not want to do stack dumping on
> 	 * either src or dst cpu, because in that case the stacks will
> 	 * be pretty much pointless. Since csd_lock_record(NULL) will
> 	 * issue a smp_mb() before setting cur_csd, we are guaranteed
> 	 * to observe the unlocked state of ->flags if the previous
> 	 * smp_load_acquire() observe the csd_lock_record(NULL) of
> 	 * handling the csd in question as follow:
> 	 * 
> 	 * CPU 0			CPU 1
> 	 *				<queue csd>
> 	 * <handle other csds>		csd_lock_wait_toolong()
> 	 * 				flags = READ_ONCE(csd->flags); // locked
> 	 * <handle the csd of CPU 1>
> 	 * csd_lock_record(csd);
> 	 * func(info);
> 	 * csd_unlock(csd); // unlocked
> 	 * csd_lock_record(NULL);
> 	 *				<ts_delat > CSD_LOCK_TIMEOUT> // going to report the timeout
> 	 *				cpu_cur_csd = smp_load_acquire(...);
> 	 * <handle other csds>
> 	 * csd_lock_record(other_csd);
> 	 *				flags = READ_ONCE(csd->flags); // observe the unlocked state
> 	 *				                               // no matter cpu_cur_csd is NULL or other_csd
> 	 * 
> 	 */
> 	flags = READ_ONCE(csd->flags);
> 	if (!(flags & CSD_FLAG_LOCK)) {
> 		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> 			 *bug_id, raw_smp_processor_id(), cpux);
> 		return true;
> 	}
> 
> Thoughts?

it might eventually be necessary to do this, but we do need to see
a real problem before layering on more code.  After all, the episode
could just as easily end right after the re-read.  And thus far, aside
from scftorture, the episodes in the wild were of the type that never
does end.  Plus the stack dump will take quite a bit more time than the
interval between the initial read and your proposed re-read.  So again,
we need to see a real problem before doing something like this.

							Thanx, Paul
