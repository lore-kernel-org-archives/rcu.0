Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556D9CDB474
	for <rcu@archiver.kernel.org>; Tue, 17 Oct 2023 01:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjJQB2i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Oct 2023 21:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQB2h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Oct 2023 21:28:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8FAB
        for <rcu@vger.kernel.org>; Mon, 16 Oct 2023 18:28:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso54872161fa.2
        for <rcu@vger.kernel.org>; Mon, 16 Oct 2023 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697506113; x=1698110913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q3O50eeA1Y7ZiXGrobG6AVHgGE6OeNbMwpA28ICesQ=;
        b=egI7SsWJGf6a6DoXv6qPWHvQv6fE04W7wvfLxpcqqbq85jveBHfKyk4qKiBugqkeuC
         qtetiIMyxWyMCKWDRABF4iFe0jjI5k2IS5dAUDsquf6YCL2OXaZ9qgHLl4KjU/9qyvEp
         UAwHDmWfLdJv5xG0Z77g4qIdkEyI6jEhF2ZWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697506113; x=1698110913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q3O50eeA1Y7ZiXGrobG6AVHgGE6OeNbMwpA28ICesQ=;
        b=h3l0/4qeWgqIlzSCCWZDdsk8SByJvEmDRYlD2T/Aaq8iVXdiDWGSTRDpnLU/ucfrT8
         I7W0MqLKOn9aLvLEUGEiIi7Ag716WNeBxzGdqiiy5NGvvtQ6Z5YKOWiXrnL1i9/Z41k6
         uYTQlBn3uFGKeS9/XUzvowhpPyfoexpcDXwyBGBB7HkLbuLO7J4RnYRwt1i6ZBu+gDBh
         F5Zpu4HbTGgzQA4mnbjOBXA6WcMWr40Kv7oe+4/aW0J7ZK1NkpiQCVF1iq/rqFRBh/La
         Fzv7EIDMlKRPwOqjAK3afs0P9ZKCDUZ/32O87sxvRxwHoWC1eYQH2gzXbM49f1klkEN1
         zRNg==
X-Gm-Message-State: AOJu0YyhstfUsPHaqmWg0PkofsC2904/8P+RF41d1nzbOt7vSy3xlbJF
        Ufr3Db4a5q8FpMs9JeBfQ+DwEW4hkbky1WcXiYSfKg==
X-Google-Smtp-Source: AGHT+IHbprxAevZrWWtye5sstLh59PSicnxgJo1CBAwFQ/S6HvMKEzyKK5W7kw2hk8woqY/6vc+Ntfpzp5AOAvsuTIY=
X-Received: by 2002:a2e:a588:0:b0:2c5:14f8:d5dc with SMTP id
 m8-20020a2ea588000000b002c514f8d5dcmr627143ljp.14.1697506113179; Mon, 16 Oct
 2023 18:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231016173004.14148-1-urezki@gmail.com>
In-Reply-To: <20231016173004.14148-1-urezki@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Oct 2023 21:28:22 -0400
Message-ID: <CAEXW_YRfuXqnBFN=DpOLio74j8fX3eEDSFCH8LXyavuHDdYysA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Vlad,

Looks like a nice patch, I am still looking at this more and just
started, but a few small comments:

On Mon, Oct 16, 2023 at 1:30=E2=80=AFPM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> A call to a synchronize_rcu() can be optimized from time point of
> view. Different workloads can be affected by this especially the
> ones which use this API in its time critical sections.
>
> For example if CONFIG_RCU_NOCB_CPU is set, the wakeme_after_rcu()
> callback can be delayed and such delay depends on where in a nocb
> list it is located.
>
> 1. On our Android devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
>
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CB=
s=3D3613 bl=3D28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preemp=
t rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preemp=
t rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preemp=
t rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preemp=
t rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preemp=
t rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preemp=
t rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-=
invoked=3D3612 idle=3D....
> <snip>
>
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
>
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
>
[...]
> 3. To address this drawback, maintain a separate track that consists
> of synchronize_rcu() callers only. The GP-kthread, that drivers a GP
> either wake-ups a worker to drain all list or directly wakes-up end
> user if it is one in the drain list.

I wonder if there is a cut-off N, where waking up N ("a few") inline
instead of just 1, yields similar results. For small values of N, that
keeps the total number of wakeups lower than pushing off to a kworker.
For instance, if 2 users, then you get 3 wakeups instead of just 2 (1
for the kworker and another 2 for the synchronize). But if you had a
cut off like N=3D5, then 2 users results in just 2 wakeups.
I don't feel too strongly about it, but for small values of N, I am
interested in a slightly better optimization if we can squeeze it.

