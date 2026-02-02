Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FB34E754
	for <rcu@vger.kernel.org>; Mon,  2 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031526; cv=none; b=W69t8fQ3NAGnYrze07g7kNwqpReANpUrdlBiXbpk9nCHmn1qnG4k8NFpDf2+30lFH1A39Ee+0bmHNZeJS6E8wvkrK85hx9H3HG1GD6ywX7LPUQXhoa73WXbKlCfHz4j4A+dspA1G00N7w0Rwu8nhmEFaFGiGLMxPlvthxDdH5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031526; c=relaxed/simple;
	bh=JDC/57zG5agFPz4qjQ6fu+ZOovBezu9uAwWFpyU7V3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1U8sPXGrrRzSZlWFjtCxp4wRQuEeDJNuF5C9rxOxCK+k2CxbDyV6v0y2zOH7xos44Ivv6QRFyVrupfiRg2pi/76EiE83vvZ1K4HZHhkDmBZNKptDfP5xHygZ/z9sXYau1tzQT0RruEP6jMLiAaEQqeTLRiJMMzcW5jrvgYqMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOZt49vJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOZt49vJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so3945999e87.3
        for <rcu@vger.kernel.org>; Mon, 02 Feb 2026 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031522; x=1770636322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LwafLicK3LzdnPYyHJjE395Sj5JD8HbA6UwImkbDOM=;
        b=EOZt49vJ5gTty5vxlXDed7iMDhKJIFcQ9xD2W4FDxzqvIwXIlAWW/4wt5zZ2F4PgA1
         DEwf+k8irJa9qpO6u3AhCgFBsU/vX1XNxioBo7vgIZC724aFlCNlUKKayYy54iYejqG0
         8tAHFwjV+cXRNwdeucq0Rc3Lcycp2V9Rvcok62MpdpepnFtNxa3buMeNgQse3tvyyACx
         EBYT+iRbmYg4PN2Qv6yblGuqPyVozpwLRP+Z9pUAbBHHBE54luTVZi4Ax2LBiHhYw1Zn
         +AGg7PBEaaFGO26gAA5wAdE0/2VGnkJPFQuOO35qKAwQ4t5g5+FzQtkt3BPGLS0vWWjD
         hsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031522; x=1770636322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LwafLicK3LzdnPYyHJjE395Sj5JD8HbA6UwImkbDOM=;
        b=U+AKItHXN4WiFAEqawVvVM3fyCAuzvKg4oZ0YQqXxkGzvYxurVTv5LPZRV8w1RTYbu
         Z7pA1ruLFotaM+F2MnzETkdzScAAkebZyroCAkVQ37ma524cAOSu0i2a6pU1uOXRlkiz
         qKrb4LnUuXjnVmlr7G6P+bezEnjg6ob5M7jdq+ELHlahXuLExUANJ01a9D/Ib8WOyo0F
         Yyyk7IC1OM3PnlH7ivFn9cqcSJywWzc6xHKnALZiAJ+EUNIpf6QYCFxZn7z2CSnnlJ+T
         Pk2bJX157uhZ8LK9ZrPBMDxf4fkL/NAwetMNW0oYrV99KiLKhsJpeFtctRWktIBiIQK7
         thkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNHT9fr6Geq09h66aHRh+8uVpB5eCrz3Ri8oog5dFP9g0EM7nnFB5bQwiQ9xJEyq7HmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeYuQOMvoyJzTyVpoP4mu1yli6zfec08IyQJSpUoQ0Pf1PeM9
	UShX8/Adc/0P+qcPPqjhbjgC7/CRx7dY+dJdu+ppCjpa5SGMUxNg+zAk
X-Gm-Gg: AZuq6aI0UIuHUvpvpLJGFQUKiZHwztz0apt4O6rXvnl/hdB4ENxuGE5A6vWtlOeo1zl
	4G6VSQI3AOJ/2sRT+V/KvRJcSdEnRb9StLbrcbteuSX7pkTIXzE++2US+QGhyijtfWdkGU+CTdK
	QGaZ7SCyLryV0/75ltW/MN1ivZadcbP5POQrjKtuogxpvZiVbzaR6MYCluglZAE4VUmvt0A9q+N
	Lsp46xwZVG7sVDUK/y61L/RQBj0evHidj1Wdn4kRcMv/GDtuN5ZdqZcp6xgVzEUd6yqCLzdKKZM
	jkOXEWmNhMA4xs0AFxKZLy3Vtfds/7nQuFLwn+bPpwZwYvbTZgJFXadx8ySHoNo5nFDuANztn5w
	USE0nuqaEnqqqxE/rDuttfJMYbsfuUZu69I1SdHI6cxQrjL+OZFXj
