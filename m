Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B2C07E9B
	for <rcu@archiver.kernel.org>; Tue, 20 Jul 2021 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D4561019
	for <rcu@archiver.kernel.org>; Tue, 20 Jul 2021 16:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhGTP6u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhGTP4p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jul 2021 11:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF39D61019;
        Tue, 20 Jul 2021 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626799043;
        bh=qwl5BZp3viPeitFs/Y8ND34HFW6gVZA4Nal81IKD6cQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i7U9TSkWiWcH+zmbrALD36wzUAedwjAGS0jl5p23Yn2y1EDnW/XvYh+6334hP47T5
         iHlRYbd4VeJr1Vz6CBo4tg5I8/iDL5VQRT1tFK51/A4+ln6dKJ3dI8OEXVN+/9KQ+H
         2NB92WLtmcqQmFfJur1Qnm0c7PRUEVNDcTbSSt8x4MKtUHwaejpZg5cL46pRvSxlVR
         dOlBwUjc9yD1yjQHM5LrJhNYSVUudZJ0hg7iOPED+0mlbZRKEXVHNiw/MjWm/S86uw
         /4mQdD0GLuHN2TlhzVUrxpUhnhGkdqQZBbiXC2UXB97wjcsZJ7s/vVYpWLILjD/TuW
         6efdcrZZlGbAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B1615C094C; Tue, 20 Jul 2021 09:37:23 -0700 (PDT)
Date:   Tue, 20 Jul 2021 09:37:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
Message-ID: <20210720163723.GH4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000080403805c6ef586d@google.com>
 <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
 <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 20, 2021 at 04:10:10PM +0200, Marco Elver wrote:
> On Tue, 20 Jul 2021 at 15:18, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > Good catch!  And yes, this would be hard to reproduce.
> >
> > How about as shown below?
> 
> Acked-by: Marco Elver <elver@google.com>

I will apply on the next rebase, thank you!

> I was merely a little surprised syzbot was able to exercise RCU in a
> way that resulted in a data race your torture runs hadn't found yet
> (or perhaps it did and missed?).

My KCSAN runs are necessarily quite short because I do a normal, KASAN,
and KCSAN variant of each scenario of each torture test, with the
constraint that it all run overnight.

So there are probably more to find.  ;-)

							Thanx, Paul

> Thanks,
> -- Marco
> 
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 43e0f01f3b6f510dbe31d02a8f4c909c45deff04
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jul 20 06:16:27 2021 -0700
> >
> >     rcu: Mark accesses to rcu_state.n_force_qs
> >
> >     This commit marks accesses to the rcu_state.n_force_qs.  These data
> >     races are hard to make happen, but syzkaller was equal to the task.
> >
> >     Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a7379c44a2366..245bca7cdf6ee 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1913,7 +1913,7 @@ static void rcu_gp_fqs(bool first_time)
> >         struct rcu_node *rnp = rcu_get_root();
> >
> >         WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > -       rcu_state.n_force_qs++;
> > +       WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
> >         if (first_time) {
> >                 /* Collect dyntick-idle snapshots. */
> >                 force_qs_rnp(dyntick_save_progress_counter);
> > @@ -2556,7 +2556,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >         /* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
> >         if (count == 0 && rdp->qlen_last_fqs_check != 0) {
> >                 rdp->qlen_last_fqs_check = 0;
> > -               rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +               rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >         } else if (count < rdp->qlen_last_fqs_check - qhimark)
> >                 rdp->qlen_last_fqs_check = count;
> >
> > @@ -2904,10 +2904,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
> >                 } else {
> >                         /* Give the grace period a kick. */
> >                         rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
> > -                       if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
> > +                       if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
> >                             rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
> >                                 rcu_force_quiescent_state();
> > -                       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +                       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >                         rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> >                 }
> >         }
> > @@ -4134,7 +4134,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
> >         /* Set up local state, ensuring consistent view of global state. */
> >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >         rdp->qlen_last_fqs_check = 0;
> > -       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >         rdp->blimit = blimit;
> >         rdp->dynticks_nesting = 1;      /* CPU not up, no tearing. */
> >         rcu_dynticks_eqs_online();
