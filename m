Return-Path: <SRS0=tft6=EN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475AC4741F
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D332C2085B
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wXIYaB5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKGA0J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGA0I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Nov 2020 19:26:08 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBCC0613D2
        for <rcu@vger.kernel.org>; Fri,  6 Nov 2020 16:26:06 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so2820058qkb.7
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2020 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KFCIKOtr8D20sOqDg+VtqMdBmuE8IZF7YxjxZvbO66w=;
        b=wXIYaB5JyJigBToTrk98QDXEreKm1YQNF4z1vvaZ9Pn7oLWmVqoiIIv2NXNNEK/vQ8
         oRkZJF7/bBYDbqGiS6+8qr9gEYnYaJzQyOc1biqlp21w504HrMaVbsQwuu/NIT6t+nb9
         FNgBvkSQr3O09VEMu9WvKxdEwwxPqowuxsrkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KFCIKOtr8D20sOqDg+VtqMdBmuE8IZF7YxjxZvbO66w=;
        b=Vlx+j3RI/+7V3dOOC5Btev1g9+/tJx7oOecp0VbPGx3Bv3DDu9Nzpj31IcMsFML0o1
         wDb0O1n0mUUP/cveI2Qy4XVn8SHFyEf4xCehTV4+xoFbnTsDNThtii//prQMS9Ue9SSn
         a9n6Ze8P183FFAKxRIdtYj2/9UUsrlL0jzMbInlIfaB20x+jtIl3slWc2VrAx1CsdikW
         +e8DEytlEnQDCHT00pND9LIpR4VhkanMKoLhrKE5D6M6jH9ZOWpmW+AJES5qW5SS8hzU
         WeVuWX02+6D+Tfw9wm8Srbn9oDrApmeJkjpefv+LeQ8wV0RMXgXRlVL/I2A/al9XERvk
         gkWw==
X-Gm-Message-State: AOAM532fATzb0Fj3x1+eaDttAT9kxX55GLO9E64QUWyugHdYR5JzZyQO
        2OxWWLGF/Ia5aWaYb8VWh8KPBw==
X-Google-Smtp-Source: ABdhPJyum+mcyXtTNBUZ8+Q8jvp4zJe7+aynEnSfGy66hxWa7tp7Wq3eaKUJWHBuUe1UVVUlHhlnuQ==
X-Received: by 2002:a05:620a:951:: with SMTP id w17mr4470185qkw.224.1604708765505;
        Fri, 06 Nov 2020 16:26:05 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x7sm1534652qtw.76.2020.11.06.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:26:04 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:26:04 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 6/7] rcu/tree: segcblist: Remove redundant smp_mb()s
Message-ID: <20201107002604.GA3144506@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-7-joel@joelfernandes.org>
 <20201105035713.GL3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105035713.GL3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 07:57:13PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2020 at 09:26:02AM -0500, Joel Fernandes (Google) wrote:
> > This memory barrier is not needed as rcu_segcblist_add_len() already
> > includes a memory barrier *before* and *after* the length of the list is
> > updated.
> > 
> > Same reasoning for rcu_segcblist_enqueue().
> 
> I suggest a commit log like the following:
> 
> ------------------------------------------------------------------------
> 
> The full memory barriers in rcu_segcblist_enqueue() and in rcu_do_batch()
> are not needed because rcu_segcblist_add_len(), and thus also
> rcu_segcblist_inc_len(), already includes a memory barrier *before*
> and *after* the length of the list is updated.
> 
> This commit therefore removes these redundant smp_mb() invocations.
> 
> ------------------------------------------------------------------------
> 
> Other than that, looks good!  I could hand-apply it, but that
> would just cause more churn with the addition of the call to
> rcu_segcblist_inc_seglen().  So could you please update the commit log
> when you repost, whether to the mailing list or from your git tree?

Done, I updated it in my tree. I will share the link to tree on IRC.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 1 -
> >  kernel/rcu/tree.c          | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index e9e72d72f7a6..d96272e8d604 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -268,7 +268,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> > -	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> >  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> >  	rhp->next = NULL;
> >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f6c6653b3ec2..fb2a5ac4a59c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  
> >  	/* Update counts and requeue any remaining callbacks. */
> >  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> > -	smp_mb(); /* List handling before counting for rcu_barrier(). */
> >  	rcu_segcblist_add_len(&rdp->cblist, -count);
> >  
> >  	/* Reinstate batch limit if we have worked down the excess. */
> > -- 
> > 2.29.1.341.ge80a0c044ae-goog
> > 
