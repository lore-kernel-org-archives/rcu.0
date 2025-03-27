Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939461A9B53;
	Thu, 27 Mar 2025 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045977; cv=none; b=hUist/5XqDONsybZ4swpaf8eZrGaT0cHYa8gVs9yyUu1ajNZaRR/zSynvBGrp/KlwtemuN0gEPynQQpdnljGwgiqfzTY8DKiytew75YBZmBGTm6jizLEB5WzNYmJ3OaQ17btd3JokEVJXOWhVpMbRkV3Ecrwimw330sRcF29vIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045977; c=relaxed/simple;
	bh=Ib8+Z9OgB8IOsZhg6pa6W4aQzm2HvGYN//JwgIA5mao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPUuCGhYS8Pvc+zxW9/+nAZK9Amf+qXDpnCXdb+mSa4geptmQfM7xglBeISBDd/u9LLxbEOvp+u1LzvQx9ptSNQchku8ezKnl8o37wye76ywT2FYphjWO7kzQByXnaSnWWCXFBDAtVH5eips8S6mEy5PMN9+R0Xl6JTn9Ix8nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmRxdJEW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmRxdJEW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso1008755a91.1;
        Wed, 26 Mar 2025 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743045974; x=1743650774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BLacVWaQ1JpvyxkIcHIVKqp6mGS3HA78ZGHUHBVtKgk=;
        b=gmRxdJEWR3xLkjxbZtQah57E2cVC1eJin/KpJ1x8g3vmx/RWIbQMKKOFnUj5bpn08s
         0P3oTDqcOS6WYeETQKws215FSRmfNK5Cv/n91Hlai1GNvg+KEhUQb5n5S0BN/MzKPOfr
         wVAKaDsCVNcteXdMqzIn9ElYudjK6gds5pAcjqW0DbstummUFABZeKoM8gCUpMRWs369
         nwJnHNNpIo2ZQ/rRmRl3V07a38WLP/tffe6a6SKYIhidaVj2ctQwYEmjYMOFQNk+gKol
         udRWf4AnDTJ5Rv2Dd3OQRcambI4joiUY6Mt3dDl4VOl6FpekBiNpQLm6wwvpWmcymYdV
         o7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743045974; x=1743650774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLacVWaQ1JpvyxkIcHIVKqp6mGS3HA78ZGHUHBVtKgk=;
        b=JZPNE+XcucK1xfGqirhY0UU4HJcipL82YDvVfUjMi6TcXwLwrJ5eCmFYSKU47lQ3Hw
         MJh/kf8ZXlDMPKtOxkxH6OI94zDrsEAZ8PPlisR/xlbmv2GPuK/+PMdkpIK6b28IrNM6
         2ePTi4i6Zpcjv7qBJWfj/vrXcD0EWn/WqM1J44Jj/KXEzIsyxWPeOBGTj7tRmHb+A4fA
         BbqLGSKOxgQh/OnDbXV7sVngYWc27M0r7/bNUvm94SinFO9J+2rqrfq1xLQ8Q4ruZJUF
         ciuPRraZwGenfS04Tn69X0+UoZoRATFoflyjWSZ6q/2jKpGfo2bUhFj3FzGGonfbvqUb
         oo4g==
X-Forwarded-Encrypted: i=1; AJvYcCXxxRZlTnwiSYRozoSTIdmcncWovU+/rADiJJ9o+xLoSYN/NoBada7hDQWIIVfMsk/Dsq2ZHR5kW5RjFE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jkC/fcPd3/69YmY5DixJelfvc8ip/ecEuxDE9mw8fe6Qo+T7
	xeTqK0Kc5VnlyTYlUFg/HrBaftXjn82rhhC+ugKxvwr2HZ+rnNPfv4Pn3DCCVzRiuCDDdLRcQ7L
	oYPjlfyrEDajwO9b2u6bdFoMWbrA=
X-Gm-Gg: ASbGnctu/UW3B7qDwfK++D9QL/5CFYOnvelqN8GhZ/iwxrceh/jshdmBHFO8lZ1CGgN
	1t/m4kkBNRQp1YajU6l3kZShJNzbSGprfY39Bd6veJNvGTY0fy5q3w1R+E2hHAZwcz2g27vLxrj
	C0h4+YUgXiQMkuCneXaBBZVnjGfyE=
