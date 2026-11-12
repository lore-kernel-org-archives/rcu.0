Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501842;
	b=M6R25LAmlEZOft0RZG8g8dOeM2kFaiQZvbWFOanFjkdshVMNmxh+kVLAIP70wNH2zd94
	 Qfkq7kxwb+woE3M+k6kSbn5QlzA4j1uDZtJ0pWhS1n5uXglbvhaTy/YiUijlMw+vIC8iB
	 PTOQJFI2YnyBjIdG9mMs525l9YiNTM3xA/4UlFqdDhP8XwIlgG5HqsLfBBK2n066MJsS/
	 J+nLrZbnlaBR7WWNnc2urSZ9poJSpaPGgqfhctnPXD1gh67mACFsBp8w2vu+adH1CQGZK
	 KSErxOw5DifrepJkJgimX+E/CaQPk5vHD2Hz4iXLvvT5/2JEORyZStr1LWAMh9GSizw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EHqmabhQs9oMlIk3zKyReuhcqEApxPsb2fVvo4vnwHE=;
	b=E0Yb00NDaWXS+Rq/g84sqh4P7bPOVxYYlZTUtuS+3brYsCkeV+BnINdzAWQfJu0/1UlL
	 ctK6VQCNDu/qP+/gS30wDGoSIIpKTSGnZfcCEZLn9OWzzQ9aABX8aZRiM+haVfWC8pffc
	 n65g81gedF+hi+uzFqnM3UDCTuJOzWvmePy6jVBVvHxOInKxirdj6Z79ETD1SvZQ0tBm2
	 gv/0eaZSnnCjpex6lIh5nS6F+Nol0rEzmWDm13Ovh5SDoTmtP+Ev4w7pG8mdMhHS/0Dnq
	 oBuQooh37Btf2E/p//V+MhoGCIsr4Qinh1ctTriJ/K4H0y9j5q5QcfbO9BlJMg3J85g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cKJr+r0d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF50606A332
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF50606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cKJr+r0d
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b467581b98so127675e9.0
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501840; cv=none;
        d=google.com; s=arc-20260327;
        b=HliXEwNs+83L0jhrKv76PQ2JRnGt/Ge6OBvi+4t/jTHJaGimuQ+npAEkj60VI4I4Ig
         1LKX/7zLVCPiPDtqpAdOG+UO5UNZtvFw9ACydtaas75rByJDV12JkMi+FO6hPY+2Jwfc
         GmMr2ZUhHRkyJDEyzZDcNXX9tofJqgt2cASbQlay0mp8MXVtYWfw/lMN07vCszgA52pM
         gefnEfvmzeMK2Wh4nCiVJBrX2Nb/3kM4Ec1hhlGLC9zcglaPmRhCyE7xj+wOFDGZ+XLR
         s8rmOHRQIYPF7z2dryBw3qyeCwANHt9mutboDJz8tdyZOZ38gW2WCvYR/XKiNnFQ+r7M
         h5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHqmabhQs9oMlIk3zKyReuhcqEApxPsb2fVvo4vnwHE=;
        fh=mKQgS4wJciCLiDJu9zNk61Nmr9tukeiJwt0grOmFUpU=;
        b=URH2tIED2cosjxmZDhKFgwnz0YoAQ+8D/+2T0csLtUSZBnapNhBFRMSK5YEVev/YLu
         34tV/+4CZIzipoq4OtnN2UZlO0zos2OxiGkBZ/svtfEsm1cBtEeub3oB/55xLEYUBQKS
         cjOcKiRg1pC+N+jjbqbDLYSq0LXsgzYy12Xwk3/pSKq8BM3tuTuLuI14Sl4ApFypd/c3
         5MHVfqJuRitxFLzBzVJxNfYM1wmeZXGWNUq7Q2Eg6PPqfa57r0cXFY9H+dyyB7C+uX1o
         xckJjdgcSdORqpkIRm/Cl4CyWq68bp22l8F5NUa2n+Awc3987UsoLc94aaoNmjHEYN/K
         ZQ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501840; x=1795106640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EHqmabhQs9oMlIk3zKyReuhcqEApxPsb2fVvo4vnwHE=;
        b=cKJr+r0dprmlg9i6YK5FE8gB8AlXM4Gsd9JiwTMFnenWkb6EduWtrRN9J7CxI9pIau
         SsloDx8w5JafbWxxGPXVj/rwNEJYn1jBmEVA2E/3QWPkyQGR9g3APXqy/9lE6mWrdiz4
         NcCNQSTT27DA0XfWZfqK+5u3b0UFCcTN66+jCVj6lQIV8G/SlswOzUpT8k5e3tYboXk1
         Nx3V1Bon7qIxBdM0th5Jmytze0UTVA8iICqw91MO8lqzT79pgFjRDrsYjldcTKeixDPe
         4kiSumxE9NxPQv4TZAoAOLVWZMIx3famt7u4RNHrQLV7Y3/pdjBrNAQL3SAsT/8W2lM/
         Hxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501840; x=1795106640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHqmabhQs9oMlIk3zKyReuhcqEApxPsb2fVvo4vnwHE=;
        b=ha0f9S+asHedxiykfJVhU8cvUkbbAiEMLZ7s4poSGw98TpbnrgKaXtBKpcLV4I7zwk
         SWijqz3/MyJnB32DoLfWRtYVw77wVI61ECiC78sRYLnJER++W9/5SG3+7qxK5dOIwBvl
         fsoxHRyDxjKfvkPUNowyxl2Hn2fXqMu56dxVXZ3U8e8QjEfQkklTxDm9rxVEdcUz+xOG
         lzsABcKDAcYAadxqnHz/K3Ql4CdVkgQVGxq2tM2U40rFGIzM3I4Fzuq4fuFRWBDTbyk1
         G471BbXL2I/XMUbakC0ECn/D5bTDSJu9vR5+iGG6bPJR0AinpSuBeATCm6v5nNpBvakj
         meZA==
