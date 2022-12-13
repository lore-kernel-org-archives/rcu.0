Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CBC4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 12:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLMMvj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 07:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiLMMvi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 07:51:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7181B7B8
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 04:51:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3403774pjs.4
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMjlhY2WMnzt0k5wqAXP7Nzf1qXBAqwVcOh261rPEc4=;
        b=cu2F6RFt9Anufse8IPlPJMJuhp//j1qiG97iA3GX/ABAKLhjPekFh0a8KULJgmGFEy
         E0bnJlW6wbzInHqCMnKXs9AL5EqF16SZkxMi/XdE5oh3V0qjita0o5Ih7tmIM/jIga+s
         r8ewveCY2PWpxHPe3rxYCbkFl4wHiEkrVko9RfPp95SapMYeOdPVMLs3cIW4rKttoeeh
         QSORBV7U1YxUJSTwpNV7Yf4PJuDh9CrVIdnjyeODEdPEdw+vzWDxkso3TXDCBMa/St8u
         oeJFxP1EGLTeNelTkOi+PgPonXxcbY7kCVhW1z7ckBPljsnokhGjB68r7TRLsVpKbf59
         kxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMjlhY2WMnzt0k5wqAXP7Nzf1qXBAqwVcOh261rPEc4=;
        b=x0dtYFH9bYacxzgcu/YP5g2g+vOtyuqeHz8TfpWu6H6CruGISr55Ch74t5Wn9TTG7y
         3xT/jaUgzki5O+DMWLazgfGun7OO9NCsZ/PtizM34Rds/hTH7AZtJwL6DqREkEy6Y1Yj
         UitFIYppCFFTBKneOrBa0S417K2/BEUkT8HBJesZlaWBDWw0Cn6YEqvm3DDhp4/VfY6c
         uPbN/5ifTeN2zUyRMZvHLW6X7txGGZHhtduRPSVgdSwBHH12vVuwd0c7Adqjnbzwle9x
         ExCjODqvoxVBOYYqHpMJeBE0PUaawHMaMKjk63b3Fa6i38gMfkzvgMXYxXhrbxP1vro8
         nahA==
X-Gm-Message-State: ANoB5pkGhKpv8zC+LQ5u8vimiTdt4KCutJcW9CfuUGQtl6ZKVVKSUiHl
        LVANKRGUUekG7fEIrBgxzg==
X-Google-Smtp-Source: AA0mqf5VXCGLinWUq/hq7o7CTzN2U60PVrXk8mUVgCTOqDH90BGOeIt9EvaD67HYWKbyq+12Ao1DUg==
X-Received: by 2002:a17:902:e94c:b0:188:bd82:2b7c with SMTP id b12-20020a170902e94c00b00188bd822b7cmr22066461pll.5.1670935897065;
        Tue, 13 Dec 2022 04:51:37 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001782aab6318sm8352216pln.68.2022.12.13.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:51:36 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:51:29 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <piliu@redhat.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCHv2] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Message-ID: <Y5h1USSj0lqahJPN@piliu.users.ipa.redhat.com>
References: <20221128082816.28518-2-kernelfans@gmail.com>
 <20221130033459.16372-1-piliu@redhat.com>
 <20221202221713.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202221713.GH4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sorry to reply late. I was interrupted by something else.

On Fri, Dec 02, 2022 at 02:17:13PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2022 at 11:34:59AM +0800, Pingfan Liu wrote:
> > From: Pingfan Liu <kernelfans@gmail.com>
> > 
> > The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> > And it is not needed. Because counter_wrap_check has guarantee that both
> > srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> > srcu_gp_seq and no false alarm will be raised by the statement in
> > srcu_gp_start_if_needed()
> > 
> >   ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> > 
> > As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> > used immediately, not need to wait for another srcu_gp_end() to update
> > the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
> 
> During the SRCU_SIZE_WAIT_BARRIER state, all callbacks are queued onto
> the boot CPU's callback list, but the srcu_barrier() function scans all
> of the CPUs' callback lists.
> 

So at present, your concern is around how it affects srcu_barrier(), right?

> So can't this cause srcu_gp_start_if_needed() to rcu_segcblist_advance()
> and rcu_segcblist_accelerate() a callback list that is guaranteed to be
> empty?  Without this change, the might-not-be-empty boot CPU's callback
> list is dealt with.
> 

Is it a problem that srcu_gp_start_if_needed() asks
rcu_segcblist_advance() and rcu_segcblist_accelerate() to manipulate an
not-be-empty callback list ? At SRCU_SIZE_WAIT_BARRIER state,
srcu_barrier() will take care of all cpus' callback list.

> What am I missing here?  More specifically, what benefits does this
> change provide?  I am not yet seeing any.
> 

I am trying to improve the note around SRCU_SIZE_xx, and this is a
trivial improve from 8 SRCU_SIZE state to 5.


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
> > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > To: rcu@vger.kernel.org
> > ---
> > v1 -> v2:
> >  rebase onto dev branch
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index b25f77df9e5e..b0278d1e9c1f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1165,7 +1165,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  	 */
> >  	idx = __srcu_read_lock_nmisafe(ssp);
> >  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > +	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> >  		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> >  	else
> >  		sdp = raw_cpu_ptr(ssp->sda);
> > -- 
> > 2.31.1
> > 
