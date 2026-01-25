Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC898316918
	for <rcu@vger.kernel.org>; Sun, 25 Jan 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769350968; cv=none; b=OdmvIJ7BNg3GEGt7AH/qEoQ+bOODBOIWx5aLNu6uuexEo5eX7NsSGUDulNBLRCDng53d6JZPwQUysLeVBISU15WuquRcOnguW/cHshSkkqfB93BSOvGSyC6ekVZp0dHSkrvwMMte5ktmDkJ74RFjvxczTB+gC2/H4JGAwxhf1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769350968; c=relaxed/simple;
	bh=UPrpgS+3AquTZESmVQF1cEx714y4dXITrNBbvCe7XQI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpPJd5jHzpYaljnCsA9BUxdiVEnwLReSuRMl0qcSAq7yLpUHU3PwVXWtspFECyUCdEpNcwVCC8Rzd60uspoubi72+ScTBWywGXBE+YnpUZyQuuFVnBfTKMmGKJahHXvpKflUos5CKdjZUmuOfW1EnV4RnBBa2tBKnLB8Qj6Kueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6dLeukr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6dLeukr"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38316d0c26eso32272121fa.2
        for <rcu@vger.kernel.org>; Sun, 25 Jan 2026 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769350965; x=1769955765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5UYfGi10MWPXqeI9WPvQcckRLpBpq9B0NnSnv22hxY=;
        b=J6dLeukrB8ROYQKZ/I1Oopn68S1tkfVD+jF79TJ4k0vr41fGeEtb6GKBqhc2QBPanV
         xKDmGBt9ON9STQsFJgAGqBKTQJXRQogZ0rwLkjYk2ab4doclFGYszZbFtNOnx7DLP/uq
         be/e7ZX8IZM4zW7d6f5nU+bsWy8ASm4zQpQlzW0xwIvjs5Bogb8g0Y/mjvdAwejDQM+A
         6NqNvrUc/megqV1lHU3pCqM+sGrqgL7gJeaTNVu2jZbuUEYhZ3dlbpC+AI0L6b89nD8u
         i3MWTi48/i63dx2uw9fwYF+YvYdZMGSnt8VK8ueexVq9kx+joAk/paipu4hLpIZXj0Tt
         Sjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769350965; x=1769955765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5UYfGi10MWPXqeI9WPvQcckRLpBpq9B0NnSnv22hxY=;
        b=roM27hM8tI0qQSBnLqd7WVtZlkj/ErTsSPWBIugEVBdXV+2PIUBZiG7n4dy1BcufUV
         NQpyJDf2KmSecT5+M/ZI1zCOiCf8bQWFKJ2OnPDYrL6JcHCYM0QMl0YoDB7VziFsayjx
         YTQXCW0OZ4c4s23QPayszC5sZ8VWdQcD1FG0EEVBYzOlXxxFYRhcpNBUPFwHH3ViQkYH
         pD4TDdFDHdKZlLeD5r5A9SJhhHYtj0v31zUhMRwd6oU02hPGouDCzsmnvhzFCf5IH0/k
         RqcCpHg3Mbf9GmLf1vrw8uSzpYKMyspeCXLCX7TlLAryKDCzK0lVq1WQI3hZGfCi6kWV
         f2nA==
X-Forwarded-Encrypted: i=1; AJvYcCVVLLbuVbR65X9tKpT6nAcKORtxSQgj80V4AClPVYgCGiEwex/wnIAlyiBH45QAR276FPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5YMWbVqXq36YCanG5++/0AfyhrUUQiwspwr9irW4qaMChDNi
	+40ZrLZchG6yN2q/iliOdHUN5XLFr8jQCFxVflvn5hnQ8reP3L0g6B42
X-Gm-Gg: AZuq6aKyGXjAeZzKAwZhfiuYFJUiz0OCkhyBGnDlfKKbvQ0AkDBZwPfoPIqB9RSoRda
	0yGeo3TcSQH3qfl81VBclaHr3W7sJC2jO1aJ9V+VZHyL01oEQWtjtPQKFsbrI04V/ad2zRA6MCe
	j1FyWmlkIwFrNc5VK1ItnhBhWi3OsM6mgJpvijqN/aUCXxjn1Rsqi8o+1EADc/h/x8lxvjUFAox
	H/43LVYcETleJJAqT/+riaM7X6DXakSTqSp4KrOq6at4kjD/LeAcpp+gDvXIg/PZwIlY8ldcB2x
	HipfUHXwJuk4VHma8ddXRU3eV/5V/IeLvlQ6QxbBQMDPnsASpLstrTjZmT2ZagO+h8di6aqFxmG
	VH0G3XgLiNDwtLvPxfrW9Naxf68fYXcBqaXzEcWrl51KoC3ZkRxQ=
