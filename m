Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3250C433E2
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 03:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F221206D4
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 03:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEfyhUW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgIDDUF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgIDDUA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Sep 2020 23:20:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16265C061244;
        Thu,  3 Sep 2020 20:20:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so5190951qki.6;
        Thu, 03 Sep 2020 20:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=80CFQtFde+qtYiGfWcY/qJg3XkhIeJopKwt8eVx7U6w=;
        b=tEfyhUW9WHRFp7bs2Qm8oiLIm0dkN/2pzFFomWdLy7V2hCstpf+If0XgCmgyqI9t10
         wpzLUkYOXIg7fWlC/zOoI4Pt+RMTwklCIHl8F/Ulx5S7tx4wgbVCVc0a+FfqWFOgERg2
         O+qTw69waFzOxPK7SoZUjq86RrMN5ZOzHUbbogvzklFnA8EXrkPPsm5bhV8vsDBSmyZd
         7zHBIHyWYo+j3VPft1FqC+8EEWSIutjNcUta9pWZBrsVBR+qVlNydOFnRhcE+GWYzEFb
         +idPZqhjyZpbH92BE5jkcYhbfc+7GFPEvA0zyu5kbiJg5gdHRUF5qu+AzJJYulnFq/Ny
         WS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80CFQtFde+qtYiGfWcY/qJg3XkhIeJopKwt8eVx7U6w=;
        b=XQUgoIHiiQiR2+kzNtEcxSkvgyz/0CeNlJRFmj/AOGtMvZNUAlYQFE6sOUQhmQ7vRt
         0Agca+6t+18bZcLJBVtrcbkYPajycrzDuAlXmKJoF1H81znhRtV5wgYKZ8g5bLx2kVxD
         UEs0EttKziX+wvQgSqb/jYZqD+o09UogsBVpcV+ejLy+W8TgoOwBAz8FQ9m0wsmLaA3X
         289NQ1xpRS8ZcJ3IYuoHI8hDi/oF6IF5rc8spc/72ft/y+ArbRPFOLV57L0TotLu5mGu
         0KqxoME5Dkl0Pu8FYoeWjM0feybaWjNkOp16TyG6ao13U7IniSVsVgBz25N26bRd0tcc
         gWgQ==
X-Gm-Message-State: AOAM533r+wySBmNx7Gjkvy+uO/14YN6jMzE7jPZ2kPAIc5xpEOJEMJr7
        1ynHKOtQEBs0iXi9WhaRybc=
X-Google-Smtp-Source: ABdhPJwoe4zuyuhBKpAl8a35s3zs8Sz+yGWQNkSI2gfYyM8ttQWX9964ds9JLGTAzyTbZvjg3KOjbQ==
X-Received: by 2002:a05:620a:64b:: with SMTP id a11mr6104797qka.313.1599189599127;
        Thu, 03 Sep 2020 20:19:59 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k185sm3681430qkc.77.2020.09.03.20.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:19:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C52FB27C0054;
        Thu,  3 Sep 2020 23:19:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 23:19:56 -0400
X-ME-Sender: <xms:W7JRXw6y4hQA3Fxo6pqpVr8swZIe6wtatxCyt1WNYKqJ1U__dVtTYg>
    <xme:W7JRXx6AXCFKaTVN_zbxQm0W-NMNKzpll5i6iGoCG6_sM0TkWGZlnHQq1Ul_a-nlG
    Tt5sVAazHhjS1Ul9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeevieejtdfhieejfeduheehvdevge
    dugeethefggfdtvdeutdevgeetvddvfeegtdenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:W7JRX_fYhWacJYYa4DXJ2kwvgxSBDzY2YB3RNf37uoue4cWcbcES8g>
    <xmx:W7JRX1K3gmIRVE5dO1CRHuBPhmMJn4f5_pbfeqkqGLwJPSmR9QNrsA>
    <xmx:W7JRX0J-N7q_Qk4jiaJ23ppASyKslh67LKZ83RdULcp8XUN7nQtMuQ>
    <xmx:XLJRX9dJDvXajHocgjmdMFVg5LiM5dKGXX9B1gD-OXO_F1D7VTcV5aaEXxI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9776E328005A;
        Thu,  3 Sep 2020 23:19:54 -0400 (EDT)
Date:   Fri, 4 Sep 2020 11:19:53 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
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
Message-ID: <20200904031953.GB7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
 <20200831181417.1378-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831181417.1378-3-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 31, 2020 at 11:14:16AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit causes csd_lock_wait() to emit diagnostics when a CPU
