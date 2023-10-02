Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4332BE7849A
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjJBKlu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjJBKlu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 06:41:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1409D
        for <rcu@vger.kernel.org>; Mon,  2 Oct 2023 03:41:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F163C433C8;
        Mon,  2 Oct 2023 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696243306;
        bh=cHFxctUbp7slJe+QIIY4cuHRN8u7G6QJM3HO4/nr07E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9ZfkEyypOZ83qwdsbDruPR4KazQXZD2xEHQFL1cG5wPzK8lw5yVkWszaugB5/IZz
         QI8HsM3A/B/iuDQF4ijFHgEzX344l2oGYRGXJgFvw5icyAZwpG3lSK0x+6XX1I9DeG
         ax5YluW/CdTPa++jhqNbmkPVeS1ue4CWDz1iwq2j4TUsJgF7ee0kCncpTf9PyCw6yh
         AD6mxiLlJikCIXvDIGgXbMgnwRETyAGKE7zQz667/TkrZccX3LkytNoq/gFoiQAwr5
         NXhHlNgCf4lCM/cNpx0fjPGQ99owvN9/CS0lvI8DWf8taHhLYdWz8Z4Wk6UMwhj2YG
         1UUQL2r7bOaag==
Date:   Mon, 2 Oct 2023 12:41:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRqeZ31cLs8bocBo@lothringen>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
 <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 02, 2023 at 07:47:55AM +0530, Neeraj upadhyay wrote:
> On Mon, Oct 2, 2023 at 4:02 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Sun, Oct 01, 2023 at 07:57:14AM +0530, Neeraj upadhyay a écrit :
> > >
> > > But "more" only checks for CBs in DONE tail. The callbacks which have been just
> > > accelerated are not advanced to DONE tail.
> > >
> > > Having said above, I am still trying to figure out, which callbacks
> > > are actually being pointed
> > > by NEXT tail. Given that __call_srcu() already does a advance and
> > > accelerate, all enqueued
> > > callbacks would be in either WAIT tail (the callbacks for current
> > > active GP) or NEXT_READY
> > > tail (the callbacks for next GP after current one completes). So, they
> > > should already have
> > > GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> > > Only case I can
> > > think of is, if current GP completes after we sample
> > > rcu_seq_current(&ssp->srcu_gp_seq) for
> > > rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail)
> > > and a new GP is started
> > > before we take snapshot ('s') of next GP  for
> > > rcu_segcblist_accelerate(), then the gp num 's'
> > > > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> > > if my understanding is correct here. Thoughts?
> > >
> > > __call_srcu()
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_gp_seq));
> > >         s = rcu_seq_snap(&ssp->srcu_gp_seq);
> > >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> >
> > Good point! This looks plausible.
> >
> > Does the (buggy) acceleration in srcu_invoke_callbacks() exists solely
> > to handle that case? Because then the acceleration could be moved before
> > the advance on callbacks handling, something like:
> >
> 
> I think we might need to accelerate after advance, as the  tail pointers
> (WAIT, NEXT_READY) can be non-empty and we will not be able to
> accelerate (and assign GP num) until we advance WAIT tail to DONE tail?

Right indeed! How about the following patch then, assuming that in SRCU:
1 enqueue == 1 accelerate and therefore it only makes sense
to accelerate on enqueue time and any other accelerate call is error prone.

I can't find a scenario where the second call below to accelerate (and thus also
the second call to advance) would fail. Please tell me if I'm missing something.
Also the role of the remaining advance in srcu_gp_start() is unclear to me...

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..5ac81ca10ec8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -782,8 +782,6 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
@@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
+	/*
+	 * Acceleration might fail if the preceding call to
+	 * rcu_segcblist_advance() also failed due to a prior grace
+	 * period seen incomplete before rcu_seq_snap(). If so then a new
+	 * call to advance will see the completed grace period and fix
+	 * the situation.
+	 */
+	if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {
+		rcu_segcblist_advance(&sdp->srcu_cblist,
+				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
+	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
 		needgp = true;
@@ -1692,6 +1701,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	ssp = sdp->ssp;
 	rcu_cblist_init(&ready_cbs);
 	spin_lock_irq_rcu_node(sdp);
+	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	if (sdp->srcu_cblist_invoking ||
@@ -1720,8 +1730,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 */
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