X-Received: by 2002:a05:651c:41ca:b0:384:9355:6a3c with SMTP id 38308e7fff4ca-385fa15849cmr4807521fa.24.1769350964731;
        Sun, 25 Jan 2026 06:22:44 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1d4e03sm20745571fa.42.2026.01.25.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:22:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 25 Jan 2026 15:22:42 +0100
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Samir M <samir@linux.ibm.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Samir M <samir@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Paul E McKenney <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <aXYnMq45xciq47oq@pc636>
References: <20260114183415.286489-1-urezki@gmail.com>
 <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
 <B7C99D22-0544-4177-A299-E3D458EA55F6@nvidia.com>
 <00e91ebc-0783-4519-9727-53dd3a625298@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00e91ebc-0783-4519-9727-53dd3a625298@linux.ibm.com>

Hello, Shrikanth, Samir! 

> 
> On 1/17/26 2:18 PM, Joel Fernandes wrote:
> > 
> > 
> > > On Jan 17, 2026, at 1:17 AM, Samir M <samir@linux.ibm.com> wrote:
> > > 
> > > ﻿
> > > > On 15/01/26 12:04 am, Uladzislau Rezki (Sony) wrote:
> > > > Currently, rcu_normal_wake_from_gp is only enabled by default
> > > > on small systems(<= 16 CPUs) or when a user explicitly set it
> > > > enabled.
> > > > 
> > > > This patch introduces an adaptive latching mechanism:
> > > >   * Tracks the number of in-flight synchronize_rcu() requests
> > > >     using a new atomic_t counter(rcu_sr_normal_count);
> > > > 
> > > >   * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
> > > >     the rcu_sr_normal_latched, reverting new requests onto the
> > > >     scaled wait_rcu_gp() path;
> > > > 
> > > >   * The latch is cleared only when the pending requests are fully
> > > >     drained(nr == 0);
> > > > 
> > > >   * Enables rcu_normal_wake_from_gp by default for all systems,
> > > >     relying on this dynamic throttling instead of static CPU
> > > >     limits.
> > > > 
> > > > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >   kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
> > > >   1 file changed, 26 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 293bbd9ac3f4..c42d480d6e0b 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> > > >       atomic_set_release(&sr_wn->inuse, 0);
> > > >   }
> > > >   -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > > > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > > > -
> > > > -static int rcu_normal_wake_from_gp = -1;
> > > > +static int rcu_normal_wake_from_gp = 1;
> > > >   module_param(rcu_normal_wake_from_gp, int, 0644);
> > > >   static struct workqueue_struct *sync_wq;
> > > >   +#define RCU_SR_NORMAL_LATCH_THR 64
> > > > +
> > > > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > > > +static atomic_long_t rcu_sr_normal_count;
> > > > +static atomic_t rcu_sr_normal_latched;
> > > > +
> > > >   static void rcu_sr_normal_complete(struct llist_node *node)
> > > >   {
> > > >       struct rcu_synchronize *rs = container_of(
> > > >           (struct rcu_head *) node, struct rcu_synchronize, head);
> > > > +    long nr;
> > > >         WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > > >           !poll_state_synchronize_rcu_full(&rs->oldstate),
> > > > @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > > >         /* Finally. */
> > > >       complete(&rs->completion);
> > > > +    nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > > > +    WARN_ON_ONCE(nr < 0);
> > > > +
> > > > +    /*
> > > > +     * Unlatch: switch back to normal path when fully
> > > > +     * drained and if it has been latched.
> > > > +     */
> > > > +    if (nr == 0)
> > > > +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > >   }
> > > >     static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
> > > >     static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > >   {
> > > > +    long nr;
> > > > +
> > > >       llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > > +    nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > > +
> > > > +    /* Latch: only when flooded and if unlatched. */
> > > > +    if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > > > +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > > >   }
> > > >     /*
> > > > @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
> > > >         trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> > > >   -    if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> > > > +    if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> > > > +            atomic_read(&rcu_sr_normal_latched)) {
> > > >           wait_rcu_gp(call_rcu_hurry);
> > > >           goto trace_complete_out;
> > > >       }
> > > > @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
> > > >       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> > > >       WARN_ON(!sync_wq);
> > > >   -    /* Respect if explicitly disabled via a boot parameter. */
> > > > -    if (rcu_normal_wake_from_gp < 0) {
> > > > -        if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > > > -            rcu_normal_wake_from_gp = 1;
> > > > -    }
> > > > -
> > > >       /* Fill in default value for rcutree.qovld boot parameter. */
> > > >       /* -After- the rcu_node ->lock fields are initialized! */
> > > >       if (qovld < 0)
> > > 
> > > 
> > > Hi Uladzislau,
> > > 
> > > I verified this patch using the configuration described below.
> > > Configuration:
> > >      •    Kernel version: 6.19.0-rc5
> > >      •    Number of CPUs: 2048
> > > 
> > > Using this setup, I evaluated the patch with both SMT enabled and SMT disabled. The results indicate that when SMT is enabled, the system time is noticeably higher. In contrast, with SMT disabled, no significant increase in system time is observed.
> > > 
> > > SMT=ON  -> sys 31m22.922s
> > > SMT=OFF -> sys 0m0.046s
> > > 
> > > 
> > > SMT Mode    | Without Patch    | With Patch   | % Improvement    |
> > > ------------------------------------------------------------------
> > > SMT=off     | 30m 53.194s      | 26m 24.009s  | +14.53%          |
> > > SMT=on      | 49m 5.920s       | 47m 5.513s   | +4.09%
> > 
> > So it takes you 47 minutes to offline CPUs and you are Ok with that?
> > 
> > - Joel
> > 
> 
> 
> This is certainly quite long. IMO not worth the added complexity
> of atomic inc/dec reads happening(even though till 64 CPUs)
> 
I tested the overhead/contention of this patch on my system. I have
256 CPUs x86_64 AMD based system.