X-Received: by 2002:a05:6512:ad4:b0:59e:9b0:bf4d with SMTP id 2adb3069b0e04-59e16401fa6mr4351177e87.22.1770031521307;
        Mon, 02 Feb 2026 03:25:21 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e07481b72sm3530518e87.11.2026.02.02.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:25:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 2 Feb 2026 12:25:18 +0100
To: Samir M <samir@linux.ibm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Paul E McKenney <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <aYCJnqOWyBUJrwcN@milan>
References: <20260114183415.286489-1-urezki@gmail.com>
 <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
 <B7C99D22-0544-4177-A299-E3D458EA55F6@nvidia.com>
 <00e91ebc-0783-4519-9727-53dd3a625298@linux.ibm.com>
 <aXYnMq45xciq47oq@pc636>
 <a305a6c5-77d2-4e7e-b7ef-99e9eb6c03a6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a305a6c5-77d2-4e7e-b7ef-99e9eb6c03a6@linux.ibm.com>

Hello, Samir!

> 
> On 25/01/26 7:52 pm, Uladzislau Rezki wrote:
> > Hello, Shrikanth, Samir!
> > 
> > > On 1/17/26 2:18 PM, Joel Fernandes wrote:
> > > > 
> > > > > On Jan 17, 2026, at 1:17 AM, Samir M <samir@linux.ibm.com> wrote:
> > > > > 
> > > > > ﻿
> > > > > > On 15/01/26 12:04 am, Uladzislau Rezki (Sony) wrote:
> > > > > > Currently, rcu_normal_wake_from_gp is only enabled by default
> > > > > > on small systems(<= 16 CPUs) or when a user explicitly set it
> > > > > > enabled.
> > > > > > 
> > > > > > This patch introduces an adaptive latching mechanism:
> > > > > >    * Tracks the number of in-flight synchronize_rcu() requests
> > > > > >      using a new atomic_t counter(rcu_sr_normal_count);
> > > > > > 
> > > > > >    * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
> > > > > >      the rcu_sr_normal_latched, reverting new requests onto the
> > > > > >      scaled wait_rcu_gp() path;
> > > > > > 
> > > > > >    * The latch is cleared only when the pending requests are fully
> > > > > >      drained(nr == 0);
> > > > > > 
> > > > > >    * Enables rcu_normal_wake_from_gp by default for all systems,
> > > > > >      relying on this dynamic throttling instead of static CPU
> > > > > >      limits.
> > > > > > 
> > > > > > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > ---
> > > > > >    kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
> > > > > >    1 file changed, 26 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 293bbd9ac3f4..c42d480d6e0b 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> > > > > >        atomic_set_release(&sr_wn->inuse, 0);
> > > > > >    }
> > > > > >    -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > > > > > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > > > > > -
> > > > > > -static int rcu_normal_wake_from_gp = -1;
> > > > > > +static int rcu_normal_wake_from_gp = 1;
> > > > > >    module_param(rcu_normal_wake_from_gp, int, 0644);
> > > > > >    static struct workqueue_struct *sync_wq;
> > > > > >    +#define RCU_SR_NORMAL_LATCH_THR 64
> > > > > > +
> > > > > > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > > > > > +static atomic_long_t rcu_sr_normal_count;
> > > > > > +static atomic_t rcu_sr_normal_latched;
> > > > > > +
> > > > > >    static void rcu_sr_normal_complete(struct llist_node *node)
> > > > > >    {
> > > > > >        struct rcu_synchronize *rs = container_of(
> > > > > >            (struct rcu_head *) node, struct rcu_synchronize, head);
> > > > > > +    long nr;
> > > > > >          WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > > > > >            !poll_state_synchronize_rcu_full(&rs->oldstate),
> > > > > > @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > > > > >          /* Finally. */
> > > > > >        complete(&rs->completion);
> > > > > > +    nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > > > > > +    WARN_ON_ONCE(nr < 0);
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Unlatch: switch back to normal path when fully
> > > > > > +     * drained and if it has been latched.
> > > > > > +     */
> > > > > > +    if (nr == 0)
> > > > > > +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > > > >    }
> > > > > >      static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > > > @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
> > > > > >      static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > > >    {
> > > > > > +    long nr;
> > > > > > +
> > > > > >        llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > > > > +    nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > > > > +
> > > > > > +    /* Latch: only when flooded and if unlatched. */
> > > > > > +    if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > > > > > +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > > > > >    }
> > > > > >      /*
> > > > > > @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
> > > > > >          trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> > > > > >    -    if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> > > > > > +    if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> > > > > > +            atomic_read(&rcu_sr_normal_latched)) {
> > > > > >            wait_rcu_gp(call_rcu_hurry);
> > > > > >            goto trace_complete_out;
> > > > > >        }
> > > > > > @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
> > > > > >        sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> > > > > >        WARN_ON(!sync_wq);
> > > > > >    -    /* Respect if explicitly disabled via a boot parameter. */
> > > > > > -    if (rcu_normal_wake_from_gp < 0) {
> > > > > > -        if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > > > > > -            rcu_normal_wake_from_gp = 1;
> > > > > > -    }
> > > > > > -
> > > > > >        /* Fill in default value for rcutree.qovld boot parameter. */
> > > > > >        /* -After- the rcu_node ->lock fields are initialized! */
> > > > > >        if (qovld < 0)
> > > > > 
> > > > > Hi Uladzislau,
> > > > > 
> > > > > I verified this patch using the configuration described below.
> > > > > Configuration:
> > > > >       •    Kernel version: 6.19.0-rc5
> > > > >       •    Number of CPUs: 2048
> > > > > 
> > > > > Using this setup, I evaluated the patch with both SMT enabled and SMT disabled. The results indicate that when SMT is enabled, the system time is noticeably higher. In contrast, with SMT disabled, no significant increase in system time is observed.
> > > > > 
> > > > > SMT=ON  -> sys 31m22.922s
> > > > > SMT=OFF -> sys 0m0.046s
> > > > > 
> > > > > 
> > > > > SMT Mode    | Without Patch    | With Patch   | % Improvement    |
> > > > > ------------------------------------------------------------------
> > > > > SMT=off     | 30m 53.194s      | 26m 24.009s  | +14.53%          |
> > > > > SMT=on      | 49m 5.920s       | 47m 5.513s   | +4.09%
> > > > So it takes you 47 minutes to offline CPUs and you are Ok with that?
> > > > 
> > > > - Joel
> > > > 
> > > 
> > > This is certainly quite long. IMO not worth the added complexity
> > > of atomic inc/dec reads happening(even though till 64 CPUs)
> > > 
> > I tested the overhead/contention of this patch on my system. I have
> > 256 CPUs x86_64 AMD based system.
> > 
> > My question, is it possible to verify it on your 2000 CPUs system?
> > See below what i would like to check.
> > 
> > 1) Generate synthetic workload and run it:
> > 
> > <snip>
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index 6521c05c7816..569bd89620b7 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -350,16 +350,17 @@ struct test_kvfree_rcu {
> >   static int
> >   kvfree_rcu_1_arg_vmalloc_test(void)
> >   {
> > -       struct test_kvfree_rcu *p;
> > +       /* struct test_kvfree_rcu *p; */
> >          int i;
> >          for (i = 0; i < test_loop_count; i++) {
> > -               p = vmalloc(1 * PAGE_SIZE);
> > -               if (!p)
> > -                       return -1;
> > +               /* p = vmalloc(1 * PAGE_SIZE); */
> > +               /* if (!p) */
> > +               /*      return -1; */
> > -               p->array[0] = 'a';
> > -               kvfree_rcu_mightsleep(p);
> > +               /* p->array[0] = 'a'; */
> > +               /* kvfree_rcu_mightsleep(p); */
> > +               synchronize_rcu();
> >          }
> >          return 0;
> > <snip>
> > 
> > make "rcu_sr_normal_add_req" explicitly as noinline to annotate it:
> > 
> > <snip>
> > -static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +static void noinline
> > +rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> >   {
> > <snip>
> > 
> > # run the workload. So it is a tight loop.
> > sudo ./test_vmalloc.sh run_test_mask=256 nr_pages=1 nr_threads=60000 test_loop_count=100000&
> > 
> > give a system some time, because it takes time to create such number of jobs
> > 
> > 2) Start "perf" to collect data during 15 seconds in my case:
> > sudo perf record -a -g -e cycles -- sleep 15
> > 
> > 3) sudo perf report -k ./vmlinux
> > Samples: 1M of event 'cycles', Event count (approx.): 521275605639
> >    Children      Self  Command          Shared Object                Symbol
> > +   22.00%     0.00%  swapper          [kernel.kallsyms]            [k] common_startup_64
> > +   22.00%     0.02%  swapper          [kernel.kallsyms]            [k] cpu_startup_entry
> > +   21.97%     0.24%  swapper          [kernel.kallsyms]            [k] do_idle
> > +   21.88%     0.00%  swapper          [kernel.kallsyms]            [k] start_secondary
> > +    9.11%     0.00%  kthreadd         [kernel.kallsyms]            [k] ret_from_fork_asm
> > +    9.11%     0.00%  kthreadd         [kernel.kallsyms]            [k] ret_from_fork
> > +    9.06%     0.00%  kthreadd         [kernel.kallsyms]            [k] kthread
> > +    8.99%     0.00%  kthreadd         [test_vmalloc]               [k] 0xffffffffc05b4800
> > +    8.95%     0.00%  kthreadd         [test_vmalloc]               [k] 0xffffffffc05b4236
> > +    8.88%     0.17%  swapper          [kernel.kallsyms]            [k] __flush_smp_call_function_queue
> > +    8.69%     0.12%  kthreadd         [kernel.kallsyms]            [k] synchronize_rcu_normal
> >     - 8.58% synchronize_rcu_normal
> >        - 8.53% __wait_rcu_gp
> >           - 8.18% wait_for_completion_state
> >              - 8.17% __wait_for_common
> >                 - 7.71% schedule_timeout
> >                    - 7.44% schedule
> >                       - 7.11% __schedule
> >                          - 3.08% pick_next_task_fair
> >                             - 1.53% sched_balance_rq
> >                                - 1.20% sched_balance_find_src_group
> >                                     update_sd_lb_stats.constprop.0
> >                               0.56% pick_task_fair
> >                          - 1.65% dequeue_task_fair
> >                             - 1.48% dequeue_entities
> >                                  0.60% update_curr
> > +    8.53%     0.11%  kthreadd         [kernel.kallsyms]            [k] __wait_rcu_gp
> > +    8.20%     0.12%  kthreadd         [kernel.kallsyms]            [k] __wait_for_common
> > +    8.18%     0.02%  kthreadd         [kernel.kallsyms]            [k] wait_for_completion_state
> > +    7.98%     0.54%  swapper          [kernel.kallsyms]            [k] sched_ttwu_pending
> > +    7.74%     0.27%  kthreadd         [kernel.kallsyms]            [k] schedule_timeout
> > +    7.47%     0.33%  kthreadd         [kernel.kallsyms]            [k] schedule
> > +    7.14%     1.28%  kthreadd         [kernel.kallsyms]            [k] __schedule
> > +    6.83%     0.14%  swapper          [kernel.kallsyms]            [k] ttwu_do_activate
> > +    6.50%     0.84%  swapper          [kernel.kallsyms]            [k] enqueue_task
> > +    6.38%     0.07%  swapper          [kernel.kallsyms]            [k] flush_smp_call_function_queue
> > 
> > synchronize_rcu_normal() consumes cycles mostly for doing __schedule().
> > 
> > 4) sudo perf annotate rcu_sr_normal_add_req -k ./vmlinux
> > 
> > <snip>
> > Samples: 826  of event 'cycles', 2000 Hz, Event count (approx.): 399643217
> > rcu_sr_normal_add_req  ./vmlinux [Percent: local period]
> > Percent │    → callq    __fentry__
> >     0.25 │      movq     rcu_state+0x59ac8,%rax
> >    20.41 │ c:   movq     %rax,(%rdi)
> >     2.26 │      lock
> >          │      cmpxchgq %rdi,rcu_state+0x59ac8
> >    42.76 │    ↑ jne      c
> >          │      movl     $0x1,%eax
> >     0.57 │      lock
> >          │      xaddq    %rax,rcu_sr_normal_count
> >    24.38 │      addq     $0x1,%rax
> >     1.04 │      cmpq     $0x3f,%rax
> >          │    ↓ jle      41
> >          │      xorl     %eax,%eax
> >          │      movl     $0x1,%edx
> >          │      lock
> >          │      cmpxchgl %edx,rcu_sr_normal_latched
> >     8.34 │41: → jmp      __pi___x86_return_thunk
> > <snip>
> > 
> > This particular function consumed 399643217 cycles. In total for whole system
> > it is 521275605639 cycles:
> > 
> > > > > 100 - (521275605639 - 399643217) * 100 / 521275605639
> > 0.07666639541095321
> > so it is ~0.0 percent.
> > 
> > <snip>
> > sudo perf report -k ./vmlinux
> >       0.02%     0.02%  kthreadd         [kernel.kallsyms]  [k] rcu_sr_normal_add_req
> >       0.00%     0.00%  vmalloc_test/14  [kernel.kallsyms]  [k] rcu_sr_normal_add_req
> >       0.00%     0.00%  vmalloc_test/28  [kernel.kallsyms]  [k] rcu_sr_normal_add_req
> > ...
> > <snip>
> > 
> > i.e. if we simulate a high flood of incoming sync calls the system most
> > time spends on scheduling. The contention is a noise on my system.
> > 
> > Is that possible to get some data on your 2000 CPUs system? You can
> > provide perf.data or post results here.
> > 
> > Thank you!
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> I followed the steps described above and collected the data shown below. Due
> to system unavailability, this experiment was conducted using the
> configuration listed below instead of a *2048-CPU* system.
> *Configuration:*
> 
>  * Kernel version: 6.19.0-rc6
>  * Number of CPUs: 1536
> 
> With above configuration i have update smt=on/off time results under below
> patch:
> Patch link: https://lore.kernel.org/all/e2cca734-9191-4073-ba9d-936014498645@linux.ibm.com/
> 
> 
> 
> Step 1: Ran the sudo ./test_vmalloc.sh run_test_mask=256 nr_pages=1
> nr_threads=60000 test_loop_count=100000& comman.
> Step 2: Collected the perf data for 15 sec,
> Ex: sudo perf record -a -g -e cycles -- sleep 15
> Step 3: sudo perf report -k ./vmlinux
> Samples: 3M of event 'cycles', Event count (approx.): 932020263832
> Children Self Command Shared Object Symbol
> + 84.69% 0.00% swapper [kernel.kallsyms] [k] cpu_startup_entry
> + 84.66% 0.31% swapper [kernel.kallsyms] [k] do_idle
> + 84.60% 0.00% swapper [kernel.kallsyms] [k] start_secondary_prolog
> + 84.60% 0.00% swapper [kernel.kallsyms] [k] start_secondary
> + 79.74% 0.14% swapper [kernel.kallsyms] [k] call_cpuidle
> + 79.60% 0.03% swapper [kernel.kallsyms] [k] cpuidle_enter
> + 79.56% 0.15% swapper [kernel.kallsyms] [k] cpuidle_enter_state
> + 74.04% 0.11% swapper [kernel.kallsyms] [k] dedicated_cede_loop
> + 73.92% 0.02% swapper [kernel.kallsyms] [k] check_and_cede_processor
> + 51.57% 0.04% swapper [kernel.kallsyms] [k] plpar_hcall_norets_notrace
> + 50.76% 0.17% swapper [kernel.kallsyms] [k] timer_interrupt
> + 41.55% 0.15% swapper [kernel.kallsyms] [k] hrtimer_interrupt
> + 40.91% 0.16% swapper [kernel.kallsyms] [k] __hrtimer_run_queues
> + 40.54% 0.29% swapper [kernel.kallsyms] [k] tick_nohz_handler
> + 40.01% 0.15% swapper [kernel.kallsyms] [k] update_process_times
> + 39.31% 0.27% swapper [kernel.kallsyms] [k] update_curr_dl_se
> + 39.11% 0.19% swapper [kernel.kallsyms] [k] sched_tick
> + 31.49% 31.29% swapper [kernel.kallsyms] [k] queued_spin_lock_slowpath
> + 24.64% 0.01% swapper [kernel.kallsyms] [k] start_dl_timer
> + 24.61% 0.02% swapper [kernel.kallsyms] [k] hrtimer_start_range_ns
> + 22.52% 0.24% swapper [kernel.kallsyms] [k] _raw_spin_lock_irqsave
> + 21.90% 0.01% swapper [kernel.kallsyms] [k] lock_hrtimer_base
> + 14.40% 0.01% swapper [kernel.kallsyms] [k] hrtimer_try_to_cancel
> + 10.00% 0.84% swapper [kernel.kallsyms] [k] _raw_spin_lock
> + 7.88% 0.42% swapper [kernel.kallsyms] [k] get_nohz_timer_target
> + 7.03% 7.03% swapper [kernel.kallsyms] [k] idle_cpu
> + 6.03% 0.02% swapper [kernel.kallsyms] [k] irq_exit
> + 5.95% 0.06% swapper [kernel.kallsyms] [k] __irq_exit_rcu
> + 5.68% 0.02% swapper [kernel.kallsyms] [k] do_softirq_own_stack
> + 5.68% 0.10% swapper [kernel.kallsyms] [k] handle_softirqs
> + 5.06% 4.99% swapper [kernel.kallsyms] [k] ktime_get
> + 4.88% 4.77% swapper [kernel.kallsyms] [k] snooze_loop
> + 3.82% 3.82% swapper [unknown] [H] 0x0000000000372980
> + 3.74% 3.74% swapper [unknown] [H] 0x0000000000372960
> + 3.41% 0.00% swapper [ipr]__versions [k] ____versions+0x0
> + 2.95% 2.95% swapper [unknown] [H] 0x0000000000372970
> + 2.65% 0.01% swapper [kernel.kallsyms] [k] schedule_idle
> + 2.64% 0.18% swapper [kernel.kallsyms] [k] __schedule
> + 2.03% 0.02% swapper [kernel.kallsyms] [k] __pick_next_task
> + 2.01% 0.07% swapper [kernel.kallsyms] [k] pick_next_task_fair
> + 1.84% 0.17% swapper [kernel.kallsyms] [k] sched_balance_domains
> + 1.82% 1.82% swapper [unknown] [H] 0x000000000037297c
> + 1.76% 0.00% swapper [af_packet]__versions [k] ____versions+0x0
> + 1.75% 1.75% swapper [unknown] [H] 0x0000000000372954
> + 1.66% 0.16% swapper [kernel.kallsyms] [k] sched_balance_rq
> + 1.23% 0.02% swapper [kernel.kallsyms] [k] sched_balance_find_src_group
> 
> + 1.19% 0.58% swapper [kernel.kallsyms] [k] update_sd_lb_stats.constprop.0
> 
> 
> Step 4: sudo perf annotate rcu_sr_normal_add_req -k ./vmlinux
> Samples: 13K of event 'cycles', 4000 Hz, Event count (approx.): 2650282811
> rcu_sr_normal_add_req /home/linux/vmlinux [Percent: local period]
> Percent │ return start_new_poll;
> │ }
> │ static void noinline
> │ rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> │ {
> │ addis r2,r12,333
> │ addi r2,r2,8656
> 0.02 │ nop
> 
> │ */
> 
> rcu_sr_normal_add_req
> This particular function consumed 2650282811 cycles. In total for whole
> system
> it is 932020263832 cycles:
> >>> 100 - (932020263832 - 2650282811) * 100 / 932020263832
> 0.2843589258567647
> 
> >>>
> perf report -k ./vmlinux
>   0.01%     0.01%  vmalloc_test/37 [kernel.kallsyms]  [k]
> rcu_sr_normal_add_req
>      0.01%     0.01%  vmalloc_test/11  [kernel.kallsyms]  [k]
> rcu_sr_normal_add_req
>      0.01%     0.01%  vmalloc_test/27  [kernel.kallsyms]  [k]
> rcu_sr_normal_add_req
>      0.01%     0.01%  vmalloc_test/21  [kernel.kallsyms]  [k]
> rcu_sr_normal_add_req
> 
Thank you for your data. It is on pair with my. The conclusion from
my side is the rcu_sr_normal_add_req() does not introduce latency in
a way that it can impact performance or that it can become a bottle
neck for thousands simultaneous synchronize_rcu() users.

--
Uladzislau Rezki
