Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CDC4332F
	for <rcu@archiver.kernel.org>; Fri, 14 Oct 2022 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJNPqG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJNPqA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Oct 2022 11:46:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EC2D740;
        Fri, 14 Oct 2022 08:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09C9BCE268B;
        Fri, 14 Oct 2022 15:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A7C433D7;
        Fri, 14 Oct 2022 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665762351;
        bh=iUfoeiPzouTp8yPh+xwm1NytBnK0yC7vZn1OItlBWhI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P9f6Ec5vjtOvSWIUpPkuVwjLViMfY8YOvHc/B7x28zsrO09Z/bjFnp34Dzbeo/3cV
         nJZnSIsXJyuHImkJAlw00bJM3HfWorshwAis6Px6m0TP2ftmEt62zkHL6CEZy1MpMU
         Kxiw9cjQzXEshALG7pOEiLTL/RLnewnLh0zCus/5tpqByitnBasVXW0dTeur8GVkd4
         YD2ulW3rgTtEHy/ZRpiJLxz3KqeQZBu54wWkWq8Blu2p5wNHdHLNkIv+JCweFhKKxN
         eylVjryfLVVRwSoyH6bDWsfrO2caViqrtRGG3Hf0LkH/pcXlwwcGcsaBmxitHE8k0H
         0kBrO2i9XCh8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDA8F5C32BF; Fri, 14 Oct 2022 08:45:47 -0700 (PDT)
Date:   Fri, 14 Oct 2022 08:45:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v8 02/13] rcu: Make call_rcu() lazy to save power
Message-ID: <20221014154547.GA710792@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-3-joel@joelfernandes.org>
 <20221011231053.GA1052831@lothringen>
 <CAEXW_YSsEQ8krr9ckCOmO1B=C+Oy+8j_BtetQeNu1McH5nSuQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSsEQ8krr9ckCOmO1B=C+Oy+8j_BtetQeNu1McH5nSuQg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 12, 2022 at 03:54:25PM -0400, Joel Fernandes wrote:
> On Tue, Oct 11, 2022 at 7:10 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Tue, Oct 11, 2022 at 06:01:31PM +0000, Joel Fernandes (Google) wrote:
> > > @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> > >       raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> > >
> > >       /*
> > > -      * Bypass wakeup overrides previous deferments. In case
> > > -      * of callback storm, no need to wake up too early.
> > > +      * Bypass wakeup overrides previous deferments. In case of
> > > +      * callback storm, no need to wake up too early.
> > >        */
> > > -     if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > > +     if (waketype == RCU_NOCB_WAKE_LAZY &&
> > > +         READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
> >
> > No need for READ_ONCE() here.
> >
> > > +             mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> > > +             WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > > +     } else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > >               mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> > >               WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > >       } else {
> > > @@ -611,6 +682,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > >       unsigned long flags;
> > >       bool gotcbs = false;
> > >       unsigned long j = jiffies;
> > > +     bool lazy = false;
> > > +     long lazy_ncbs;
> >
> > Looks like lazy_ncbs can be declared withing the loop, as well as bypass_cbs.
> >
> > Anyway, apart from such boring cosmectics:
> >
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks, I folded the cosmetic suggestions with the Ack and pushed it to:
> https://github.com/joelagnel/linux-kernel.git (branch rcu-next-oct.12.22)

Just following back up with Frederic to see if all of your guys' words
had the same meanings.  ;-)

							Thanx, Paul
