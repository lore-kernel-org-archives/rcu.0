Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BEBC3E8C5
	for <rcu@archiver.kernel.org>; Sat, 28 Nov 2020 02:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61267207CD
	for <rcu@archiver.kernel.org>; Sat, 28 Nov 2020 02:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7VJC0J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgK1CRd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbgK1CQb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Nov 2020 21:16:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 019DE2075E;
        Sat, 28 Nov 2020 02:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606529770;
        bh=h2+SFNoZGvVhLeY8MFKtlEPg7MZ1iL3X0MusYLz4qn0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f7VJC0J0pYZrKxpgXOx0HVrRno2QpDiPqyy2jXU+mnZ/Z6kCpBll2bvLrM58p9Wa4
         +lkLQjdOO3RV6vAJse0K9eUz/ycFqwJfTbz/o/ICTySx/331kpbYZFA7NmDNPmRnW5
         CY1LelRZiPleLq2Kqbltdur6dB23MH6OKcBBZagc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C1BA435225F1; Fri, 27 Nov 2020 18:16:09 -0800 (PST)
Date:   Fri, 27 Nov 2020 18:16:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 tip/core/rcu 1/6] srcu: Make Tiny SRCU use multi-bit
 grace-period counter
Message-ID: <20201128021609.GX1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <@@@>
 <20201121005919.17152-1-paulmck@kernel.org>
 <f70d1032-8e0f-37bf-9ab0-33e85bc8643c@codeaurora.org>
 <20201123195543.GC1437@paulmck-ThinkPad-P72>
 <46f5137b-2450-2478-6274-157367264ce4@codeaurora.org>
 <28a22477-9fbd-603a-404c-1cf6e7cc18b5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28a22477-9fbd-603a-404c-1cf6e7cc18b5@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 25, 2020 at 10:03:26AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/24/2020 10:48 AM, Neeraj Upadhyay wrote:
> > 
> > 
> > On 11/24/2020 1:25 AM, Paul E. McKenney wrote:
> > > On Mon, Nov 23, 2020 at 10:01:13AM +0530, Neeraj Upadhyay wrote:
> > > > On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > 
> > > > > There is a need for a polling interface for SRCU grace periods.  This
> > > > > polling needs to distinguish between an SRCU instance being idle on the
> > > > > one hand or in the middle of a grace period on the other.  This commit
> > > > > therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
> > > > > a defacto boolean to a free-running counter, using the bottom bit to
> > > > > indicate that a grace period is in progress.  The second-from-bottom
> > > > > bit is thus used as the index returned by srcu_read_lock().
> > > > > 
> > > > > Link:
> > > > > https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> > > > > Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > > > [ paulmck: Fix __srcu_read_lock() idx computation Neeraj per
> > > > > Upadhyay. ]
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >    include/linux/srcutiny.h | 4 ++--
> > > > >    kernel/rcu/srcutiny.c    | 5 +++--
> > > > >    2 files changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > > > index 5a5a194..d9edb67 100644
> > > > > --- a/include/linux/srcutiny.h
> > > > > +++ b/include/linux/srcutiny.h
> > > > > @@ -15,7 +15,7 @@
> > > > >    struct srcu_struct {
> > > > >        short srcu_lock_nesting[2];    /* srcu_read_lock()
> > > > > nesting depth. */
> > > > > -    short srcu_idx;            /* Current reader array element. */
> > > > > +    unsigned short srcu_idx;    /* Current reader array
> > > > > element in bit 0x2. */
> > > > >        u8 srcu_gp_running;        /* GP workqueue running? */
> > > > >        u8 srcu_gp_waiting;        /* GP waiting for readers? */
> > > > >        struct swait_queue_head srcu_wq;
> > > > > @@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct
> > > > > srcu_struct *ssp)
> > > > >    {
> > > > >        int idx;
> > > > > -    idx = READ_ONCE(ssp->srcu_idx);
> > > > > +    idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> > > > >        WRITE_ONCE(ssp->srcu_lock_nesting[idx],
> > > > > ssp->srcu_lock_nesting[idx] + 1);
> > > > >        return idx;
> > > > >    }
> > > > 
> > > > Need change in idx calcultion in srcu_torture_stats_print() ?
> > > > 
> > > > static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> > > >    idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > > 
> > > Excellent point!  It should match the calculation in __srcu_read_lock(),
> > > shouldn't it?  I have updated this, thank you!
> > > 
> > >                             Thanx, Paul
> > > 
> > 
> > Updated version looks good!
> > 
> > 
> > Thanks
> > Neeraj
> > 
> 
> For the version in rcu -dev:
> 
> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

I applied all of these, thank you very much!

> Only minor point which I have is, the idx calculation can be made an inline
> func (though srcu_drive_gp() does not require a READ_ONCE for ->srcu_idx):
> 
> __srcu_read_lock() and srcu_torture_stats_print() are using
> 
> idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> 
> whereas srcu_drive_gp() uses:
> 
> idx = (ssp->srcu_idx & 0x2) / 2;

They do work on different elements of the various arrays.  Or do you
believe that the srcu_drive_gp() use needs adjusting?

Either way, the overhead of READ_ONCE() is absolutely not at all
a problem.  Would you like to put together a patch so that I can see
exactly what you are suggesting?

							Thanx, Paul

> Thanks
> Neeraj
> 
> > > > Thanks
> > > > Neeraj
> > > > 
> > > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > > index 6208c1d..5598cf6 100644
> > > > > --- a/kernel/rcu/srcutiny.c
> > > > > +++ b/kernel/rcu/srcutiny.c
> > > > > @@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
> > > > >        ssp->srcu_cb_head = NULL;
> > > > >        ssp->srcu_cb_tail = &ssp->srcu_cb_head;
> > > > >        local_irq_enable();
> > > > > -    idx = ssp->srcu_idx;
> > > > > -    WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> > > > > +    idx = (ssp->srcu_idx & 0x2) / 2;
> > > > > +    WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> > > > >        WRITE_ONCE(ssp->srcu_gp_waiting, true);  /*
> > > > > srcu_read_unlock() wakes! */
> > > > >        swait_event_exclusive(ssp->srcu_wq,
> > > > > !READ_ONCE(ssp->srcu_lock_nesting[idx]));
> > > > >        WRITE_ONCE(ssp->srcu_gp_waiting, false); /*
> > > > > srcu_read_unlock() cheap. */
> > > > > +    WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> > > > >        /* Invoke the callbacks we removed above. */
> > > > >        while (lh) {
> > > > > 
> > > > 
> > > > -- 
> > > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is
> > > > a member of
> > > > the Code Aurora Forum, hosted by The Linux Foundation
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
