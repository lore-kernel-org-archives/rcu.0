Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F2C6369E
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A588246E0
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 18:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9nXR0Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKSSAO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 13:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgKSSAN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 13:00:13 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F15246A7;
        Thu, 19 Nov 2020 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605808812;
        bh=SgurXvzhl9QuPyBTLPJtG4Q6saSrCINScSXjZM3boiY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G9nXR0Hc81p1Wd9CZ7BRzEKbDyKZi+wK22E0R4lEabYjim1Vlj9WubIAWnrlyLNL9
         KlPJD/PP1cy0I7JGaiMCjcWOh6toiVfGO7WtmJ4+Zq0EBBEPuqlfzoILasOMSWxtEf
         oA1dto0U+ndVH69mpzAq+Maanvjexn6Pe0BdQSU4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 28B3235225CF; Thu, 19 Nov 2020 10:00:12 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:00:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC tip/core/rcu 1/5] srcu: Make Tiny SRCU use multi-bit
 grace-period counter
Message-ID: <20201119180012.GW1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-1-paulmck@kernel.org>
 <72dffe43-b746-6d75-1f6a-9936d709be63@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dffe43-b746-6d75-1f6a-9936d709be63@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:44:49PM +0530, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There is a need for a polling interface for SRCU grace periods.  This
> > polling needs to distinguish between an SRCU instance being idle on the
> > one hand or in the middle of a grace period on the other.  This commit
> > therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
> > a defacto boolean to a free-running counter, using the bottom bit to
> > indicate that a grace period is in progress.  The second-from-bottom
> > bit is thus used as the index returned by srcu_read_lock().
> > 
> > Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> > Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >   include/linux/srcutiny.h | 4 ++--
> >   kernel/rcu/srcutiny.c    | 5 +++--
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 5a5a194..fed4a2d 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -15,7 +15,7 @@
> >   struct srcu_struct {
> >   	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
> > -	short srcu_idx;			/* Current reader array element. */
> > +	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
> >   	u8 srcu_gp_running;		/* GP workqueue running? */
> >   	u8 srcu_gp_waiting;		/* GP waiting for readers? */
> >   	struct swait_queue_head srcu_wq;
> > @@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
> >   {
> >   	int idx;
> > -	idx = READ_ONCE(ssp->srcu_idx);
> > +	idx = (READ_ONCE(ssp->srcu_idx) & 0x2) / 2;
> 
> Should we use bit 0x2 of (READ_ONCE(ssp->srcu_idx) + 1) , if GP
> (srcu_drive_gp()) is in progress? Or am I missing something here?
> 
> idx = ((READ_ONCE(ssp->srcu_idx) +1) & 0x2) / 2;

You miss nothing!  I am running about 200 hours of concurrent rcutorture
of the SRCU-t and SRCU-u scenarios, but I must admit that this race could
be hard to hit.  But it could of course result in too-short grace periods.
I will fold this into the original with attribution.

> Also, any reason for using divison instead of shift; something to
> do with 16-bit srcu_idx which I am missing here?

I just figure that the compiler is better at selecting instructions
than I am.  Either would work.

							Thanx, Paul

> Thanks
> Neeraj
> 
> >   	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> >   	return idx;
> >   }
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 6208c1d..5598cf6 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
> >   	ssp->srcu_cb_head = NULL;
> >   	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
> >   	local_irq_enable();
> > -	idx = ssp->srcu_idx;
> > -	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> > +	idx = (ssp->srcu_idx & 0x2) / 2;
> > +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> >   	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
> >   	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
> >   	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
> > +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> >   	/* Invoke the callbacks we removed above. */
> >   	while (lh) {
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
