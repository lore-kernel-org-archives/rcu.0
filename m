Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D51DC3F6B0
	for <rcu@archiver.kernel.org>; Mon, 22 Aug 2022 18:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiHVSIw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiHVSIv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Aug 2022 14:08:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA41D0E6
        for <rcu@vger.kernel.org>; Mon, 22 Aug 2022 11:08:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x64so8988336iof.1
        for <rcu@vger.kernel.org>; Mon, 22 Aug 2022 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WgzWzZj00zOWLrpbCwQ4WTwiDIwDcKzbwKa8iAf7tLg=;
        b=OWC1nKVBtluEW62ASQUxzNEKPaHq+xaPILPsqberXSM3ZYA8aUQyGYB7lYfxVvO3Kx
         02oQPI4Hbh1a3fXkORCfP/LGkRxymrN2VbrNgvOeSz6RdEkVVWDFzSS/DH1ojr0uBAqu
         IGw2jTYyP8dKkaI73RXI091fqraCH6NvcfoR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WgzWzZj00zOWLrpbCwQ4WTwiDIwDcKzbwKa8iAf7tLg=;
        b=jTu13CZ2Kfb6u5TZwEuAjFxRT3jNRgEnb+ghzmHYzMfepCI0pmMc4f3Cq5vjNq+wNw
         8b9Orix05/Lx/C0fQsOmksI3/B54V9EH4m7FJFkeRvMxbUgEGqsG4UWrXyF4pz5T6hYr
         lGyKzkA3bmzfmO4oG4Wnk6q3ShFcW0/A2Vnx5rhDPv1macTP0UuIzBwW+eQwIos1wv35
         980JXPSuUvbzhw89kPq09m6lyeBRQkzXJwtC88QuVSfght+Pu7tX9c8UkLfa+IguyrKE
         3dsSq/rFdkuHM6lR0tP66SvUmGL4W7ENjmiCiBY2QehWYZt0bpnNLFWk8l3IXqzstuiD
         Vh1w==
X-Gm-Message-State: ACgBeo28HTXqDYjpxd0KPzbOyAwUGWBlcRifQtUB3JAZY0QON14eKY0F
        fMnQgAVfhsya29evU+H3CCUuGlwN8ypx5I53y1Nh4A==
X-Google-Smtp-Source: AA6agR7cV0NmQ6+Pqp4g7/80o66iJ+BRcBW4jtTnfFVQmkwALzchwVQ5BWOGJnuehHgZpFba5YCOnN125O5Tw0wa6SA=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr9103230iol.201.1661191729339; Mon, 22
 Aug 2022 11:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
In-Reply-To: <20220822021520.6996-7-kernelfans@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 22 Aug 2022 14:08:38 -0400
Message-ID: <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> In order to support parallel, rcu_state.n_online_cpus should be
> atomic_dec()

What does Parallel mean? Is that some kexec terminology?

Thanks,

 - Joel

>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Price <steven.price@arm.com>
> Cc: "Peter Zijlstra
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: linux-kernel@vger.kernel.org
> To: rcu@vger.kernel.org
> ---
>  kernel/cpu.c      | 1 +
>  kernel/rcu/tree.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1261c3f3be51..90debbe28e85 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>                 .name                   = "RCU/tree:prepare",
>                 .startup.single         = rcutree_prepare_cpu,
>                 .teardown.single        = rcutree_dead_cpu,
> +               .support_kexec_parallel = true,
>         },
>         /*
>          * On the tear-down path, timers_dead_cpu() must be invoked
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..07d31e16c65e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
>         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>                 return 0;
>
> -       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> +       /* Hot remove path allows parallel, while Hot add races against remove on lock */
> +       atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
>         /* Adjust any no-longer-needed kthreads. */
>         rcu_boost_kthread_setaffinity(rnp, -1);
>         // Stop-machine done, so allow nohz_full to disable tick.
> --
> 2.31.1
>