X-Forwarded-Encrypted: i=1; AL+hErHMetEHqFcZuJEwW8zmwe1b7ZTuFmlfSXVsd5OGslJrlL2lCifYkoAQ9rNjoXGa2UGGCmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z81J42N+jEToHSxIUxkykYvFeZUKrwPzWfUrMBedzFIXfUvV1ap
	sVGHwcWq0p366nsYGkKJBdK9l8cTZX2mF+ze1mwAn16tbfcQTjdAiHpVHjLNz5ojzuCwOJxFWbJ
	Mr5d/dzukumrrc+wGLeZd+uFaMLgSHew=
X-Gm-Gg: AYBFou1jckD4flWTLYhgjEh9F/15YmFGomPuhollo+CNvRYRIoL8pTy+9YSFSoItB/2
	CqnYBP5YRGExHsaIfSEiyPs8gtEc55CSaYHisIdyRKK44/RXr5n0Bz2bT9e69CmbCWYeHFW3kog
	E2u/sKZ+ZV5RnEdknc1Q1BzurdLCFs43+j85IaGlQrQ7FZGclZuoenvMx8KStPD9YNnlX9Uqvsk
	LRX7hzyx51L/6aRgAOp6kUZi+Bo0CgGmhR4YhmXK+SXJxhqe23saCeMG9lq9fOvlZbHC8YETNvA
	ap88qMSlOfeoRoRC9cSpT7dbUMjTdll6FZYVnxP3irAG4L+SwZbO0cH/yD91QN+Y4QoXpBWgsK7
	bP2NxSVLxO5izcX+EKI7DKNKxMcjXnzTuTHZRlCwWIIyqZ63rFp4STLNXw9WE9RmQE3Va+1ggxx
	2rRCGl786N8FrcEnY=
X-Received: by 2002:a05:600c:1d18:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4ba093a2dafmr117470935e9.24.1794501839620; Thu, 12 Nov 2026
 08:43:59 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-22-kunwu.chan@gmail.com> <7b19da25-076a-439d-b365-5e881f0f7d84@paulmck-laptop>
In-Reply-To: <7b19da25-076a-439d-b365-5e881f0f7d84@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:43:46 +0800
X-Gm-Features: AclHuK-I8xUDHW1FTpTgk3U8yBb2pVVDtdbHngNsH5VjrqGi350vH23HFXUiQps
Message-ID: <CAN_Opa--SuR-pXLL3gNuY=ntbGrgsv2bw6VvgfvfyUv3AGsExw@mail.gmail.com>
Subject: Re: [PATCH 21/28] hazptrtorture: Add HOTADDR and LONGHOLD scenarios
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:53=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:39AM +0800, Kunwu Chan wrote:
> > HOTADDR: stages the sticky-address forward-progress scenario.
> > LONGHOLD: validates legitimate long-held references.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Continuing on the register_trace_*() point, one approach would be to make
> the module parameters needing this to be under "#ifdef CONFIG_TRACING"
> and provide no-op functions as needed.
>