[...]
> + * There are three lists for handling synchronize_rcu() users.
> + * A first list corresponds to new coming users, second for users
> + * which wait for a grace period and third is for which a grace
> + * period is passed.
> + */
> +static struct sr_normal_state {
> +       struct llist_head curr; /* request a GP users. */
> +       struct llist_head wait; /* wait for GP users. */
> +       struct llist_head done; /* ready for GP users. */
> +       struct llist_node *curr_tail;
> +       struct llist_node *wait_tail;

Just for clarification, the only reason you need 'tail' is because you
can use llist_add_batch() to quickly splice the list, instead of
finding the tail each time (expensive for a large list), correct? It
would be good to mention that in a comment here.

> +       atomic_t active;
> +} sr;
> +
> +/* Disable it by default. */
> +static int rcu_normal_wake_from_gp =3D 0;
> +module_param(rcu_normal_wake_from_gp, int, 0644);
> +
> +static void rcu_sr_normal_complete(struct llist_node *node)
> +{
> +       struct rcu_synchronize *rs =3D container_of(
> +               (struct rcu_head *) node, struct rcu_synchronize, head);
> +       unsigned long oldstate =3D (unsigned long) rs->head.func;
> +
> +       if (!poll_state_synchronize_rcu(oldstate))
> +               WARN_ONCE(1, "A full grace period is not passed yet: %lu"=
,
> +                       rcu_seq_diff(get_state_synchronize_rcu(), oldstat=
e));

nit: WARN_ONCE(!poll_state_synchronize_rcu(oldstate)), ...) and get
rid of if() ?

> +
> +       /* Finally. */
> +       complete(&rs->completion);
> +}
> +
> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> +{
> +       struct llist_node *done, *rcu, *next;
> +
> +       done =3D llist_del_all(&sr.done);
> +       if (!done)
> +               return;
> +
> +       llist_for_each_safe(rcu, next, done)
> +               rcu_sr_normal_complete(rcu);
> +}
[...]
> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> +{
> +       atomic_inc(&sr.active);
> +       if (llist_add((struct llist_node *) &rs->head, &sr.curr))
> +               /* Set the tail. Only first and one user can do that. */
> +               WRITE_ONCE(sr.curr_tail, (struct llist_node *) &rs->head)=
;
> +       atomic_dec(&sr.active);

Here there is no memory ordering provided by the atomic ops. Is that really=
 Ok?

And same question for other usages of .active.

Per: https://www.kernel.org/doc/Documentation/atomic_t.txt
"RMW operations that have no return value are unordered;"
--
Note to self to ping my Android friends as well about this improvement
:-). Especially the -mm Android folks are interested in app startup
time.

thanks,

 - Joel



> +}
> +
>  /*
>   * Initialize a new grace period.  Return false if no grace period requi=
red.
>   */
> @@ -1418,6 +1534,7 @@ static noinline_for_stack bool rcu_gp_init(void)
>         /* Record GP times before starting GP, hence rcu_seq_start(). */
>         rcu_seq_start(&rcu_state.gp_seq);
>         ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> +       rcu_sr_normal_gp_init();
>         trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("sta=
rt"));
>         rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>         raw_spin_unlock_irq_rcu_node(rnp);
> @@ -1787,6 +1904,9 @@ static noinline void rcu_gp_cleanup(void)
>         }
>         raw_spin_unlock_irq_rcu_node(rnp);
>
> +       // Make synchronize_rcu() users aware of the end of old grace per=
iod.
> +       rcu_sr_normal_gp_cleanup();
> +
>         // If strict, make all CPUs aware of the end of the old grace per=
iod.
>         if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>                 on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> @@ -3500,6 +3620,35 @@ static int rcu_blocking_is_gp(void)
>         return true;
>  }
>
> +/*
> + * Helper function for the synchronize_rcu() API.
> + */
> +static void synchronize_rcu_normal(void)
> +{
> +       struct rcu_synchronize rs;
> +
> +       if (READ_ONCE(rcu_normal_wake_from_gp)) {
> +               init_rcu_head_on_stack(&rs.head);
> +               init_completion(&rs.completion);
> +
> +               /*
> +                * This code might be preempted, therefore take a GP
> +                * snapshot before adding a request.
> +                */
> +               rs.head.func =3D (void *) get_state_synchronize_rcu();
> +               rcu_sr_normal_add_req(&rs);
> +
> +               /* Kick a GP and start waiting. */
> +               (void) start_poll_synchronize_rcu();
> +
> +               /* Now we can wait. */
> +               wait_for_completion(&rs.completion);
> +               destroy_rcu_head_on_stack(&rs.head);
> +       } else {
> +               wait_rcu_gp(call_rcu_hurry);
> +       }
> +}
> +
>  /**
>   * synchronize_rcu - wait until a grace period has elapsed.
>   *
> @@ -3551,7 +3700,7 @@ void synchronize_rcu(void)
>                 if (rcu_gp_is_expedited())
>                         synchronize_rcu_expedited();
>                 else
> -                       wait_rcu_gp(call_rcu_hurry);
> +                       synchronize_rcu_normal();
>                 return;
>         }
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..279a37beb05a 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -987,7 +987,7 @@ void synchronize_rcu_expedited(void)
>
>         /* If expedited grace periods are prohibited, fall back to normal=
. */
>         if (rcu_gp_is_normal()) {
> -               wait_rcu_gp(call_rcu_hurry);
> +               synchronize_rcu_normal();
>                 return;
>         }
>
> --
> 2.30.2
>
