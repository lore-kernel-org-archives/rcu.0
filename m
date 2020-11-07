Return-Path: <SRS0=tft6=EN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D24DC55178
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32F7206C0
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cWXvIhuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgKGACB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgKGACA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Nov 2020 19:02:00 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89263C0613CF
        for <rcu@vger.kernel.org>; Fri,  6 Nov 2020 16:02:00 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f93so2071126qtb.10
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2020 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJuHBWXfVUR2VpGW8qin4d4nr05UwHVX+y7b+Ih2Tds=;
        b=cWXvIhuXNGMUbEcOzb3Ek3iN8txwxYvHEyXPe0ycvxQPLcnGBnUAbQyJ92Olc+FlK4
         EAmZGFUdyO/gxcnN+n2X3DIjGGg5uC6yskbU1NZc5DvZqRONbZVDfmqqIXhFw00qTtDJ
         O26ri4xpFSysyc9hYq+7nN61leLr1kr/rgNsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJuHBWXfVUR2VpGW8qin4d4nr05UwHVX+y7b+Ih2Tds=;
        b=dYclUCws9bb/R+E47U7jApTOkluFo7K+vnrvo4UHZ7K0q1eGisFtHZZrmePbSm7Z3C
         lgldnCUqiAqqpT4qnL+Z5M7Wq/WzNhsxvUMvb1yKn++R2RtVwoeIUGHaQ+19O6FsyoDo
         2gZgTb0byP3IFIDAd0Gh7i7RWkRcTqjjA27pgwShsjMVx/xwCoFBs00Y2lcV2TWL9yro
         xMTzGmRoFAHWa1u54TBFKcBAnu9GYiEw9v9UD9D9WbuLXgZPr11+ppqEnDU1ndjQWaxQ
         MkEY6tV2Zb1+ki6mDmdb7/dZg+0L1cf4ibCE/A4MzxGyEp68cnNpdf44RvnJcitcENSF
         0wrQ==
X-Gm-Message-State: AOAM532rEpqSzq8F0PR9eI7kLE1ex6QT4TnPSsKyoMaGBcRytOs8spt4
        DhX+A2TNYz+bgJyhmkst4+L1Iw==
X-Google-Smtp-Source: ABdhPJwV4i6f7fIDCGwz93tCrdcND6g474ZLekR9RM2pa2tNZJFEoBFpFftUGeesIDfAgVW40KEU1Q==
X-Received: by 2002:ac8:41ce:: with SMTP id o14mr3904718qtm.294.1604707318819;
        Fri, 06 Nov 2020 16:01:58 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v14sm1599204qkb.15.2020.11.06.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:01:58 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:01:57 -0500
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
Subject: Re: [PATCH v9 2/7] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201107000157.GB1397669@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-3-joel@joelfernandes.org>
 <20201104170133.GI3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104170133.GI3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 09:01:33AM -0800, Paul E. McKenney wrote:

> A casual reader might be forgiven for being confused by the combination
> of "Return" in the above comment and the "void" function type below.
> So shouldn't this comment be something like "Add the specified number
> of callbacks to the specified segment..."?

You are right, sorry and will fix it.

> > @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
> >  
> >  	if (!rcu_segcblist_pend_cbs(rsclp))
> >  		return; /* Nothing to do. */
> > +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
> 
> This should be a "for" loop.  Yes, the number and names of the segments
> hasn't changed for a good long time, but nothing like code as above to
> inspire Murphy to more mischief.  :-/
> 
> Actually, why not put the summation in the existing "for" loop below?
> That would save a line of code in addition to providing less inspiration
> for Mr. Murphy.

I can do that. Actually Frederic suggested the same thing but I was reluctant
as I felt it did not give much LOC benefit. Will revisit it.

> 
> >  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
> >  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
> >  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> > -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> > +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
> >  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> > +		rcu_segcblist_set_seglen(rsclp, i, 0);
> > +	}
> >  }
> >  
> >  /*
> > @@ -345,7 +362,6 @@ void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
> >  				struct rcu_cblist *rclp)
> >  {
> >  	rcu_segcblist_add_len(rsclp, rclp->len);
> > -	rclp->len = 0;
> 
> You audited the callers, correct?

Yep.

thanks,

 - Joel