My question, is it possible to verify it on your 2000 CPUs system?
See below what i would like to check.

1) Generate synthetic workload and run it:

<snip>
diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 6521c05c7816..569bd89620b7 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -350,16 +350,17 @@ struct test_kvfree_rcu {
 static int
 kvfree_rcu_1_arg_vmalloc_test(void)
 {
-       struct test_kvfree_rcu *p;
+       /* struct test_kvfree_rcu *p; */
        int i;
 
        for (i = 0; i < test_loop_count; i++) {
-               p = vmalloc(1 * PAGE_SIZE);
-               if (!p)
-                       return -1;
+               /* p = vmalloc(1 * PAGE_SIZE); */
+               /* if (!p) */
+               /*      return -1; */
 
-               p->array[0] = 'a';
-               kvfree_rcu_mightsleep(p);
+               /* p->array[0] = 'a'; */
+               /* kvfree_rcu_mightsleep(p); */
+               synchronize_rcu();
        }
 
        return 0;
<snip>

make "rcu_sr_normal_add_req" explicitly as noinline to annotate it: 

<snip>
-static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
+static void noinline
+rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
<snip>

# run the workload. So it is a tight loop.
sudo ./test_vmalloc.sh run_test_mask=256 nr_pages=1 nr_threads=60000 test_loop_count=100000&

give a system some time, because it takes time to create such number of jobs

2) Start "perf" to collect data during 15 seconds in my case:
sudo perf record -a -g -e cycles -- sleep 15

3) sudo perf report -k ./vmlinux
Samples: 1M of event 'cycles', Event count (approx.): 521275605639
  Children      Self  Command          Shared Object                Symbol       