> fails to respond quickly enough to one of the smp_call_function()
> family of function calls.  These diagnostics are enabled by a new
> CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.
> 
> This commit was inspired by an earlier patch by Josef Bacik.
> 
> [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> [ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
> [ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
> [ paulmck: Apply Peter Zijlstra feedback. ]
> Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/smp.c      | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug |  11 +++++
>  2 files changed, 143 insertions(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index a47382d..c5d3188 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -20,6 +20,9 @@
>  #include <linux/sched.h>
>  #include <linux/sched/idle.h>
>  #include <linux/hypervisor.h>
> +#include <linux/sched/clock.h>
> +#include <linux/nmi.h>
> +#include <linux/sched/debug.h>
>  
>  #include "smpboot.h"
>  #include "sched/smp.h"
> @@ -96,6 +99,103 @@ void __init call_function_init(void)
>  	smpcfd_prepare_cpu(smp_processor_id());
>  }
>  
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +
> +static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
> +static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> +static DEFINE_PER_CPU(void *, cur_csd_info);
> +
> +#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
> +atomic_t csd_bug_count = ATOMIC_INIT(0);
> +
> +/* Record current CSD work for current CPU, NULL to erase. */
> +static void csd_lock_record(call_single_data_t *csd)
> +{
> +	if (!csd) {
> +		smp_mb(); /* NULL cur_csd after unlock. */
> +		__this_cpu_write(cur_csd, NULL);
> +		return;
> +	}
> +	__this_cpu_write(cur_csd_func, csd->func);
> +	__this_cpu_write(cur_csd_info, csd->info);
> +	smp_wmb(); /* func and info before csd. */
> +	__this_cpu_write(cur_csd, csd);
> +	smp_mb(); /* Update cur_csd before function call. */
> +		  /* Or before unlock, as the case may be. */
> +}
> +
> +static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
> +{
> +	unsigned int csd_type;
> +
> +	csd_type = CSD_TYPE(csd);
> +	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
> +		return csd->dst; /* Other CSD_TYPE_ values might not have ->dst. */
> +	return -1;
> +}
> +
> +/*
> + * Complain if too much time spent waiting.  Note that only
> + * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> + * so waiting on other types gets much less information.
> + */
> +static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> +{
> +	int cpu = -1;
> +	int cpux;
> +	bool firsttime;
> +	u64 ts2, ts_delta;
> +	call_single_data_t *cpu_cur_csd;
> +	unsigned int flags = READ_ONCE(csd->flags);
> +
> +	if (!(flags & CSD_FLAG_LOCK)) {
> +		if (!unlikely(*bug_id))
> +			return true;
> +		cpu = csd_lock_wait_getcpu(csd);
> +		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> +			 *bug_id, raw_smp_processor_id(), cpu);
> +		return true;
> +	}
> +
> +	ts2 = sched_clock();
> +	ts_delta = ts2 - *ts1;
> +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> +		return false;
> +
> +	firsttime = !*bug_id;
> +	if (firsttime)
> +		*bug_id = atomic_inc_return(&csd_bug_count);
> +	cpu = csd_lock_wait_getcpu(csd);
> +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> +		cpux = 0;
> +	else
> +		cpux = cpu;
> +	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */

Should we re-read csd->flags and check CSD_FLAG_LOCK again to improve
the accuracy or to avoid unnecessary stack dumping? Because cpux may
just finish the csd in question and clear the CSD_FLAG_LOCK bit, so it's
late but no so late ;-) Maybe we can put the following check:

> +	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 cpu, csd->func, csd->info);

	/*
	 * Re-read and check the flag.
	 *
	 * If destination cpu just handled the csd in question, we want
	 * to report the timeout but may not want to do stack dumping on
	 * either src or dst cpu, because in that case the stacks will
	 * be pretty much pointless. Since csd_lock_record(NULL) will
	 * issue a smp_mb() before setting cur_csd, we are guaranteed
	 * to observe the unlocked state of ->flags if the previous
	 * smp_load_acquire() observe the csd_lock_record(NULL) of
	 * handling the csd in question as follow:
	 * 
	 * CPU 0			CPU 1
	 *				<queue csd>
	 * <handle other csds>		csd_lock_wait_toolong()
	 * 				flags = READ_ONCE(csd->flags); // locked
	 * <handle the csd of CPU 1>
	 * csd_lock_record(csd);
	 * func(info);
	 * csd_unlock(csd); // unlocked
	 * csd_lock_record(NULL);
	 *				<ts_delat > CSD_LOCK_TIMEOUT> // going to report the timeout
	 *				cpu_cur_csd = smp_load_acquire(...);
	 * <handle other csds>
	 * csd_lock_record(other_csd);
	 *				flags = READ_ONCE(csd->flags); // observe the unlocked state
	 *				                               // no matter cpu_cur_csd is NULL or other_csd
	 * 
	 */
	flags = READ_ONCE(csd->flags);
	if (!(flags & CSD_FLAG_LOCK)) {
		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
			 *bug_id, raw_smp_processor_id(), cpux);
		return true;
	}

