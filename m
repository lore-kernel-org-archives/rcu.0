Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F75C2D0E4
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3353323A65
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spE2Dzdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKUANi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgKUANh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 19:13:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E57122470;
        Sat, 21 Nov 2020 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605917616;
        bh=5zB1AfWDQYwfDmz40UJYUCjQwB9bwxL+MKW9vHuE2G4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=spE2DzduUV//465dUX/iVEtr1ncMWxR0ZUty1K39hRjqZD7LO1qFkxS/X/ZWfRp4h
         iULl/zC2Fxh934+zVvzWGyrI5LU3YYiDa/YqLcVdJBiYowrP5z1TkQPpAFPuhqTW7v
         IsxyVmhzSD/RbyllaTvIL02/rk9BebZfrFVe5/Jk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A5F33522A6E; Fri, 20 Nov 2020 16:13:36 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:13:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 4/5] srcu: Provide polling interfaces
 for Tiny SRCU grace periods
Message-ID: <20201121001336.GN1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-4-paulmck@kernel.org>
 <f7a47e5f-095c-e4ba-ece0-83f2137fb381@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a47e5f-095c-e4ba-ece0-83f2137fb381@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 05:28:32PM +0530, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There is a need for a polling interface for SRCU grace
> > periods, so this commit supplies get_state_synchronize_srcu(),
> > start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
> > purpose.  The first can be used if future grace periods are inevitable
> > (perhaps due to a later call_srcu() invocation), the second if future
> > grace periods might not otherwise happen, and the third to check if a
> > grace period has elapsed since the corresponding call to either of the
> > first two.
> > 
> > As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
> > the return value from either get_state_synchronize_srcu() or
> > start_poll_synchronize_srcu() must be passed in to a later call to
> > poll_state_synchronize_srcu().
> > 
> > Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> > Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> > [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >   include/linux/rcupdate.h |  2 ++
> >   include/linux/srcu.h     |  3 +++
> >   include/linux/srcutiny.h |  1 +
> >   kernel/rcu/srcutiny.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   4 files changed, 56 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index de08264..e09c0d8 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -33,6 +33,8 @@
> >   #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
> >   #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
> >   #define ulong2long(a)		(*(long *)(&(a)))
> > +#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > +#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
> >   /* Exported common interfaces */
> >   void call_rcu(struct rcu_head *head, rcu_callback_t func);
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index e432cc9..a0895bb 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -60,6 +60,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
> >   int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
> >   void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
> >   void synchronize_srcu(struct srcu_struct *ssp);
> > +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
> > +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
> > +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
> >   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index fed4a2d..e9bd6fb 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -16,6 +16,7 @@
> >   struct srcu_struct {
> >   	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
> >   	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
> > +	unsigned short srcu_idx_max;	/* Furthest future srcu_idx request. */
> >   	u8 srcu_gp_running;		/* GP workqueue running? */
> >   	u8 srcu_gp_waiting;		/* GP waiting for readers? */
> >   	struct swait_queue_head srcu_wq;
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 3bac1db..b405811 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -34,6 +34,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
> >   	ssp->srcu_gp_running = false;
> >   	ssp->srcu_gp_waiting = false;
> >   	ssp->srcu_idx = 0;
> > +	ssp->srcu_idx_max = 0;
> >   	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> >   	INIT_LIST_HEAD(&ssp->srcu_work.entry);
> >   	return 0;
> > @@ -114,7 +115,7 @@ void srcu_drive_gp(struct work_struct *wp)
> >   	struct srcu_struct *ssp;
> >   	ssp = container_of(wp, struct srcu_struct, srcu_work);
> > -	if (ssp->srcu_gp_running || !READ_ONCE(ssp->srcu_cb_head))
> > +	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
> >   		return; /* Already running or nothing to do. */
> >   	/* Remove recently arrived callbacks and wait for readers. */
> > @@ -147,14 +148,19 @@ void srcu_drive_gp(struct work_struct *wp)
> >   	 * straighten that out.
> >   	 */
> >   	WRITE_ONCE(ssp->srcu_gp_running, false);
> > -	if (READ_ONCE(ssp->srcu_cb_head))
> > +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
> 
> Should this be USHORT_CMP_LT ?

I believe that you are correct.  As is, it works but does needless
grace periods.

> >   		schedule_work(&ssp->srcu_work);
> >   }
> >   EXPORT_SYMBOL_GPL(srcu_drive_gp);
> >   static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> >   {
> > +	unsigned short cookie;
> > +
> >   	if (!READ_ONCE(ssp->srcu_gp_running)) {
> > +		cookie = get_state_synchronize_srcu(ssp);
> > +		if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
> > +			WRITE_ONCE(ssp->srcu_idx_max, cookie);
> 
> I was thinking of a case which might break with this.
> 
> Consider a scenario, where GP is in progress and kworker is right
> before below point, after executing callbacks:
> 
> void srcu_drive_gp(struct work_struct *wp) {
>   <snip>

We updated ->srcu_idx up here, correct?  So it has bottom bit zero.

>   while (lh) {
>   <cb execution loop>
>   }
>   >>> CURRENT EXECUTION POINT

Keeping in mind that Tiny SRCU always runs !PREEMPT, this must be
due to an interrupt.

>   WRITE_ONCE(ssp->srcu_gp_running, false);
> 
>   if (USHORT_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>     schedule_work(&ssp->srcu_work);
> }
> 
> Now, at this instance, srcu_gp_start_if_needed() runs and samples
> srcu_gp_running and returns, without updating srcu_idx_max
> 
> static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> {
>   if (!READ_ONCE(ssp->srcu_gp_running)) returns true
>   <snip>
> }

This could happen in an interrupt handler, so with you thus far.

> kworker running srcu_drive_gp() resumes and returns without queueing a new
> schedule_work(&ssp->srcu_work); for new GP?
> 
> Prior to this patch, call_srcu() enqueues a cb before entering
> srcu_gp_start_if_needed(), and srcu_drive_gp() observes this
> queuing, and schedule a work for the new GP, for this scenario.
> 
> 
>  	WRITE_ONCE(ssp->srcu_gp_running, false);
> -	if (READ_ONCE(ssp->srcu_cb_head))
> +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>  		schedule_work(&ssp->srcu_work);
> 
> So, should the "cookie" calculation and "srcu_idx_max" setting be moved
> outside of ssp->srcu_gp_running check and maybe return the same cookie to
> caller and use that as the returned cookie from
> start_poll_synchronize_srcu() ?
> 
> srcu_gp_start_if_needed()
>   cookie = get_state_synchronize_srcu(ssp);
>   if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
>      WRITE_ONCE(ssp->srcu_idx_max, cookie);
>   if (!READ_ONCE(ssp->srcu_gp_running)) {
>   <snip>
> }

I believe that you are quite correct, thank you!

But rcutorture does have a call_srcu() (really a ->call, but same if SRCU)
in a timer handler.  The race window is quite narrow, so testing it might
be a challenge...

This is what I end up with:

	static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
	{
		unsigned short cookie;

		cookie = get_state_synchronize_srcu(ssp);
		if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
			WRITE_ONCE(ssp->srcu_idx_max, cookie);
		if (!READ_ONCE(ssp->srcu_gp_running)) {
			if (likely(srcu_init_done))
				schedule_work(&ssp->srcu_work);
			else if (list_empty(&ssp->srcu_work.entry))
				list_add(&ssp->srcu_work.entry, &srcu_boot_list);
		}
	}

Does that look plausible?

							Thanx, Paul
