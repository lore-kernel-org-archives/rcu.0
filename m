Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE719C433FE
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 09:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiKVJuz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiKVJug (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Nov 2022 04:50:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064952141
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:50:33 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 130so13870978pfu.8
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GQ+4QMY2u/Xmt9scHdTYRLLk9tLW+PvbAyHXQGmOiw=;
        b=Gq1sIfTdPAl4onlwqGb4bYOstf0tU72D8z/aON7pkcJgoep9e99NZdvCzfww1kfQGU
         Nn/AF7jy4l0DjBulnyRXah3oW/BDzBsWu5BzFd5O0yWvhCLIuxsZoNXxlAe+e3rH6MaV
         es+HYNDFqkpJ/fUz6v7Ocvm2UBhW+rteW82MhmWISZbJBTh6bujUZyUu6K9pINmeFmKZ
         DqksRaHGEiXNyEccVKKJzReazIywUsysEnNJiy1TNlsqW9B9MmJu2Xemcbif215bMpkJ
         /MrwGyvWI3LYcdv06QYN5GUIvJPNqNt09Q9omSy68DkPsffMez4P0FIUCDtBBBHbZV02
         HY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GQ+4QMY2u/Xmt9scHdTYRLLk9tLW+PvbAyHXQGmOiw=;
        b=iMLcrZbHUAPVCpehURowTgjYvyKkJXeZlVyvXbCs2HI6LNNnKkSWCyX4O7ZiIQ+g60
         rYrpw60LgZ8TOXrOQGEBJhu5tjeN76ejXL/+KA9lXWiaDe4sSiWT6q+rxrn2XQPr4Sh5
         fLpzoByNe+mO1b2HaMMkRqLHsCodqXw2T0UcRQACz387G8gnS9rGLGw9HK6ktGYwxYpB
         oSoQThz+0ehc/TleUt7gdMKRfmlQ53Xp2AvyYdNxKw/bzWOE2oTkLmj9TXqg+q3Or1l4
         9yRHfWOh5trHq9iK4vezfXs8B821P/BLrdhifrNaFApvOgzCgkA1HHs/I5TgsDpPZWMK
         fiTQ==
X-Gm-Message-State: ANoB5pkDUhFC9u1ArT3/NqA9Mii80tlI9YtsjuwAn8Rb8xQnmYxixLa+
        3rwU0xEFt2piuQ+bCtNeLg==
X-Google-Smtp-Source: AA0mqf6a5sv+qNDfXjideEoR9/OmqZ3wA5/54EhJyMODMSsHgoXkxNTkbKQFJsfJBgXxL+7vS0I9uA==
X-Received: by 2002:a63:180c:0:b0:476:848f:1ecd with SMTP id y12-20020a63180c000000b00476848f1ecdmr21388350pgl.589.1669110633156;
        Tue, 22 Nov 2022 01:50:33 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0017c37a5a2fdsm11529921plg.216.2022.11.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:50:32 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:50:26 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Message-ID: <Y3ybYubzvbmBFeah@piliu.users.ipa.redhat.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-2-kernelfans@gmail.com>
 <20221122011345.GS4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122011345.GS4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 21, 2022 at 05:13:45PM -0800, Paul E. McKenney wrote:
> On Sun, Nov 20, 2022 at 11:40:13AM +0800, Pingfan Liu wrote:
> > As the code changes, now, srcu_gp_start_if_needed() holds the srcu read
> > lock, gets the gp_seq snap and call srcu_funnel_gp_start() passing that
> > snap value.
> > 
> > As the rcu_seq_snap() promises "a full grace period has elapsed since
> > the current time".  In srcu_funnel_gp_start(), the statement
> >   rcu_seq_done(&ssp->srcu_gp_seq, s)
> > always return false.
> > 
> > The same condition stands for srcu_funnel_exp_start(). Hence removing
> > all the checks of rcu_seq_done().
> > 
> > Test info:
> >   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> > without any failure.
> 
> Nice catch!!!  And I do appreciate the testing.
> 
> But if we are going to do this, let's please also place lockdep assertions
> in srcu_funnel_exp_start() and srcu_funnel_gp_start() to verify that these
> functions are in fact invoked within an SRCU read-side critical section.
> Also a WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)), please.
> 

OK, I will do both.

> Things changed to make the rcu_seq_done() unnecessary, so they could just
> as easily change again.
> 

Yes. It is wise to prevent from the future variation.

Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1c304fec89c0..7df59fc8073e 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -851,8 +851,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
> >  	if (snp)
> >  		for (; snp != NULL; snp = snp->srcu_parent) {
> >  			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
> > -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
> > -			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
> > +			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
> >  				return;
> >  			spin_lock_irqsave_rcu_node(snp, flags);
> >  			sgsne = snp->srcu_gp_seq_needed_exp;
> > @@ -878,6 +877,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
> >   *
> >   * Note that this function also does the work of srcu_funnel_exp_start(),
> >   * in some cases by directly invoking it.
> > + *
> > + * The srcu read lock should be hold around this function. And s is a seq snap
> > + * after holding that lock.
> >   */
> >  static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  				 unsigned long s, bool do_norm)
> > @@ -898,8 +900,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  	if (snp_leaf)
> >  		/* Each pass through the loop does one level of the srcu_node tree. */
> >  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
> > -				return; /* GP already done and CBs recorded. */
> >  			spin_lock_irqsave_rcu_node(snp, flags);
> >  			snp_seq = snp->srcu_have_cbs[idx];
> >  			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > @@ -935,9 +935,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
> >  		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
> >  
> > -	/* If grace period not already done and none in progress, start it. */
> > -	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> > -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> > +	/* If grace period not already in progress, start it. */
> > +	if (rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> >  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> >  		srcu_gp_start(ssp);
> >  
> > -- 
> > 2.31.1
> > 