+   22.00%     0.00%  swapper          [kernel.kallsyms]            [k] common_startup_64
+   22.00%     0.02%  swapper          [kernel.kallsyms]            [k] cpu_startup_entry
+   21.97%     0.24%  swapper          [kernel.kallsyms]            [k] do_idle
+   21.88%     0.00%  swapper          [kernel.kallsyms]            [k] start_secondary
+    9.11%     0.00%  kthreadd         [kernel.kallsyms]            [k] ret_from_fork_asm
+    9.11%     0.00%  kthreadd         [kernel.kallsyms]            [k] ret_from_fork
+    9.06%     0.00%  kthreadd         [kernel.kallsyms]            [k] kthread
+    8.99%     0.00%  kthreadd         [test_vmalloc]               [k] 0xffffffffc05b4800
+    8.95%     0.00%  kthreadd         [test_vmalloc]               [k] 0xffffffffc05b4236
+    8.88%     0.17%  swapper          [kernel.kallsyms]            [k] __flush_smp_call_function_queue
+    8.69%     0.12%  kthreadd         [kernel.kallsyms]            [k] synchronize_rcu_normal
   - 8.58% synchronize_rcu_normal
      - 8.53% __wait_rcu_gp
         - 8.18% wait_for_completion_state
            - 8.17% __wait_for_common
               - 7.71% schedule_timeout
                  - 7.44% schedule
                     - 7.11% __schedule
                        - 3.08% pick_next_task_fair
                           - 1.53% sched_balance_rq
                              - 1.20% sched_balance_find_src_group
                                   update_sd_lb_stats.constprop.0
                             0.56% pick_task_fair
                        - 1.65% dequeue_task_fair
                           - 1.48% dequeue_entities
                                0.60% update_curr
+    8.53%     0.11%  kthreadd         [kernel.kallsyms]            [k] __wait_rcu_gp
+    8.20%     0.12%  kthreadd         [kernel.kallsyms]            [k] __wait_for_common
+    8.18%     0.02%  kthreadd         [kernel.kallsyms]            [k] wait_for_completion_state
+    7.98%     0.54%  swapper          [kernel.kallsyms]            [k] sched_ttwu_pending
+    7.74%     0.27%  kthreadd         [kernel.kallsyms]            [k] schedule_timeout
+    7.47%     0.33%  kthreadd         [kernel.kallsyms]            [k] schedule
+    7.14%     1.28%  kthreadd         [kernel.kallsyms]            [k] __schedule
+    6.83%     0.14%  swapper          [kernel.kallsyms]            [k] ttwu_do_activate
+    6.50%     0.84%  swapper          [kernel.kallsyms]            [k] enqueue_task
+    6.38%     0.07%  swapper          [kernel.kallsyms]            [k] flush_smp_call_function_queue

synchronize_rcu_normal() consumes cycles mostly for doing __schedule().

4) sudo perf annotate rcu_sr_normal_add_req -k ./vmlinux

<snip>
Samples: 826  of event 'cycles', 2000 Hz, Event count (approx.): 399643217
rcu_sr_normal_add_req  ./vmlinux [Percent: local period]
Percent │    → callq    __fentry__
   0.25 │      movq     rcu_state+0x59ac8,%rax
  20.41 │ c:   movq     %rax,(%rdi)
   2.26 │      lock
        │      cmpxchgq %rdi,rcu_state+0x59ac8
  42.76 │    ↑ jne      c
        │      movl     $0x1,%eax
   0.57 │      lock
        │      xaddq    %rax,rcu_sr_normal_count
  24.38 │      addq     $0x1,%rax
   1.04 │      cmpq     $0x3f,%rax
        │    ↓ jle      41
        │      xorl     %eax,%eax
        │      movl     $0x1,%edx
        │      lock
        │      cmpxchgl %edx,rcu_sr_normal_latched
   8.34 │41: → jmp      __pi___x86_return_thunk
<snip>

This particular function consumed 399643217 cycles. In total for whole system
it is 521275605639 cycles: 

>>> 100 - (521275605639 - 399643217) * 100 / 521275605639
0.07666639541095321
>>>

so it is ~0.0 percent. 

<snip>
sudo perf report -k ./vmlinux
     0.02%     0.02%  kthreadd         [kernel.kallsyms]  [k] rcu_sr_normal_add_req
     0.00%     0.00%  vmalloc_test/14  [kernel.kallsyms]  [k] rcu_sr_normal_add_req
     0.00%     0.00%  vmalloc_test/28  [kernel.kallsyms]  [k] rcu_sr_normal_add_req
...
<snip>

i.e. if we simulate a high flood of incoming sync calls the system most
time spends on scheduling. The contention is a noise on my system.

Is that possible to get some data on your 2000 CPUs system? You can
provide perf.data or post results here.

Thank you!

--
Uladzislau Rezki
