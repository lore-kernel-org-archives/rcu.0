Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80FC63697
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40EF20721
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 21:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwFAGeCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgKWVMw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbgKWVMw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Nov 2020 16:12:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CDB206B5;
        Mon, 23 Nov 2020 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606165971;
        bh=OSgHRkDDTnFfc5FRxp9rMBlkxHFzQMx7l1OGJ8nxjOA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HwFAGeCrQs/UkOnqy/cLlaE0OiElNlVlbRo4i3+1TUe+V4rcksnkdYPLaknnX1xz/
         SGyuzIY9Iq6JUoH5aKGwbrT+qctOF8BCMGXQmyhDCpxwO8FDLqLjHOzqHESGoumEZ+
         nV4VIT1Q76Nl7t63xzcQuJUtyvd2iO3UVY74aseM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CC6943522638; Mon, 23 Nov 2020 13:12:50 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:12:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 tip/core/rcu 4/6] srcu: Provide polling interfaces for
 Tiny SRCU grace periods
Message-ID: <20201123211250.GF1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <@@@>
 <20201121005919.17152-4-paulmck@kernel.org>
 <2d210fa7-3484-9cee-862b-a8f15fee8c8e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d210fa7-3484-9cee-862b-a8f15fee8c8e@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 23, 2020 at 10:13:13AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
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
> > [ paulmck: Apply feedback from Neeraj Upadhyay. ]
> > Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
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
> > index d9edb67..c7f0c1f 100644
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
> > index 3bac1db..b073175 100644
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
> 
> Minor: cleanup_srcu_struct() can probably have 2 new sanity checks?
> 
> WARN_ON(ssp->srcu_idx != ssp->srcu_idx_max);
> WARN_ON(ssp->srcu_idx & 1);

Good point, added and under test.

> Thanks
> Neeraj
> 
> > @@ -114,7 +115,7 @@ void srcu_drive_gp(struct work_struct *wp)
> >   	struct srcu_struct *ssp;
> >   	ssp = container_of(wp, struct srcu_struct, srcu_work);
> > -	if (ssp->srcu_gp_running || !READ_ONCE(ssp->srcu_cb_head))
> > +	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
> >   		return; /* Already running or nothing to do. */
> >   	/* Remove recently arrived callbacks and wait for readers. */
> > @@ -147,13 +148,18 @@ void srcu_drive_gp(struct work_struct *wp)
> >   	 * straighten that out.
> >   	 */
> >   	WRITE_ONCE(ssp->srcu_gp_running, false);
> > -	if (READ_ONCE(ssp->srcu_cb_head))
> > +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
> >   		schedule_work(&ssp->srcu_work);
> >   }
> >   EXPORT_SYMBOL_GPL(srcu_drive_gp);
> >   static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> >   {
> > +	unsigned short cookie;
> > +
> > +	cookie = get_state_synchronize_srcu(ssp);
> > +	if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
> > +		WRITE_ONCE(ssp->srcu_idx_max, cookie);
> 
> Minor: Maybe we can return in the else part of USHORT_CMP_LT check, to avoid
> scheduling work?

How about like this?

	static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
	{
		unsigned short cookie;

		cookie = get_state_synchronize_srcu(ssp);
		if (USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie))
			return;
		WRITE_ONCE(ssp->srcu_idx_max, cookie);
		if (!READ_ONCE(ssp->srcu_gp_running)) {
			if (likely(srcu_init_done))
				schedule_work(&ssp->srcu_work);
			else if (list_empty(&ssp->srcu_work.entry))
				list_add(&ssp->srcu_work.entry, &srcu_boot_list);
		}
	}

Testing this next.  ;-)

							Thanx, Paul

> Thanks
> Neeraj
> 
> >   	if (!READ_ONCE(ssp->srcu_gp_running)) {
> >   		if (likely(srcu_init_done))
> >   			schedule_work(&ssp->srcu_work);
> > @@ -196,6 +202,48 @@ void synchronize_srcu(struct srcu_struct *ssp)
> >   }
> >   EXPORT_SYMBOL_GPL(synchronize_srcu);
> > +/*
> > + * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
> > + */
> > +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> > +{
> > +	unsigned long ret;
> > +
> > +	barrier();
> > +	ret = (READ_ONCE(ssp->srcu_idx) + 3) & ~0x1;
> > +	barrier();
> > +	return ret & USHRT_MAX;
> > +}
> > +EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
> > +
> > +/*
> > + * start_poll_synchronize_srcu - Provide cookie and start grace period
> > + *
> > + * The difference between this and get_state_synchronize_srcu() is that
> > + * this function ensures that the poll_state_synchronize_srcu() will
> > + * eventually return the value true.
> > + */
> > +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
> > +{
> > +	unsigned long ret = get_state_synchronize_srcu(ssp);
> > +
> > +	srcu_gp_start_if_needed(ssp);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
> > +
> > +/*
> > + * poll_state_synchronize_srcu - Has cookie's grace period ended?
> > + */
> > +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> > +{
> > +	bool ret = USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx), cookie);
> > +
> > +	barrier();
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
> > +
> >   /* Lockdep diagnostics.  */
> >   void __init rcu_scheduler_starting(void)
> >   {
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