X-Google-Smtp-Source: AGHT+IFa8/TZos0mLVoWhgudnfW4RiQNcoMvEBK34ADwpmd8Z7C8v0gDkE5UXTV8HMbG3IVDhrBqOSJhd/hDCphkvt4=
X-Received: by 2002:a17:90b:1d49:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30378956f56mr9665926a91.12.1743045973515; Wed, 26 Mar 2025
 20:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop> <20250310183809.3576320-5-paulmck@kernel.org>
In-Reply-To: <20250310183809.3576320-5-paulmck@kernel.org>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 27 Mar 2025 11:26:01 +0800
X-Gm-Features: AQ5f1JpgFOCoFXrtkdxOM-oI3AQwpyhZ8CojUpSBS3TMfDOmDrqn2KeWqfTgkmI
Message-ID: <CALm+0cWn_wh_QnR0k-QDVTwgdBdXTEd1Xtk5SM+T27ejCchPJw@mail.gmail.com>
Subject: Re: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader primitives
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"

>
> This commit adds a new rcutorture.n_up_down kernel boot parameter
> that specifies the number of outstanding SRCU up/down readers, which
> begin in kthread context and end in an hrtimer handler.  There is a new
> kthread ("rcu_torture_updown") that scans an per-reader array looking
> for elements whose readers have ended.  This kthread sleeps between one
> and two milliseconds between consecutive scans.
>
> [ paulmck: Apply kernel test robot feedback. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/rcutorture.c | 227 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 208 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index b0e96df636226..6afcd33e724ba 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -55,22 +55,24 @@ MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
>
> -/* Bits for ->extendables field, extendables param, and related definitions. */
> -#define RCUTORTURE_RDR_SHIFT_1  8      /* Put SRCU index in upper bits. */
> -#define RCUTORTURE_RDR_MASK_1   (0xff << RCUTORTURE_RDR_SHIFT_1)
> -#define RCUTORTURE_RDR_SHIFT_2  16     /* Put SRCU index in upper bits. */
> -#define RCUTORTURE_RDR_MASK_2   (0xff << RCUTORTURE_RDR_SHIFT_2)
> -#define RCUTORTURE_RDR_BH       0x01   /* Extend readers by disabling bh. */
> -#define RCUTORTURE_RDR_IRQ      0x02   /*  ... disabling interrupts. */
> -#define RCUTORTURE_RDR_PREEMPT  0x04   /*  ... disabling preemption. */
> -#define RCUTORTURE_RDR_RBH      0x08   /*  ... rcu_read_lock_bh(). */
> -#define RCUTORTURE_RDR_SCHED    0x10   /*  ... rcu_read_lock_sched(). */
> -#define RCUTORTURE_RDR_RCU_1    0x20   /*  ... entering another RCU reader. */
> -#define RCUTORTURE_RDR_RCU_2    0x40   /*  ... entering another RCU reader. */
> -#define RCUTORTURE_RDR_NBITS    7      /* Number of bits defined above. */
> -#define RCUTORTURE_MAX_EXTEND   \
> +// Bits for ->extendables field, extendables param, and related definitions.
> +#define RCUTORTURE_RDR_SHIFT_1 8       // Put SRCU index in upper bits.
> +#define RCUTORTURE_RDR_MASK_1  (0xff << RCUTORTURE_RDR_SHIFT_1)
> +#define RCUTORTURE_RDR_SHIFT_2 16      // Put SRCU index in upper bits.
> +#define RCUTORTURE_RDR_MASK_2  (0xff << RCUTORTURE_RDR_SHIFT_2)
> +#define RCUTORTURE_RDR_BH      0x01    // Extend readers by disabling bh.
> +#define RCUTORTURE_RDR_IRQ     0x02    //  ... disabling interrupts.
> +#define RCUTORTURE_RDR_PREEMPT 0x04    //  ... disabling preemption.
> +#define RCUTORTURE_RDR_RBH     0x08    //  ... rcu_read_lock_bh().
> +#define RCUTORTURE_RDR_SCHED   0x10    //  ... rcu_read_lock_sched().
> +#define RCUTORTURE_RDR_RCU_1   0x20    //  ... entering another RCU reader.
> +#define RCUTORTURE_RDR_RCU_2   0x40    //  ... entering another RCU reader.
> +#define RCUTORTURE_RDR_UPDOWN  0x80    //  ... up-read from task, down-read from timer.
> +                                       //      Note: Manual start, automatic end.
> +#define RCUTORTURE_RDR_NBITS   8       // Number of bits defined above.
> +#define RCUTORTURE_MAX_EXTEND  \
>         (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
> -        RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
> +        RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)  // Intentionally omit RCUTORTURE_RDR_UPDOWN.
>  #define RCUTORTURE_RDR_ALLBITS \
>         (RCUTORTURE_MAX_EXTEND | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2 | \
>          RCUTORTURE_RDR_MASK_1 | RCUTORTURE_RDR_MASK_2)
> @@ -110,6 +112,7 @@ torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
>  torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
>  torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
>  torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
> +torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
>  torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
>  torture_param(int, nreaders, -1, "Number of RCU reader threads");
>  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> @@ -152,6 +155,7 @@ static int nrealfakewriters;
>  static struct task_struct *writer_task;
>  static struct task_struct **fakewriter_tasks;
>  static struct task_struct **reader_tasks;
> +static struct task_struct *updown_task;
>  static struct task_struct **nocb_tasks;
>  static struct task_struct *stats_task;
>  static struct task_struct *fqs_task;
> @@ -374,6 +378,8 @@ struct rcu_torture_ops {
>         void (*readunlock)(int idx);
>         int (*readlock_held)(void);   // lockdep.
>         int (*readlock_nesting)(void); // actual nesting, if available, -1 if not.
> +       int (*down_read)(void);
> +       void (*up_read)(int idx);
>         unsigned long (*get_gp_seq)(void);
>         unsigned long (*gp_diff)(unsigned long new, unsigned long old);
>         void (*deferred_free)(struct rcu_torture *p);
> @@ -421,6 +427,7 @@ struct rcu_torture_ops {
>         int no_pi_lock;
>         int debug_objects;
>         int start_poll_irqsoff;
> +       int have_up_down;
>         const char *name;
>  };
>
> @@ -754,6 +761,50 @@ static int torture_srcu_read_lock_held(void)
>         return srcu_read_lock_held(srcu_ctlp);
>  }
>
> +static bool srcu_torture_have_up_down(void)
> +{
> +       int rf = reader_flavor;
> +
> +       if (!rf)
> +               rf = SRCU_READ_FLAVOR_NORMAL;
> +       return !!(cur_ops->have_up_down & rf);
> +}
> +
> +static int srcu_torture_down_read(void)
> +{
> +       int idx;
> +       struct srcu_ctr __percpu *scp;
> +
> +       WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
> +       WARN_ON_ONCE(reader_flavor & (reader_flavor - 1));
> +
> +       if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
> +               idx = srcu_down_read(srcu_ctlp);
> +               WARN_ON_ONCE(idx & ~0x1);
> +               return idx;
> +       }
> +       if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
> +               scp = srcu_down_read_fast(srcu_ctlp);
> +               idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
> +               WARN_ON_ONCE(idx & ~0x1);
> +               return idx << 3;
> +       }
> +       WARN_ON_ONCE(1);
> +       return 0;
> +}
> +
> +static void srcu_torture_up_read(int idx)
> +{
> +       WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
> +       if (reader_flavor & SRCU_READ_FLAVOR_FAST)
> +               srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
> +       else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
> +                !(reader_flavor & SRCU_READ_FLAVOR_ALL))
> +               srcu_up_read(srcu_ctlp, idx & 0x1);
> +       else
> +               WARN_ON_ONCE(1);
> +}
> +
>  static unsigned long srcu_torture_completed(void)
>  {
>         return srcu_batches_completed(srcu_ctlp);
> @@ -811,6 +862,8 @@ static struct rcu_torture_ops srcu_ops = {
>         .readlock       = srcu_torture_read_lock,
>         .read_delay     = srcu_read_delay,
>         .readunlock     = srcu_torture_read_unlock,
> +       .down_read      = srcu_torture_down_read,
> +       .up_read        = srcu_torture_up_read,
>         .readlock_held  = torture_srcu_read_lock_held,
>         .get_gp_seq     = srcu_torture_completed,
>         .gp_diff        = rcu_seq_diff,
> @@ -831,6 +884,8 @@ static struct rcu_torture_ops srcu_ops = {
>         .irq_capable    = 1,
>         .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
>         .debug_objects  = 1,
> +       .have_up_down   = IS_ENABLED(CONFIG_TINY_SRCU)
> +                               ? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
>         .name           = "srcu"
>  };
>
> @@ -856,6 +911,8 @@ static struct rcu_torture_ops srcud_ops = {
>         .read_delay     = srcu_read_delay,
>         .readunlock     = srcu_torture_read_unlock,
>         .readlock_held  = torture_srcu_read_lock_held,
> +       .down_read      = srcu_torture_down_read,
> +       .up_read        = srcu_torture_up_read,
>         .get_gp_seq     = srcu_torture_completed,
>         .gp_diff        = rcu_seq_diff,
>         .deferred_free  = srcu_torture_deferred_free,
> @@ -875,6 +932,8 @@ static struct rcu_torture_ops srcud_ops = {
>         .irq_capable    = 1,
>         .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
>         .debug_objects  = 1,
> +       .have_up_down   = IS_ENABLED(CONFIG_TINY_SRCU)
> +                               ? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
>         .name           = "srcud"
>  };
>
> @@ -1985,7 +2044,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
>
>         first = idxold1 == 0;
>         WARN_ON_ONCE(idxold2 < 0);
> -       WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
> +       WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
>         rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
>         rtrsp->rt_readstate = newstate;
>
> @@ -2061,6 +2120,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
>                 if (lockit)
>                         raw_spin_unlock_irqrestore(&current->pi_lock, flags);
>         }
> +       if (statesold & RCUTORTURE_RDR_UPDOWN) {
> +               cur_ops->up_read((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
> +               WARN_ON_ONCE(idxnew1 != -1);
> +               idxold1 = 0;
> +       }
>
>         /* Delay if neither beginning nor end and there was a change. */
>         if ((statesnew || statesold) && *readstate && newstate)
> @@ -2201,7 +2265,8 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
>         rtorsp->started = cur_ops->get_gp_seq();
>         rtorsp->ts = rcu_trace_clock_local();
>         rtorsp->p = rcu_dereference_check(rcu_torture_current,
> -                                 !cur_ops->readlock_held || cur_ops->readlock_held());
> +                                         !cur_ops->readlock_held || cur_ops->readlock_held() ||
> +                                         (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
>         if (rtorsp->p == NULL) {
>                 /* Wait for rcu_torture_writer to get underway */
>                 rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
> @@ -2370,6 +2435,123 @@ rcu_torture_reader(void *arg)
>         return 0;
>  }
>
> +struct rcu_torture_one_read_state_updown {
> +       struct hrtimer rtorsu_hrt;
> +       bool rtorsu_inuse;
> +       struct torture_random_state rtorsu_trs;
> +       struct rcu_torture_one_read_state rtorsu_rtors;
> +};
> +
> +static struct rcu_torture_one_read_state_updown *updownreaders;
> +static DEFINE_TORTURE_RANDOM(rcu_torture_updown_rand);
> +static int rcu_torture_updown(void *arg);
> +
> +static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
> +{
> +       struct rcu_torture_one_read_state_updown *rtorsup;
> +
> +       rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
> +       rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> +       smp_store_release(&rtorsup->rtorsu_inuse, false);
> +       return HRTIMER_NORESTART;
> +}
> +
> +static int rcu_torture_updown_init(void)
> +{
> +       int i;
> +       struct torture_random_state *rand = &rcu_torture_updown_rand;
> +       int ret;
> +
> +       if (n_up_down < 0)
> +               return 0;
> +       if (!srcu_torture_have_up_down()) {
> +               VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Disabling up/down reader tests due to lack of primitives");
> +               return 0;
> +       }
> +       updownreaders = kcalloc(n_up_down, sizeof(*updownreaders), GFP_KERNEL);
> +       if (!updownreaders) {
> +               VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Out of memory, disabling up/down reader tests");
> +               return -ENOMEM;
> +       }
> +       for (i = 0; i < n_up_down; i++) {
> +               init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> +               hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> +                            HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> +               updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
> +               torture_random_init(&updownreaders[i].rtorsu_trs);
> +               init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
> +                                               &updownreaders[i].rtorsu_trs);
> +       }
> +       ret = torture_create_kthread(rcu_torture_updown, rand, updown_task);
> +       if (ret) {
> +               kfree(updownreaders);
> +               updownreaders = NULL;
> +       }
> +       return ret;
> +}
> +
> +static void rcu_torture_updown_cleanup(void)
> +{
> +       struct rcu_torture_one_read_state_updown *rtorsup;
> +
> +       for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
> +               if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
> +                       continue;
> +               (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
> +               WARN_ON_ONCE(rtorsup->rtorsu_inuse);

Hello, Paul

When I rmmod rcutorture, the following warning is triggered:

   [  809.227012] WARNING: CPU: 7 PID: 662 at
kernel/rcu/rcutorture.c:2506 rcu_torture_updown+0x3ff/0x620
[rcutorture]
    [  809.227038] Modules linked in: rcutorture(-) torture [last
unloaded: rcutorture]
    [  809.227052] CPU: 7 UID: 0 PID: 662 Comm: rcu_torture_upd Not
tainted 6.14.0-rc1-yoctodev-standard+ #103
f927b67579e64efac707898e59c492a894becb07
    [  809.227057] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [  809.227061] RIP: 0010:rcu_torture_updown+0x3ff/0x620 [rcutorture]
    [  809.227112] Call Trace:
    [  809.227114]  <TASK>
    [  809.227118]  ? show_regs+0x65/0x70
    [  809.227127]  ? __warn+0xd5/0x310
    [  809.227137]  ? rcu_torture_updown+0x3ff/0x620 [rcutorture
1eb1c0a0090f471c5e98b34f024c9030cef829ed]
    [  809.227155]  ? report_bug+0x23e/0x490
    [  809.227172]  ? handle_bug+0x5b/0xa0
    [  809.227180]  ? exc_invalid_op+0x1c/0x50
    [  809.227188]  ? asm_exc_invalid_op+0x1f/0x30
    [  809.227210]  ? hrtimer_try_to_cancel+0x160/0x490
    [  809.227216]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
    [  809.227225]  ? rcu_torture_updown+0x3ff/0x620 [rcutorture
1eb1c0a0090f471c5e98b34f024c9030cef829ed]
    [  809.227255]  ? rcu_torture_updown+0x340/0x620 [rcutorture
1eb1c0a0090f471c5e98b34f024c9030cef829ed]
    [  809.227320]  ? __pfx_rcu_torture_updown+0x10/0x10 [rcutorture
1eb1c0a0090f471c5e98b34f024c9030cef829ed]
    [  809.227337]  kthread+0x3d9/0x810
    [  809.227349]  ? __pfx_kthread+0x10/0x10
    [  809.227357]  ? rt_spin_unlock+0x4c/0x90
    [  809.227362]  ? rt_spin_unlock+0x4c/0x90
    [  809.227367]  ? calculate_sigpending+0x88/0xa0
    [  809.227372]  ? __pfx_kthread+0x10/0x10
    [  809.227380]  ret_from_fork+0x40/0x70
    [  809.227383]  ? __pfx_kthread+0x10/0x10
    [  809.227390]  ret_from_fork_asm+0x1a/0x30
    [  809.227420]  </TASK>

If rtorsu_hrt timer is still in timer_queue, invoke hrtimer_cancel() will
remove it from timerqueue and directly return, so the rcu_torture_updown_hrt()
will not be executed and the rtorsup->rtorsu_inuse cannot be set false.

How about modifying it as follows:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 04d7a2173b95..ecf3d3797f7e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
        for (rtorsup = updownreaders; rtorsup <
&updownreaders[n_up_down]; rtorsup++) {
                if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
                        continue;
-               (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
-               if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+               if (hrtimer_cancel(&rtorsup->rtorsu_hrt) ||
WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {

rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs,
-1);
                        WARN_ONCE(rtorsup->rtorsu_nups >=
rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n",
__func__, rtorsup - updownreaders);
                        rtorsup->rtorsu_nups++;


Thanks
Zqiang

> +
> +       }
> +       kfree(updownreaders);
> +       updownreaders = NULL;
> +}
> +
> +/*
> + * RCU torture up/down reader kthread, starting RCU readers in kthread
> + * context and ending them in hrtimer handlers.  Otherwise similar to
> + * rcu_torture_reader().
> + */
> +static int
> +rcu_torture_updown(void *arg)
> +{
> +       int idx;
> +       int rawidx;
> +       struct rcu_torture_one_read_state_updown *rtorsup;
> +       ktime_t t;
> +
> +       VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
> +       do {
> +               for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
> +                       if (torture_must_stop())
> +                               break;
> +                       if (smp_load_acquire(&rtorsup->rtorsu_inuse))
> +                               continue;
> +                       init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
> +                                                       &rtorsup->rtorsu_trs);
> +                       rawidx = cur_ops->down_read();
> +                       idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
> +                       rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
> +                       rtorsup->rtorsu_rtors.rtrsp++;
> +                       if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
> +                                                       &rtorsup->rtorsu_trs, -1)) {
> +                               cur_ops->up_read(rawidx);
> +                               schedule_timeout_idle(HZ);
> +                               continue;
> +                       }
> +                       smp_store_release(&rtorsup->rtorsu_inuse, true);
> +                       t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
> +                       if (t < 10 * 1000)
> +                               t = 200 * 1000 * 1000;
> +                       hrtimer_start(&rtorsup->rtorsu_hrt, t,
> +                                     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> +               }
> +               torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
> +               stutter_wait("rcu_torture_updown");
> +       } while (!torture_must_stop());
> +       rcu_torture_updown_cleanup();
> +       torture_kthread_stopping("rcu_torture_updown");
> +       return 0;
> +}
> +
>  /*
>   * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
>   * increase race probabilities and fuzzes the interval between toggling.
> @@ -2620,7 +2802,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
>                  "reader_flavor=%x "
>                  "nocbs_nthreads=%d nocbs_toggle=%d "
>                  "test_nmis=%d "
> -                "preempt_duration=%d preempt_interval=%d\n",
> +                "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
>                  torture_type, tag, nrealreaders, nrealfakewriters,
>                  stat_interval, verbose, test_no_idle_hz, shuffle_interval,
>                  stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
> @@ -2634,7 +2816,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
>                  reader_flavor,
>                  nocbs_nthreads, nocbs_toggle,
>                  test_nmis,
> -                preempt_duration, preempt_interval);
> +                preempt_duration, preempt_interval, n_up_down);
>  }
>
>  static int rcutorture_booster_cleanup(unsigned int cpu)
> @@ -3686,6 +3868,10 @@ rcu_torture_cleanup(void)
>                 nocb_tasks = NULL;
>         }
>
> +       if (updown_task) {
> +               torture_stop_kthread(rcu_torture_updown, updown_task);
> +               updown_task = NULL;
> +       }
>         if (reader_tasks) {
>                 for (i = 0; i < nrealreaders; i++)
>                         torture_stop_kthread(rcu_torture_reader,
> @@ -4216,6 +4402,9 @@ rcu_torture_init(void)
>                 if (torture_init_error(firsterr))
>                         goto unwind;
>         }
> +       firsterr = rcu_torture_updown_init();
> +       if (torture_init_error(firsterr))
> +               goto unwind;
>         nrealnocbers = nocbs_nthreads;
>         if (WARN_ON(nrealnocbers < 0))
>                 nrealnocbers = 1;
> --
> 2.40.1
>
>
