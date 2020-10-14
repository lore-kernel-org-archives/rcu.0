Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0199C43457
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AC722254
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZbwezsZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgJOBeu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgJOBeh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:34:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662AFC051130
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 16:09:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k21so1739688ioa.9
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VlYh8IpMjSpLgC6jfmJ70HlIRZT1OO/j1CnQtObEEB0=;
        b=ZbwezsZw5b+/nzQ8uIZjoH990DBMnKpWDU0rvL3yajXwbQJX6uwp8Nf3gdx33A2I91
         3bWuUpKnYZY9gyn3+d6/kASHrqWDJUeOdYyqyGy+M3LK7fQOlrLy7YhJMdurnSNrAJCZ
         zPLQ2jU1hw2S4b1OmDgnddRj70CIhPAWt4BXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlYh8IpMjSpLgC6jfmJ70HlIRZT1OO/j1CnQtObEEB0=;
        b=B5gdln5V/jb7bHQM608ObuqSKspBgtOFIurqsKreC2OdkdfAiDvuF+1eugxOCeD+mj
         FQp0vRhTJZKzRUviWUe2AZAEQa4z41TM84RW4L1RiqJ6BlgKcIbZKyuTR/IzCWxaa2cq
         lG1msjGhS3hXFb8+qtq8MGyaDitnmnosx7k3W3wqtxbPNTgbFlv9ZtRYGXJo4YxQJnoB
         gtIz0QKWXoIjTE8cGhH9ZdMtbVRpRj2+MWu6nCogvqk1NHM2wPF4Ta8+d6OH6rPBH9IR
         BJMwOIn21Uf+Mv3FRL8qLoDLmtsyNpu1T0ka9cahLGWDquLo0m61+iZCGC+KiWPUZAv8
         F/dQ==
X-Gm-Message-State: AOAM5303Uy+JHglIxMVF4kiBhti7hLrUcwhAjuWde2eHSsm7Shsbw7FB
        5srSOK1gFV7lMlmcVjdqLxDb2g==
X-Google-Smtp-Source: ABdhPJyE4VIoq0r2bzarioS7PW3PqMOsuv4aIU5Y9NC0o0Rcgotd1AaPwZiRCui0vg85IOw5vb5wdg==
X-Received: by 2002:a5e:9319:: with SMTP id k25mr1243357iom.153.1602716943681;
        Wed, 14 Oct 2020 16:09:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c18sm974369iod.28.2020.10.14.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:09:02 -0700 (PDT)
Date:   Wed, 14 Oct 2020 19:09:02 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 2/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201014230902.GC4022964@google.com>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-3-joel@joelfernandes.org>
 <20201012232008.GA47577@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012232008.GA47577@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 13, 2020 at 01:20:08AM +0200, Frederic Weisbecker wrote:
> On Wed, Sep 23, 2020 at 11:22:09AM -0400, Joel Fernandes (Google) wrote:
> > +/* Return number of callbacks in a segment of the segmented callback list. */
> > +static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +	smp_mb__before_atomic(); /* Up to the caller! */
> > +	atomic_long_add(v, &rsclp->seglen[seg]);
> > +	smp_mb__after_atomic(); /* Up to the caller! */
> > +#else
> > +	smp_mb(); /* Up to the caller! */
> > +	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> > +	smp_mb(); /* Up to the caller! */
> > +#endif
> > +}
> 
> I know that these "Up to the caller" comments come from the existing len
> functions but perhaps we should explain a bit more against what it is ordering
> and what it pairs to.

Sure.

> Also why do we need one before _and_ after?

I removed these memory barriers since they should not be needed, I will
update it this way for v7.

> And finally do we have the same ordering requirements than the unsegmented len
> field?

Do you mean ordering for the rsclp->seglen ? Yes we need not have ordering
for that since there are no races AFAICS (all accesses have either IRQs are
disabled, or nocb lock is held for the offloaded case). If you meant
something else like rcl->len, let me know. AFAICS, we don't have ordering
needs for those. Further, current readers of ->seglen are only for tracing.
->seglen does not influence rcu_barrier yet.

> > +/* Move from's segment length to to's segment. */
> > +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> > +{
> > +	long len;
> > +
> > +	if (from == to)
> > +		return;
> > +
> > +	len = rcu_segcblist_get_seglen(rsclp, from);
> > +	if (!len)
> > +		return;
> > +
> > +	rcu_segcblist_add_seglen(rsclp, to, len);
> > +	rcu_segcblist_set_seglen(rsclp, from, 0);
> > +}
> > +
> [...]
> > @@ -245,6 +283,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> > +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> >  	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> 
> Since inc_len and even now inc_seglen have two full barriers embracing the add up,
> we can probably spare the above smp_mb()?

Good point, I'll remove it.

> >  	rhp->next = NULL;
> >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > @@ -274,27 +313,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> >  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> >  		if (rsclp->tails[i] != rsclp->tails[i - 1])
> >  			break;
> > +	rcu_segcblist_inc_seglen(rsclp, i);
> >  	WRITE_ONCE(*rsclp->tails[i], rhp);
> >  	for (; i <= RCU_NEXT_TAIL; i++)
> >  		WRITE_ONCE(rsclp->tails[i], &rhp->next);
> >  	return true;
> >  }
> >  
> > @@ -403,6 +437,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >  		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
> >  			break;
> >  		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> > +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
> 
> Do we still need the same amount of full barriers contained in add() called by move() here?
> It's called in the reverse order (write queue then len) than usual. If I trust the comment
> in rcu_segcblist_enqueue(), the point of the barrier is to make the length visible before
> the new callback for rcu_barrier() (although that concerns len and not seglen). But here
> above, the unsegmented length doesn't change. I could understand a write barrier between
> add_seglen(x, i) and set_seglen(0, RCU_DONE_TAIL) but I couldn't find a paired couple either.

I'm guessing since I removed the memory barriers from seglen updates, this is
resolved.

> >  	}
> >  
> >  	/* If no callbacks moved, nothing more need be done. */
> > @@ -423,6 +458,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >  		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> >  			break;  /* No more callbacks. */
> >  		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > +		rcu_segcblist_move_seglen(rsclp, i, j);
> 
> Same question here (feel free to reply "same answer" :o)

Same answer :P

So based on these and other comments, I will update the patches and send them
out shortly.

thanks,

 - Joel

