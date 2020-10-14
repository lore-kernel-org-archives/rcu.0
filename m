Return-Path: <SRS0=yvZM=DV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02983C43457
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B99721582
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q5ckBsp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgJNPX2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgJNPX2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 11:23:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F1C0613D2
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 08:23:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so5649484ilh.3
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szd0g0zwvg2FI8rW+wf0U1J1vJOPGaW1OmCcCHcCUwY=;
        b=q5ckBsp6Poz8C21IojUpLpxpbax+aoS3PdNVnr527AIZZ47KT/qDonEY5jQJHcUrX1
         jAs/ZjC/NEXj3fN4U29vfbHKNsbT2oL65U8gQPCELNyMSiGYcpjYc+Y/H0bJ3ucBQwbN
         YTOHkPKL+t3dTpkxHKhLeTsyw08maJPffLIl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szd0g0zwvg2FI8rW+wf0U1J1vJOPGaW1OmCcCHcCUwY=;
        b=T0NtipVNx+xGKx/ux+g+a4XHoAIKMtul9a+GTD9u0rp1xTyC/r3oLW1vcKzFCpvfHQ
         kjV6bhRts616VBSz9zR8oY92u33EYH9hqtix3FXviH75IN7aQMyjCIP4WHPNrb2M4xpH
         jiJ/I9v4MnnfEc5xKJSIzER9lK5eAuaJ+fwMYIj4M9eMZwViuPXDnvoZhSea+423mKja
         8TDF1aGe1wmEXxMo4CwRlnNwmDnOVEuniFIupwY5QrrPLDMnWlPWSQ5k5pnEL8rMXSKR
         +Gb0zOYJWnzo0p0No1EsXxkPRgiT3MOWyTaHFKkSWLt7gT4o6ZX89hPtw70+PfSul7V0
         5qAA==
X-Gm-Message-State: AOAM53022NsvYHEOWQS7FXmF+7sfpc7eM0NnbhOEDxdal+HFqixHI75c
        3//onQHBKhdULz/a0tJgM0KoJg==
X-Google-Smtp-Source: ABdhPJwKFwY4Y40lYpEtKazaOfiZICAedq86otl0UgiOv8c7x5xGux6l2NHGYe6TmUS3d++Yd4BK1A==
X-Received: by 2002:a92:ca92:: with SMTP id t18mr4372860ilo.287.1602689007756;
        Wed, 14 Oct 2020 08:23:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id o17sm2935961ioa.3.2020.10.14.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:23:27 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:23:26 -0400
From:   joel@joelfernandes.org
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
Message-ID: <20201014152326.GA4022964@google.com>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-2-joel@joelfernandes.org>
 <e05fbdf4-546e-4d41-bac0-aa438bc0afcd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05fbdf4-546e-4d41-bac0-aa438bc0afcd@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 14, 2020 at 08:36:16PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 9/23/2020 8:52 PM, Joel Fernandes (Google) wrote:
> > Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> > to know how many CBs are executed. This fields counts down from 0 as CBs are
> > dequeued.  It is possible that all CBs could not be run because of reaching
> > limits in which case the remaining unexecuted callbacks are requeued in the
> > CPU's segcblist.
> > 
> > The number of callbacks that were not requeued are then the negative count (how
> > many CBs were run) stored in the rcl->len which has been counting down on every
> > dequeue. This negative count is then added to the per-cpu segmented callback
> > list's to correct its count.
> > 
> > Such a design works against future efforts to track the length of each segment
> > of the segmented callback list. The reason is because
> > rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> > list's length field (rcl->len) during extraction.
> > 
> > Also, the design of counting down from 0 is confusing and error-prone IMHO.
> > 
> > This commit therefore explicitly counts have many callbacks were executed in
> > rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> > field, without relying on the negativity of rcl->len.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   kernel/rcu/rcu_segcblist.c | 2 +-
> >   kernel/rcu/rcu_segcblist.h | 1 +
> >   kernel/rcu/tree.c          | 9 ++++-----
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 2d2a6b6b9dfb..bb246d8c6ef1 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> >    * This increase is fully ordered with respect to the callers accesses
> >    * both before and after.
> >    */
> > -static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> > +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> >   {
> >   #ifdef CONFIG_RCU_NOCB_CPU
> >   	smp_mb__before_atomic(); /* Up to the caller! */
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 5c293afc07b8..b90725f81d77 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
> >   }
> >   void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
> > +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
> >   void rcu_segcblist_init(struct rcu_segcblist *rsclp);
> >   void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
> >   void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 7623128d0020..50af465729f4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2427,7 +2427,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   			       rcu_segcblist_is_offloaded(&rdp->cblist);
> >   	struct rcu_head *rhp;
> >   	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> > -	long bl, count;
> > +	long bl, count = 0;
> >   	long pending, tlimit = 0;
> >   	/* If no callbacks are ready, just return. */
> > @@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >   		rcu_callback_t f;
> > +		count++;
> >   		debug_rcu_head_unqueue(rhp);
> >   		rcu_lock_acquire(&rcu_callback_map);
> > @@ -2485,9 +2486,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   		/*
> >   		 * Stop only if limit reached and CPU has something to do.
> > -		 * Note: The rcl structure counts down from zero.
> >   		 */
> > -		if (-rcl.len >= bl && !offloaded &&
> > +		if (count >= bl && !offloaded &&
> >   		    (need_resched() ||
> >   		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
> >   			break;
> 
> Update below usage of -rcl.len also?
> 
> if (likely((-rcl.len & 31) || local_clock() < tlimit))

Yes, you are right. I need to change that as well, will do. Thanks!

thanks,

 - Joel