Thoughts?

Regards,
Boqun

> +	if (cpu_cur_csd && csd != cpu_cur_csd) {
> +		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
> +			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> +			 READ_ONCE(per_cpu(cur_csd_info, cpux)));
> +	} else {
> +		pr_alert("\tcsd: CSD lock (#%d) %s.\n",
> +			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
> +	}
> +	if (cpu >= 0) {
> +		if (!trigger_single_cpu_backtrace(cpu))
> +			dump_cpu_task(cpu);
> +		if (!cpu_cur_csd) {
> +			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
> +			arch_send_call_function_single_ipi(cpu);
> +		}
> +	}
> +	dump_stack();
> +	*ts1 = ts2;
> +
> +	return false;
> +}
> +
>  /*
>   * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
>   *
> @@ -105,8 +205,28 @@ void __init call_function_init(void)
>   */
>  static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
> +	int bug_id = 0;
> +	u64 ts0, ts1;
> +
> +	ts1 = ts0 = sched_clock();
> +	for (;;) {
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +			break;
> +		cpu_relax();
> +	}
> +	smp_acquire__after_ctrl_dep();
> +}
> +
> +#else
> +static void csd_lock_record(call_single_data_t *csd)
> +{
> +}
> +
> +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> +{
>  	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
>  }
> +#endif
>  
>  static __always_inline void csd_lock(call_single_data_t *csd)
>  {
> @@ -166,9 +286,11 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
>  		 * We can unlock early even for the synchronous on-stack case,
>  		 * since we're doing this from the same CPU..
>  		 */
> +		csd_lock_record(csd);
>  		csd_unlock(csd);
>  		local_irq_save(flags);
>  		func(info);
> +		csd_lock_record(NULL);
>  		local_irq_restore(flags);
>  		return 0;
>  	}
> @@ -268,8 +390,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
>  				entry = &csd_next->llist;
>  			}
>  
> +			csd_lock_record(csd);
>  			func(info);
>  			csd_unlock(csd);
> +			csd_lock_record(NULL);
>  		} else {
>  			prev = &csd->llist;
>  		}
> @@ -296,8 +420,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
>  				smp_call_func_t func = csd->func;
>  				void *info = csd->info;
>  
> +				csd_lock_record(csd);
>  				csd_unlock(csd);
>  				func(info);
> +				csd_lock_record(NULL);
>  			} else if (type == CSD_TYPE_IRQ_WORK) {
>  				irq_work_single(csd);
>  			}
> @@ -375,7 +501,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  
>  	csd->func = func;
>  	csd->info = info;
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +	csd->src = smp_processor_id();
>  	csd->dst = cpu;
> +#endif
>  
>  	err = generic_exec_single(cpu, csd);
>  
> @@ -541,7 +670,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  			csd->flags |= CSD_TYPE_SYNC;
>  		csd->func = func;
>  		csd->info = info;
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +		csd->src = smp_processor_id();
>  		csd->dst = cpu;
> +#endif
>  		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
>  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>  	}
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e068c3c..86a35fd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1367,6 +1367,17 @@ config WW_MUTEX_SELFTEST
>  	  Say M if you want these self tests to build as a module.
>  	  Say N if you are unsure.
>  
> +config CSD_LOCK_WAIT_DEBUG
> +	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
> +	depends on DEBUG_KERNEL
> +	depends on 64BIT
> +	default n
> +	help
> +	  This option enables debug prints when CPUs are slow to respond
> +	  to the smp_call_function*() IPI wrappers.  These debug prints
> +	  include the IPI handler function currently executing (if any)
> +	  and relevant stack traces.
> +
>  endmenu # lock debugging
>  
>  config TRACE_IRQFLAGS
> -- 
> 2.9.5
> 
