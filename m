Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D9C54EE9
	for <rcu@archiver.kernel.org>; Mon, 19 Sep 2022 04:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiISEdv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 00:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiISEds (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 00:33:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EE12AA7
        for <rcu@vger.kernel.org>; Sun, 18 Sep 2022 21:33:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c7so21101779ljm.12
        for <rcu@vger.kernel.org>; Sun, 18 Sep 2022 21:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lYcFPyTXbTQ5LHmM8iwqaBZEt6Pbv7CGd01ig+HF4F4=;
        b=orgT6/bIeXU5NcFgL4Ej6xhfhg0wx/LD9VS1otZvvF46wPYSSE1UvhtQc8WvosrXiH
         SWLGWr2KXaWTAsBC0vlrdytsi+ZfVQo06L9Fuan0ouM6OsuH/naYIIMuhVtgfciocxxH
         f1Fs808rD3zWRMSXG9wKVAKpmnm3iuOrjDtmh53e4fp6igiKZBqOFtu5GaFd6SNFZXP0
         lEsemzVR2l51XETNdNb7ZWxB1bZz40qxMYLMtO9AlPaRUeQrfLQiJKi1S0DTPGPOWlY+
         wzh3i2bOCErN+iDH1kd9P3hMjhVvsKadfOrCvdunSoh0enBw3y4+ctIPh0dMshSTM2kU
         9F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lYcFPyTXbTQ5LHmM8iwqaBZEt6Pbv7CGd01ig+HF4F4=;
        b=sevo7qm+q/NMTSpAaWdK0053LV2ciPYsbejvAfZe8q0meI7D8ieWhycMqXvctNVqRO
         G/noNfD5Pq+OL6j6n63e8SY6hx7CRBBoBtiKntBhc0s4CrC0tcpXW7SFByfjI6A2SnUM
         l6IO+oSBDuf4AKaO2YahZZnmwG1EKpqWqQaNsDWIOstfhLnB196kNESR1BOzgU9l+NVV
         ewOjJspSFXzpWkMIc0DgUMunTW8UpH/wwjq9Z2DZdX8PZ9BRbuSwO0dWABx4Ktlk9ySU
         ojMGfFhsQ49saqEBFisNORYgld5Yvk01xI4JTX3tD8mCpJ+T+Jt27/aZBKF+MZQEZOGM
         jJvg==
X-Gm-Message-State: ACrzQf1YbF0e96GxEUF67fZPBU740prs/rR9wb745QAt1BNULPvT/ocU
        KKtLCfRbDs9r8uf4FE4cR2h8sFsqvMX41hrP4mMPIfyNVQ==
X-Google-Smtp-Source: AMsMyM4FdltwXLTwKrJAhnuKkZ3vD5NXG/yWyaAUzrPWlUHv4dDmXaeW2jpKy5+dnEp7xBpkoAPMnsL+XDbIEhin4Zw=
X-Received: by 2002:a2e:960e:0:b0:26b:e5ae:cd78 with SMTP id
 v14-20020a2e960e000000b0026be5aecd78mr4490541ljh.129.1663562014983; Sun, 18
 Sep 2022 21:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-3-kernelfans@gmail.com>
 <20220916142358.GA27246@lothringen>
In-Reply-To: <20220916142358.GA27246@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 19 Sep 2022 12:33:23 +0800
Message-ID: <CAFgQCTu6cxrbZ4jLdV6og2uhAG35LRjhjTw0Emgfpy0BW4kq6Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] rcu: Resort to cpu_dying_mask for affinity when offlining
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 16, 2022 at 10:24 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Thu, Sep 15, 2022 at 01:58:24PM +0800, Pingfan Liu wrote:
> > During offlining, the concurrent rcutree_offline_cpu() can not be aware
> > of each other through ->qsmaskinitnext.  But cpu_dying_mask carries such
> > information at that point and can be utilized.
> >
> > Besides, a trivial change which removes the redudant call to
> > rcu_boost_kthread_setaffinity() in rcutree_dead_cpu() since
> > rcutree_offline_cpu() can fully serve that purpose.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/tree.c        | 2 --
> >  kernel/rcu/tree_plugin.h | 6 ++++++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..8a829b64f5b2 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2169,8 +2169,6 @@ int rcutree_dead_cpu(unsigned int cpu)
> >               return 0;
> >
> >       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > -     /* Adjust any no-longer-needed kthreads. */
> > -     rcu_boost_kthread_setaffinity(rnp, -1);
> >       // Stop-machine done, so allow nohz_full to disable tick.
> >       tick_dep_clear(TICK_DEP_BIT_RCU);
> >       return 0;
>
> I would suggest to make this a separate change, for bisectability and
> readability.
>

OK, I will.

> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index ef6d3ae239b9..e5afc63bd97f 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >                   cpu != outgoingcpu)
> >                       cpumask_set_cpu(cpu, cm);
> >       cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> > +     /*
> > +      * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.
> > +      * So resort to cpu_dying_mask, whose changes has already been visible.
> > +      */
> > +     if (outgoingcpu != -1)
> > +             cpumask_andnot(cm, cm, cpu_dying_mask);
>
> I'm not sure how the infrastructure changes in your concurrent down patchset
> but can the cpu_dying_mask concurrently change at this stage?
>

For the concurrent down patchset [1], it extends the cpu_down()
capability to let an initiator to tear down several cpus in a batch
and in parallel.

At the first step, all cpus to be torn down should experience
cpuhp_set_state(cpu, st, CPUHP_TEARDOWN_CPU), by that way, they are
set in the bitmap cpu_dying_mask [2]. Then the cpu hotplug kthread on
each teardown cpu can be kicked to work. (Indeed, [2] has a bug, and I
need to fix it by using another loop to call
cpuhp_kick_ap_work_async(cpu);)

At the outmost, the pair
cpu_maps_update_begin()/cpu_maps_update_done() still prevent any new
initiator from launching another concurrent hot-add/remove event. So
cpu_dying_mask can be stable during the batched and concurrent cpus'
teardown.

[1]: https://lore.kernel.org/all/20220822021520.6996-1-kernelfans@gmail.com/
[2]: https://lore.kernel.org/all/20220822021520.6996-4-kernelfans@gmail.com/

Thanks,

    Pingfan