That makes sense. I'll put the HOTADDR/LONGHOLD parameters and
tracepoint-dependent support under CONFIG_TRACING, with no-op
stubs where the common init and cleanup paths need them.

The remaining hazptrtorture scenarios will then remain available
with tracing disabled.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/hazptrtorture.c                    | 384 +++++++++++++++++-
> >  .../rcutorture/configs/hazptr/CFLIST          |   2 +
> >  .../rcutorture/configs/hazptr/HOTADDR         |  18 +
> >  .../rcutorture/configs/hazptr/HOTADDR.boot    |   1 +
> >  .../rcutorture/configs/hazptr/LONGHOLD        |  18 +
> >  .../rcutorture/configs/hazptr/LONGHOLD.boot   |   1 +
> >  6 files changed, 419 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/H=
OTADDR
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/H=
OTADDR.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/L=
ONGHOLD
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/L=
ONGHOLD.boot
> >
> > diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> > index fe09280d063c..5dbe04af7515 100644
> > --- a/kernel/rcu/hazptrtorture.c
> > +++ b/kernel/rcu/hazptrtorture.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/hazptr.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/workqueue.h>
> > +#include <trace/events/hazptr.h>
> >
> >  #include "rcu.h"
> >
> > @@ -54,6 +55,15 @@ torture_param(int, stutter, 5, "Number of seconds to=
 run/halt test");
> >  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
> >  torture_param(bool, wq_churn, false,
> >             "Churn workqueues to exercise lockdep dynamic keys");
> > +torture_param(int, nhotreaders, 0,
> > +           "Hot-addr hammer readers, 0 disables Lai-scenario");
> > +torture_param(int, hot_hold_us, 20000,
> > +           "Hammer reader hold (us)");
> > +torture_param(int, hot_hammer_ms, 3000, "Hammer window (ms)");
> > +torture_param(int, hot_longhold_ms, 0,
> > +           "Long-hold round duration (ms), 0 disables; R0 holds past t=
he stall timeout, no hammer");
> > +torture_param(bool, starve_expected, false,
> > +           "Starvation episodes are expected (documenting mode)");
> >
> >  static char *torture_type =3D "hazptr";
> >  module_param(torture_type, charp, 0444);
> > @@ -66,6 +76,22 @@ static struct task_struct **reader_tasks;
> >  static struct task_struct *do_pending_task;
> >  static struct task_struct *stats_task;
> >  static struct task_struct *wq_churn_task;
> > +static struct task_struct *hot_stage_task;
> > +static struct task_struct *hot_r0_task;
> > +static struct task_struct **hot_reader_tasks;
> > +static int hot_target_storage;
> > +static void *hot_addr =3D &hot_target_storage;
> > +static atomic_t n_hot_syncs;
> > +static atomic_t n_hot_starves;
> > +static atomic_t n_hot_in_seq;
> > +static atomic_t hot_live_syncs;              /* transient sync kthread=
s alive */
> > +static atomic_t hot_hammer_holding;  /* hammer readers currently holdi=
ng */
> > +static atomic_t hot_r0_gate;         /* 1: R0 may acquire for this rou=
nd */
> > +static DECLARE_COMPLETION(hot_enqueued);
> > +static DECLARE_COMPLETION(hot_sync_done);
> > +static DECLARE_COMPLETION(r0_held);
> > +static DECLARE_COMPLETION(r0_release);
> > +static bool hot_hammer_active;
> >
> >  #define HAZPTR_TORTURE_PIPE_LEN 10
> >
> > @@ -87,13 +113,13 @@ static atomic_t n_hazptr_torture_alloc;
> >  static atomic_t n_hazptr_torture_alloc_fail;
> >  static atomic_t n_hazptr_torture_free;
> >  static atomic_t n_hazptr_torture_error;
> > -static atomic_t n_hazptr_torture_wq_churn;
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_irq);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_defer);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_undefer);
> > +static atomic_t n_hazptr_torture_wq_churn;
> >  static struct list_head hazptr_torture_removed;
> >
> >  // State for a deferred (AKA pending) hazard pointer
> > @@ -681,6 +707,10 @@ hazptr_torture_stats_print(void)
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_releases_def=
er),
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_releases_und=
efer),
> >               atomic_read(&n_hazptr_torture_wq_churn));
> > +     pr_cont(" hotsync: %d hotstarve: %d hotseq: %d",
> > +             atomic_read(&n_hot_syncs),
> > +             atomic_read(&n_hot_starves),
> > +             atomic_read(&n_hot_in_seq));
> >
> >       pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> >       if (i > 1) {
> > @@ -752,7 +782,8 @@ hazptr_torture_print_module_parms(struct hazptr_tor=
ture_ops *cur_ops, const char
> >                "nest_acquire=3D%d "
> >                "onoff_interval=3D%d onoff_holdoff=3D%d "
> >                "preempt_duration=3D%d preempt_interval=3D%d "
> > -              "reader_sleep_us=3D%d "
> > +              "reader_sleep_us=3D%d wq_churn=3D%d "
> > +              "nhotreaders=3D%d hot_hold_us=3D%d hot_hammer_ms=3D%d "
> >                "shuffle_interval=3D%d shutdown_secs=3D%d stat_interval=
=3D%d stutter=3D%d "
> >                "verbose=3D%d\n",
> >                torture_type, tag, nrealreaders, nwriters,
> > @@ -760,7 +791,8 @@ hazptr_torture_print_module_parms(struct hazptr_tor=
ture_ops *cur_ops, const char
> >                nest_acquire,
> >                onoff_interval, onoff_holdoff,
> >                preempt_duration, preempt_interval,
> > -              reader_sleep_us,
> > +              reader_sleep_us, wq_churn,
> > +              nhotreaders, hot_hold_us, hot_hammer_ms,
> >                shuffle_interval, shutdown_secs, stat_interval, stutter,
> >                verbose);
> >  }
> > @@ -801,10 +833,14 @@ static void hazptr_torture_wq_churn_fn(struct wor=
k_struct *work)
> >  /*
> >   * Repeatedly create and destroy workqueues.  Each workqueue creation
> >   * registers a lockdep dynamic key and each destruction unregisters it=
,
> > - * which exercises both is_dynamic_key() and lockdep_unregister_key().
> > + * which exercises both is_dynamic_key() and lockdep_unregister_key(),
> > + * the two lockdep paths that use hazptr.  Most useful in kernels with
> > + * CONFIG_PROVE_LOCKING=3Dy and CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=
=3Dy.
> >   */
> >  static int hazptr_torture_wq_churn(void *unused)
> >  {
> > +     DEFINE_TORTURE_RANDOM(rand);
> > +
> >       VERBOSE_TOROUT_STRING("hazptr_torture_wq_churn task started");
> >       do {
> >               struct workqueue_struct *wq;
> > @@ -812,7 +848,7 @@ static int hazptr_torture_wq_churn(void *unused)
> >
> >               wq =3D alloc_workqueue("hazptr-torture-churn", WQ_PERCPU,=
 1);
> >               if (!wq) {
> > -                     torture_hrtimeout_ms(10, 10, NULL);
> > +                     torture_hrtimeout_ms(10, 10, &rand);
> >                       continue;
> >               }
> >               INIT_WORK(&churn_work, hazptr_torture_wq_churn_fn);
> > @@ -826,6 +862,271 @@ static int hazptr_torture_wq_churn(void *unused)
> >       return 0;
> >  }
> >
> > +/*
> > + * Hot-addr staged scenario --- Lai's forward-progress test.
> > + *
> > + * Three persistent kthreads plus a per-round transient sync kthread:
> > + *   hot_r0_task      old reader: acquires hot_addr, signals, waits
> > + *                    for release command, then releases.
> > + *   hot_reader_tasks hammer readers: tight acquire/release loops on
> > + *                    hot_addr, long hold, near-zero gap, no stutter,
> > + *                    kthread_bind'd to distinct CPUs.
> > + *   hot_stage_task   orchestrator: drives the staged sequence round
> > + *                    by round, recording starvation episodes.
> > + *   hot_do_sync      transient per-round: hazptr_synchronize(hot_addr=
).
> > + *
> > + * A tracepoint on waiter-enqueue confirms the waiter is on
> > + * hazptr_scan.pending before the orchestrator verifies the negative
> > + * control (sync must NOT have completed while R0 holds).
> > + */
> > +
> > +static void hot_probe_enqueue(void *__data, void *addr)
> > +{
> > +     if (addr =3D=3D hot_addr)
> > +             complete(&hot_enqueued);
> > +}
> > +
> > +/* Per-round transient sync kthread.  hot_live_syncs lets the
> > + * orchestrator and cleanup wait for exit, so no completion event
> > + * from one round can leak into the next.
> > + */
> > +static int hazptr_torture_hot_do_sync(void *unused)
> > +{
> > +     hazptr_synchronize(hot_addr);
> > +     complete(&hot_sync_done);
> > +     atomic_dec(&hot_live_syncs);
> > +     return 0;
> > +}
> > +
> > +/* R0: acquires hot_addr, signals orchestrator, waits for release cmd.
> > + * The release wait is timeout-bounded so kthread_stop() at cleanup ca=
n
> > + * always join; the hazard pointer is always released before exit.
> > + * The one-shot gate ensures R0 does not re-acquire immediately after
> > + * releasing: re-acquisition is reserved for a new round, so a drainin=
g
> > + * waiter is never blocked by R0 itself.
> > + */
> > +static int hazptr_torture_hot_r0(void *unused)
> > +{
> > +     struct hazptr_ctx ctx;
> > +     void *p;
> > +
> > +     VERBOSE_TOROUT_STRING("hot_r0 task started");
> > +     do {
> > +             while (!atomic_read(&hot_r0_gate) && !torture_must_stop()=
)
> > +                     schedule_timeout_interruptible(1);
> > +             if (torture_must_stop())
> > +                     break;
> > +             atomic_set(&hot_r0_gate, 0);
> > +             p =3D hot_addr;
> > +             (void)hazptr_acquire(&ctx, &p);
> > +             complete(&r0_held);
> > +             while (!wait_for_completion_timeout(&r0_release, HZ)) {
> > +                     if (torture_must_stop())
> > +                             break;
> > +             }
> > +             hazptr_release(&ctx, p);
> > +     } while (!torture_must_stop());
> > +     torture_kthread_stopping("hot_r0");
> > +     return 0;
> > +}
> > +
> > +/* Hammer reader: parks while not hammering (hot_hammer_active false),
> > + * so it persists across rounds.  hot_hammer_holding counts live holds
> > + * and lets the orchestrator hand off R0 only once a hammer reader
> > + * actually holds the address -- no coverage gap at the seam.
> > + */
> > +static int hazptr_torture_hot_reader(void *arg)
> > +{
> > +     int cpu =3D (long)arg;
> > +     struct hazptr_ctx ctx;
> > +     void *p;
> > +     DEFINE_TORTURE_RANDOM(rand);
> > +
> > +     set_cpus_allowed_ptr(current, cpumask_of(cpu));
> > +     for (;;) {
> > +             while (!READ_ONCE(hot_hammer_active) && !torture_must_sto=
p())
> > +                     schedule_timeout_interruptible(1);
> > +             if (torture_must_stop())
> > +                     break;
> > +             p =3D hot_addr;
> > +             p =3D hazptr_acquire(&ctx, &p);
> > +             atomic_inc(&hot_hammer_holding);
> > +             torture_hrtimeout_us(hot_hold_us, 100, &rand);
> > +             hazptr_release(&ctx, p);
> > +             atomic_dec(&hot_hammer_holding);
> > +             torture_hrtimeout_us(1, 1, &rand);
> > +     }
> > +     torture_kthread_stopping("hot_reader");
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Orchestrator: one round per loop iteration.  All waits are
> > + * timeout-bounded so cleanup can always join this task.
> > + *
> > + * Phase   Action
> > + *  boot   Wait for R0's initial hold.
> > + *   P2    Launch transient sync kthread; wait for tracepoint
> > + *         confirmation (hot_enqueued).
> > + *   P3    Negative control (non-consuming completion_done()): sync
> > + *         must NOT be done while R0 still holds.
> > + *   P4    Handoff: start hammer, wait until a hammer reader holds
> > + *         (hot_hammer_holding > 0), then release R0 -- no gap.
> > + *   P5    Hammer window: poll sync for hot_hammer_ms.
> > + *         -> completes in window: n_hot_in_seq++.
> > + *         -> still pending:       n_hot_starves++ (episode; counts
> > + *            as test error only when !starve_expected).
> > + *   P6    Positive control: stop hammer, sync must drain within 5 s
> > + *         (skipped when P5 already observed completion).
> > + *  bottom  Drain this round's sync kthread (hot_live_syncs), wait for
> > + *          R0's next hold; jitter; loop unless must_stop.
> > + */
> > +static int hazptr_torture_hot_stage(void *unused)
> > +{
> > +     unsigned long round =3D 0;
> > +     DEFINE_TORTURE_RANDOM(rand);
> > +
> > +     VERBOSE_TOROUT_STRING("hot_stage task started");
> > +
> > +     /* If the system is still booting, let it finish (same as the
> > +      * classic writer): a busy boot would make staged rounds record
> > +      * false starvation episodes and false stall splats. */
> > +     while (!torture_must_stop() && !rcu_inkernel_boot_has_ended())
> > +             schedule_timeout_interruptible(HZ);
> > +
> > +     do {
> > +             u64 t_sync_start;
> > +             int done_in_window =3D 0, positive_done;
> > +             struct task_struct *sync_task;
> > +
> > +             reinit_completion(&r0_held);
> > +             reinit_completion(&r0_release);
> > +             reinit_completion(&hot_sync_done);
> > +             reinit_completion(&hot_enqueued);
> > +             WRITE_ONCE(hot_hammer_active, false);
> > +
> > +             /* Gate R0 into a fresh hold and wait for it. */
> > +             atomic_set(&hot_r0_gate, 1);
> > +             while (!wait_for_completion_timeout(&r0_held, HZ)) {
> > +                     if (torture_must_stop())
> > +                             goto out;
> > +             }
> > +
> > +             /* P2: launch sync; confirm waiter enqueued. */
> > +             t_sync_start =3D ktime_get_ns();
> > +             atomic_inc(&hot_live_syncs);
> > +             sync_task =3D kthread_run(hazptr_torture_hot_do_sync, NUL=
L,
> > +                                     "hot_do_sync");
> > +             if (IS_ERR(sync_task)) {
> > +                     atomic_dec(&hot_live_syncs);
> > +                     pr_alert("%shot: sync kthread alloc failed r%lu\n=
",
> > +                              TORTURE_FLAG, round);
> > +                     goto skip_round;
> > +             }
> > +             if (!wait_for_completion_timeout(&hot_enqueued, HZ)) {
> > +                     pr_alert("%shot: enqueue not confirmed r%lu\n",
> > +                              TORTURE_FLAG, round);
> > +                     goto skip_round;
> > +             }
> > +
> > +             /* P3 NEGATIVE CONTROL: sync must still be pending. */
> > +             if (completion_done(&hot_sync_done)) {
> > +                     pr_alert("%shot: completed before R0 released r%l=
u\n",
> > +                              TORTURE_FLAG, round);
> > +                     atomic_inc(&n_hazptr_torture_error);
> > +             }
> > +
> > +             /*
> > +              * LONGHOLD variant: no hammer.  R0 legitimately holds
> > +              * past the stall timeout; the detector should report
> > +              * (observation, not interruption), and after release the
> > +              * sync must drain normally.  Validates that long-lived
> > +              * references -- an hazptr feature -- do not break the
> > +              * machinery and are not treated as errors.
> > +              */
> > +             if (hot_longhold_ms) {
> > +                     torture_hrtimeout_ms(hot_longhold_ms, 100, &rand)=
;
> > +                     complete(&r0_release);
> > +                     done_in_window =3D wait_for_completion_timeout(
> > +                             &hot_sync_done, 5 * HZ);
> > +                     if (!done_in_window) {
> > +                             pr_alert("%shot: longhold: sync did not d=
rain after release r%lu\n",
> > +                                      TORTURE_FLAG, round);
> > +                             atomic_inc(&n_hazptr_torture_error);
> > +                     }
> > +                     atomic_inc(done_in_window ? &n_hot_in_seq
> > +                                               : &n_hot_starves);
> > +                     positive_done =3D done_in_window;
> > +                     {
> > +                             u64 dt =3D ktime_get_ns() - t_sync_start;
> > +
> > +                             atomic_inc(&n_hot_syncs);
> > +                             pr_alert("%shot r%lu: longhold drain=3D%d=
 dt_ns=3D%llu\n",
> > +                                      TORTURE_FLAG, round,
> > +                                      !!done_in_window, dt);
> > +                     }
> > +                     goto skip_round;
> > +             }
> > +
> > +             /* P4: handoff -- hammer holds before R0 releases. */
> > +             WRITE_ONCE(hot_hammer_active, true);
> > +             while (!atomic_read(&hot_hammer_holding) &&
> > +                    !torture_must_stop())
> > +                     schedule_timeout_interruptible(1);
> > +             complete(&r0_release);
> > +
> > +             /* P5 HAMMER WINDOW. */
> > +             done_in_window =3D wait_for_completion_timeout(
> > +                     &hot_sync_done, msecs_to_jiffies(hot_hammer_ms));
> > +             if (done_in_window) {
> > +                     atomic_inc(&n_hot_in_seq);
> > +             } else {
> > +                     atomic_inc(&n_hot_starves);
> > +                     if (!starve_expected)
> > +                             atomic_inc(&n_hazptr_torture_error);
> > +             }
> > +
> > +             /* P6 POSITIVE CONTROL. */
> > +             WRITE_ONCE(hot_hammer_active, false);
> > +             if (done_in_window) {
> > +                     positive_done =3D 1;
> > +             } else {
> > +                     positive_done =3D wait_for_completion_timeout(
> > +                             &hot_sync_done, 5 * HZ);
> > +                     if (!positive_done) {
> > +                             pr_alert("%shot: positive control timed o=
ut r%lu (machinery fault?)\n",
> > +                                      TORTURE_FLAG, round);
> > +                             atomic_inc(&n_hazptr_torture_error);
> > +                     }
> > +             }
> > +
> > +             {
> > +                     u64 dt =3D ktime_get_ns() - t_sync_start;
> > +
> > +                     atomic_inc(&n_hot_syncs);
> > +                     pr_alert("%shot r%lu: starve=3D%d in_seq=3D%d pos=
=3D%d dt_ns=3D%llu\n",
> > +                              TORTURE_FLAG, round, !done_in_window,
> > +                              !!done_in_window, positive_done, dt);
> > +             }
> > +
> > +     skip_round:
> > +             /* Release R0 (harmless if already released) so an
> > +              * orphan sync from a skipped round can drain. */
> > +             complete(&r0_release);
> > +             /* Drain this round's sync kthread: no completion event
> > +              * may cross the round boundary. */
> > +             while (atomic_read(&hot_live_syncs) && !torture_must_stop=
())
> > +                     schedule_timeout_interruptible(1);
> > +             /* R0 parks on the gate after its release; the next round
> > +              * opens the gate and waits for its fresh hold above. */
> > +             round++;
> > +             torture_hrtimeout_ms(500, 200, &rand);
> > +     } while (!torture_must_stop());
> > +out:
> > +     torture_kthread_stopping("hot_stage");
> > +     return 0;
> > +}
> > +
> >  static void
> >  hazptr_torture_cleanup(void)
> >  {
> > @@ -840,6 +1141,34 @@ hazptr_torture_cleanup(void)
> >
> >       torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> >       torture_stop_kthread(hazptr_torture_preempt, preempt_task);
> > +     torture_stop_kthread(hazptr_torture_wq_churn, wq_churn_task);
> > +
> > +     /* Hot scenario: stop hammer readers first so pending syncs drain=
. */
> > +     if (nhotreaders > 0 || hot_longhold_ms > 0) {
> > +             int wait_ms =3D 5000;
> > +
> > +             WRITE_ONCE(hot_hammer_active, false);
> > +             if (hot_reader_tasks) {
> > +                     for (i =3D 0; i < nhotreaders; i++)
> > +                             torture_stop_kthread(hazptr_torture_hot_r=
eader,
> > +                                                  hot_reader_tasks[i])=
;
> > +                     kfree(hot_reader_tasks);
> > +                     hot_reader_tasks =3D NULL;
> > +             }
> > +             torture_stop_kthread(hazptr_torture_hot_r0, hot_r0_task);
> > +             torture_stop_kthread(hazptr_torture_hot_stage, hot_stage_=
task);
> > +             /* Wait for any transient sync kthreads to exit so no
> > +              * module code is executing at unload. */
> > +             while (atomic_read(&hot_live_syncs) && wait_ms > 0) {
> > +                     schedule_timeout_uninterruptible(msecs_to_jiffies=
(50));
> > +                     wait_ms -=3D 50;
> > +             }
> > +             if (atomic_read(&hot_live_syncs))
> > +                     pr_alert("%shot: %d sync kthread(s) still alive a=
t exit\n",
> > +                              TORTURE_FLAG, atomic_read(&hot_live_sync=
s));
> > +             unregister_trace_hazptr_waiter_enqueue(hot_probe_enqueue,=
 NULL);
> > +     }
> > +
> >       torture_stop_kthread(hazptr_torture_writer, writer_task);
> >
> >       if (reader_tasks) {
> > @@ -873,6 +1202,8 @@ static int __init hazptr_torture_init(void)
> >       int firsterr =3D 0;
> >       static struct hazptr_torture_ops *torture_ops[] =3D { &hazptr_ops=
, &hazptr_stack_ops, };
> >
> > +     if (!strcmp(torture_type, "none"))
> > +             return 0;
> >       if (!torture_init_begin(torture_type, verbose))
> >               return -EBUSY;
> >
> > @@ -919,6 +1250,10 @@ static int __init hazptr_torture_init(void)
> >       atomic_set(&n_hazptr_torture_free, 0);
> >       atomic_set(&n_hazptr_torture_error, 0);
> >       atomic_set(&n_hazptr_torture_wq_churn, 0);
> > +     atomic_set(&n_hot_syncs, 0);
> > +     atomic_set(&n_hot_starves, 0);
> > +     atomic_set(&n_hot_in_seq, 0);
> > +     atomic_set(&hot_r0_gate, 0);
> >       for (i =3D 0; i < HAZPTR_TORTURE_PIPE_LEN + 1; i++)
> >               atomic_set(&hazptr_torture_wcount[i], 0);
> >       for_each_possible_cpu(cpu) {
> > @@ -1004,6 +1339,45 @@ static int __init hazptr_torture_init(void)
> >               if (torture_init_error(firsterr))
> >                       goto unwind;
> >       }
> > +     if (nhotreaders > 0 || hot_longhold_ms > 0) {
> > +             int cpu =3D 0, j;
> > +
> > +             firsterr =3D register_trace_hazptr_waiter_enqueue(hot_pro=
be_enqueue, NULL);
> > +             if (firsterr) {
> > +                     pr_alert("%shot: tracepoint registration failed: =
%d\n",
> > +                              TORTURE_FLAG, firsterr);
> > +                     goto unwind;
> > +             }
> > +
> > +             if (nhotreaders > 0) {
> > +                     hot_reader_tasks =3D kcalloc(nhotreaders,
> > +                                               sizeof(hot_reader_tasks=
[0]),
> > +                                               GFP_KERNEL);
> > +                     if (!hot_reader_tasks) {
> > +                             firsterr =3D -ENOMEM;
> > +                             goto unwind;
> > +                     }
> > +                     for (j =3D 0; j < nhotreaders; j++) {
> > +                             cpu =3D cpumask_next(cpu % num_online_cpu=
s(),
> > +                                                cpu_online_mask);
> > +                             if (cpu >=3D nr_cpu_ids)
> > +                                     cpu =3D cpumask_first(cpu_online_=
mask);
> > +                             firsterr =3D torture_create_kthread(
> > +                                     hazptr_torture_hot_reader,
> > +                                     (void *)(long)cpu, hot_reader_tas=
ks[j]);
> > +                             if (torture_init_error(firsterr))
> > +                                     goto unwind;
> > +                     }
> > +             }
> > +             firsterr =3D torture_create_kthread(hazptr_torture_hot_r0=
, NULL,
> > +                                               hot_r0_task);
> > +             if (torture_init_error(firsterr))
> > +                     goto unwind;
> > +             firsterr =3D torture_create_kthread(hazptr_torture_hot_st=
age,
> > +                                               NULL, hot_stage_task);
> > +             if (torture_init_error(firsterr))
> > +                     goto unwind;
> > +     }
> >
> >       torture_init_end();
> >       return 0;
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b=
/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> > index 90ef09b0e654..b3f6137ce8ab 100644
> > --- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> > @@ -6,3 +6,5 @@ SLOWPATH
> >  LOCKDEP
> >  CPU128
> >  CPU256
> > +HOTADDR
> > +LONGHOLD
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR =
b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
> > new file mode 100644
> > index 000000000000..6f4d6746b63c
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
> > @@ -0,0 +1,18 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > +CONFIG_HAZPTR_STALL_DETECTOR=3Dy
> > +CONFIG_HAZPTR_STALL_TIMEOUT=3D1000
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.=
boot b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
> > new file mode 100644
> > index 000000000000..878b588e2e39
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.nreaders=3D0 hazptrtorture.nwriters=3D0 hazptrtorture.nh=
otreaders=3D4 hazptrtorture.hot_hold_us=3D20000 hazptrtorture.starve_expect=
ed=3D1 hazptrtorture.shutdown_secs=3D20
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD=
 b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
> > new file mode 100644
> > index 000000000000..fe293638bbe2
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
> > @@ -0,0 +1,18 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > +CONFIG_HAZPTR_STALL_DETECTOR=3Dy
> > +CONFIG_HAZPTR_STALL_TIMEOUT=3D2000
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD=
.boot b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
> > new file mode 100644
> > index 000000000000..cbe30b6a09cc
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.nreaders=3D0 hazptrtorture.nwriters=3D0 hazptrtorture.ho=
t_longhold_ms=3D8000 hazptrtorture.shutdown_secs=3D40
> > --
> > 2.43.0
> >
