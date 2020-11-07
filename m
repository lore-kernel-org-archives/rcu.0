Return-Path: <SRS0=tft6=EN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C19C2D0A3
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2595120882
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oSk0+kOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgKGASt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGASt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Nov 2020 19:18:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C5C0613D2
        for <rcu@vger.kernel.org>; Fri,  6 Nov 2020 16:18:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so2103393qts.5
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2020 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEuB3gvASt9FZRX3Uf0tIzy1nrj8CxUyLUi9+Eco7Jk=;
        b=oSk0+kOVeFLyyilDKzK0YXNgJa+Bez2dGaVLQx+TbXj2QO8QIneSuhsQrRfpmhbZbP
         X1Wjj4NUit8vlY8R86LNzlPkbZGA1c3lv+cuX7Ei239fxXRASiqq1ggatTefjoc/M7Ts
         HyOcfhemDcEFFFO7Be7f7bK9UqGtP7fUIESWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEuB3gvASt9FZRX3Uf0tIzy1nrj8CxUyLUi9+Eco7Jk=;
        b=O9e6g5tT0AAFQLkYVs+p/L9USw1Urhfu9sTeSLs9oXgEST6t6YLmNaRdfz81WrRDpr
         467JIOnLo6GIJRRoun35nY25ggBNBKRYw/HDJDSjBugGZql7gsPCFheJj7JkZ5htYj1s
         w+SrNHUZ79b9vg/XhtAL1QQXfp2V4AQTNfQtoWb9UIe0HLImf+V9Lxcd+nz2fi7Uplwb
         rUGRPKCRw1dXj6PHpFG+ivVcVecmry8lAYgJwRFEKnupOXRViODirOVoEs6+Ek4q+m0g
         lB1nuuFZxfVUuIVEFmnqFbmawkl/bq+oIrWf01HT3gR5cewhtY81U7T1eIJVFbDtxhWs
         hoag==
X-Gm-Message-State: AOAM533KMnUHcMQYUvfwsXqF6t4R9qTUdXf4EXor7nXgCKfFVvgRBjkE
        CcJ4oDcrllZdpHuh1BnGDkCCHg==
X-Google-Smtp-Source: ABdhPJyHhJKcS7H8fFVU8az99zO5YCIijZGYlNG+FPxC9qpuZZLqmnwG0NhmCgqyl7lrv8RbZLlj/w==
X-Received: by 2002:ac8:7b3a:: with SMTP id l26mr3143780qtu.42.1604708328818;
        Fri, 06 Nov 2020 16:18:48 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n35sm1714123qtc.55.2020.11.06.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:18:48 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:18:47 -0500
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
Message-ID: <20201107001847.GD1397669@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-3-joel@joelfernandes.org>
 <20201104170133.GI3249@paulmck-ThinkPad-P72>
 <20201107000157.GB1397669@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107000157.GB1397669@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 06, 2020 at 07:01:57PM -0500, Joel Fernandes wrote:
> On Wed, Nov 04, 2020 at 09:01:33AM -0800, Paul E. McKenney wrote:
> 
> > A casual reader might be forgiven for being confused by the combination
> > of "Return" in the above comment and the "void" function type below.
> > So shouldn't this comment be something like "Add the specified number
> > of callbacks to the specified segment..."?
> 
> You are right, sorry and will fix it.
> 
> > > @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
> > >  
> > >  	if (!rcu_segcblist_pend_cbs(rsclp))
> > >  		return; /* Nothing to do. */
> > > +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> > > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> > > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
> > 
> > This should be a "for" loop.  Yes, the number and names of the segments
> > hasn't changed for a good long time, but nothing like code as above to
> > inspire Murphy to more mischief.  :-/
> > 
> > Actually, why not put the summation in the existing "for" loop below?
> > That would save a line of code in addition to providing less inspiration
> > for Mr. Murphy.
> 
> I can do that. Actually Frederic suggested the same thing but I was reluctant
> as I felt it did not give much LOC benefit. Will revisit it.

It reduces 1 line of code :) I changed it to the below, will update the patch:

---8<-----------------------

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9b43d686b1f3..bff9b2253e50 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -101,7 +101,7 @@ static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long
 	WRITE_ONCE(rsclp->seglen[seg], v);
 }
 
-/* Return number of callbacks in a segment of the segmented callback list. */
+/* Increase the numeric length of a segment by a specified amount. */
 static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
 {
 	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
@@ -406,13 +406,12 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
-	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
-		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
-		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
+	rclp->len = 0;
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
 	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
+		rclp->len += rcu_segcblist_get_seglen(rsclp, i);
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
