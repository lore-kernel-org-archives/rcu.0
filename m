Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54684ECAAD8
	for <rcu@archiver.kernel.org>; Wed, 21 Sep 2022 11:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIULuR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIULtc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Sep 2022 07:49:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04409750B
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 04:48:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b24so6663236ljk.6
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mUQhd8FtYmDVpA/CnAKeHgHWJsh4NR3SrIIJ9JrcIzI=;
        b=oISKdY639CHmtKtbHbfqvEC/NpyBqYoyWNM365YE+98yBs5ueAgl20ELAl1kXz1V1D
         HEcygYpWYF4wx2lnyUv69JUsdyOWeUZmxShJAoAvXBzB24v6mw5Mi/s+OIrPBb7r7DdZ
         Z2uycirQUNJxEV62XtEO8QHvuojrP/FSEispNo4/FITdc18aUFN4bd1RVyocCKEQSp4R
         Mr4Mes24+rgeQMlx8PfsLLaKrHmAAIVbjZltjw3n6d866vBqAG7EXlYqxK2L0NPaxD9+
         NLF9Uczc29aeraIpaGoXYLkm2dQmjTQxOdY3pgd3fwaIU6EvaOflqU2YRjIboCFv/9Fb
         389Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mUQhd8FtYmDVpA/CnAKeHgHWJsh4NR3SrIIJ9JrcIzI=;
        b=TwJVEjOqydFTgOX2YV1+ZNW6Vv7IviLvOdlcHc4RK/6P3e4uHYrBJvJ9ImtQMXHf/h
         AEmWZ8+xkrV3jpudIA/sJj3kIpTpEg2CqqavFD4RQ7iIOW8cLc6hWOYGBUVk86qzUMbH
         xyam0ETrFLrx65ip5eN2AsSmXL5dD8j5NDUzEcTrKaSV+n9fCrdFeUZQ83lPws/EwtZV
         o36Uk/53aCO1eEJTZZY0w+5wjf42Xq6p85CgbMBq3cxrvi1vzx2MSBpqXDKU2JyCfv0M
         jVcZF8OTa9V1Rl0u7pvMbk7h1ZqRU+aUwhSJ6/ONyl4b2T7SVLJvqf+NPcP3rrc3uKkB
         kflQ==
X-Gm-Message-State: ACrzQf3uSexUK2hgbar5SbCNYi006Se+1nhjl3MRzhxk9WB8nRVTJbqn
        EzghiHZ0FE7XWVeCxMgKDlgMhLglhVDqnLME2UACUm8=
X-Google-Smtp-Source: AMsMyM5d9y322PhmjP8ZHGJEUq1DRo902c6tph7jgSOYKK+JwMSZBnmQMUXvb7ejBo+FwNgGtIVqjI6FJT4FzF82Vh8=
X-Received: by 2002:a05:651c:1101:b0:26c:480a:87de with SMTP id
 e1-20020a05651c110100b0026c480a87demr5574348ljo.261.1663760920735; Wed, 21
 Sep 2022 04:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-3-kernelfans@gmail.com>
 <20220920093856.GF69891@lothringen>
In-Reply-To: <20220920093856.GF69891@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 21 Sep 2022 19:48:29 +0800
Message-ID: <CAFgQCTsZ9aPe=_wVs36uDyN476CPVUuSe2Sky=E7zhmg_1E71Q@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 5:39 PM Frederic Weisbecker <frederic@kernel.org> wrote:
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
>
> For clarification, the comment could be:
>
>            While concurrently offlining, rcu_report_dead() can race, making
>            ->qsmaskinitnext unstable. So rely on cpu_dying_mask which is stable
>            and already contains all the currently offlining CPUs.
>

It  is a neat description.

Thanks,

    Pingfan
