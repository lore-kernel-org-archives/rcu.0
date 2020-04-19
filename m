Return-Path: <SRS0=xcwz=6D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6011C38A30
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34D621744
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587309886;
	bh=Ogj0JioqdRU35CGmtnbwyWL1X4jEg4maBSJo2mTBnKE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ys5oFHZPtmoPTNLcPWjuXhiwfEOZUGbphUeSFAflc1UxGq3jcR4no1/RDjF8Ew3+b
	 RK1pKzZitMYxBDPw3b1TrXVaXuahITj2sfCzsDe04EZZBXbtqVUn0LUZ1fnzvMWW3f
	 q0O+pGsvCCBiZkPbQogXScNkcRWu1C5TRvVhHwVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDSPYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgDSPYq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Apr 2020 11:24:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459F4214D8;
        Sun, 19 Apr 2020 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587309885;
        bh=Ogj0JioqdRU35CGmtnbwyWL1X4jEg4maBSJo2mTBnKE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rKr8RAxRR8DMQWFo8VMW41Kknn8GCroRJQATNWfQln9+d0MU3UAduyEXb55Hb2Ybs
         LdIw110qiZnDvgNq7FSBcu4Bk9CEvUn+FrfN9e52lJvFOmqtfwZTW1RMS7u51AdJze
         b8hLORRO4U9Tz4mCSr0L75Z4vtU5H5xBrDys4opk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1BDD435226A1; Sun, 19 Apr 2020 08:24:45 -0700 (PDT)
Date:   Sun, 19 Apr 2020 08:24:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: simplify the calculation of rcu_state.ncpus
Message-ID: <20200419152445.GU17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200417213951.29837-1-richard.weiyang@gmail.com>
 <20200418031922.GR17661@paulmck-ThinkPad-P72>
 <CADZGycYVL9j7jbE1ZY_ZOv2XXv9XwWGPykoE63nJ79VrXwwUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADZGycYVL9j7jbE1ZY_ZOv2XXv9XwWGPykoE63nJ79VrXwwUCg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 19, 2020 at 06:02:12AM +0800, Wei Yang wrote:
> On Sat, Apr 18, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 17, 2020 at 09:39:51PM +0000, Wei Yang wrote:
> > > There is only 1 bit set in mask, which means the difference between
> > > oldmask and the new one would be at the position where the bit is set in
> > > mask.
> > >
> > > Based on this knowledge, rcu_state.ncpus could be calculated by checking
> > > whether mask is already set in oldmask.
> >
> > Nice!!!  Good eyes!
> >
> > > BTW, the comment at the last of this line is mysterious. Not sure it
> > > could be removed or not.
> >
> > The "^^^" in that comment says to look at the comment on the preceding
> > line.  Memory-ordering functions like smp_store_release() are supposed
> > to have comments indicating what they are ordering.  ;-)
> >
> > Could you please do the following things and resubmit?
> >
> > 1.      Forward-port to -rcu branch dev?  This tree lives here:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >
> > 2.      Given that oldmask is used only to test to see if a new bit
> >         was set, why not just replace oldmask with a bool variable
> >         that is set to "!(rnp->expmaskinitnext & mask)" before the
> >         bit is ORed into rnp->expmaskinitnext?
> >
> > 3.      Put the comment inside the "if" statement with the
> >         smp_store_release().
> >
> > 4.      In -rcu, you will find a ASSERT_EXCLUSIVE_WRITER() statement
> >         that should also be placed inside the "if" statement with
> >         the smp_store_release().
> >
> 
> Oops, my email client EAT this mail. Hope this mail will not be banned.

This one made it.  ;-)

> I adjust the code a little according to your suggestion like below. Is this
> what you expected?

Much better, thank you!

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f288477ee1c2..f01367a80b70 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
>  {
>         unsigned long flags;
>         unsigned long mask;
> -       int nbits;
> -       unsigned long oldmask;
>         struct rcu_data *rdp;
>         struct rcu_node *rnp;
> +       bool has_seen;

Could you please use a more descriptive name, perhaps something like
"newcpu"?  Yes, "has_seen" does make sense, but it leaves the reader
the question "has seen what?".

>         if (per_cpu(rcu_cpu_started, cpu))
>                 return;
> @@ -3747,13 +3746,13 @@ void rcu_cpu_starting(unsigned int cpu)
>         mask = rdp->grpmask;
>         raw_spin_lock_irqsave_rcu_node(rnp, flags);
>         WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
> -       oldmask = rnp->expmaskinitnext;
> +       has_seen = rnp->expmaskinitnext & mask;
>         rnp->expmaskinitnext |= mask;
> -       oldmask ^= rnp->expmaskinitnext;
> -       nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
> -       /* Allow lockless access for expedited grace periods. */
> -       smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> -       ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
> +       if (!has_seen) {
> +               /* Allow lockless access for expedited grace periods. */
> +               smp_store_release(&rcu_state.ncpus, rcu_state.ncpus +
> 1); /* ^^^ */
> +               ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);

One advantage of flipping the conditional is that it allows dropping the
"if" statement, which saves a few lines of code and gets closer to your
original suggestion:

	newcpu = !(rnp->expmaskinitnext & mask);
	rnp->expmaskinitnext |= mask;
	/* Allow lockless access for expedited grace periods. */
	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);

Yes, this does execute a store-release that doesn't change anything,
but this is OK because (1) CPU hotplug is infrequent and (2) CPU hotplug
has very high overhead.  The overhead of the store is thus neglible.
(But please do not try this to heavily contended cachelines on fastpaths!

And yes, I should have thought of this in response to your initial patch,
but then again, I should have thought of this when writing this code in
the first place, shouldn't I have?  ;-)

							Thanx, Paul

> +       }
>         rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>         rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>         rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> 
> >                                                         Thanx, Paul
> >
> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > > ---
> > >  kernel/rcu/tree.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index d91c9156fab2..f0d9251fa663 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3364,7 +3364,6 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  {
> > >       unsigned long flags;
> > >       unsigned long mask;
> > > -     int nbits;
> > >       unsigned long oldmask;
> > >       struct rcu_data *rdp;
> > >       struct rcu_node *rnp;
> > > @@ -3381,10 +3380,9 @@ void rcu_cpu_starting(unsigned int cpu)
> > >       rnp->qsmaskinitnext |= mask;
> > >       oldmask = rnp->expmaskinitnext;
> > >       rnp->expmaskinitnext |= mask;
> > > -     oldmask ^= rnp->expmaskinitnext;
> > > -     nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
> > >       /* Allow lockless access for expedited grace periods. */
> > > -     smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> > > +     if (!(oldmask & mask))
> > > +             smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + 1); /* ^^^ */
> > >       rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> > >       rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > >       rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > > --
> > > 2.23.0
> > >
