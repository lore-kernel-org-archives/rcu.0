Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A676C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 00:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAD5208D5
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 00:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sQvQZoEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFSAEp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFSAEo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 20:04:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356EBC0613EE
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 17:04:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so5980130qtn.2
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToOKmDB0PPlZ1lu0LM+fM2rdv8qIzF7rQ+sQoWFmjGI=;
        b=sQvQZoEkT662SPlpHgB3FFL4yhbCTg5Y+NSGXlU7FgJJpjM25AHSYRrVRyH/iAmbbp
         d9qHKQ5lpxE71wiwHBCW0IhDp6nz2SwmSdXLcDBlKmhEPLdUZ6zU9uzJHhmse2UgoTpy
         RpdluSqxUFPKNPQgAI8xZRd3GQlkq2EYjYcq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToOKmDB0PPlZ1lu0LM+fM2rdv8qIzF7rQ+sQoWFmjGI=;
        b=BSJtTYPlb4MVaQJj9bo17CFNb0vktBdlRgVZMP8dRhzFyYcfjmbpxsF0pErXiXewqC
         FW9924JsehUb2b432VRNabW9XS/C7p4uYstKr4P0ekqdbPA8Qbohj8ZFMkbEp6CdSnuc
         7ojreIKptdYDROIjQIvgsKf7HGxIVkpWOl7nA6EdN2yRTY91cru6/6pXMlVYXwzq2cD7
         jzUAcZpsOSAgbgKt0HFqYm3jKcHUbuLkmFhlvlR1FK5jk5aabCiqz0aOkz2e49o7dZFU
         v+y8uTkrnuFmxZFx9g50PEL/jqqpbf0RZmpxSw2nBoO5GhPzJkAbYRaJinqgMsJS8G9G
         WAEw==
X-Gm-Message-State: AOAM531CM32lZaLWvfIeYeIAv9fVKMe309vcNPSmxCK1yFQtELcBE9vG
        w45r+tUGpsrYynOffQpWMx09iQ==
X-Google-Smtp-Source: ABdhPJxkk3n6HaOUEBrNDyh45U7Jx5SnXX3VnaWxE9yIszQJWi2vaqY5WD2xk/axxaYBiQ51wrtskg==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr897637qtp.221.1592525082724;
        Thu, 18 Jun 2020 17:04:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g132sm4317806qkb.78.2020.06.18.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 17:04:42 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:04:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/7] rcu/segcblist: Prevent useless GP start if no CBs to
 accelerate
Message-ID: <20200619000441.GE40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618221119.GX2723@paulmck-ThinkPad-P72>
 <20200618230934.GA31937@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618230934.GA31937@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:09:34PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 03:11:19PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 18, 2020 at 04:29:49PM -0400, Joel Fernandes (Google) wrote:
> > 
> > First, this looks like a very nice optimization, thank you!

Thanks!

> > > Cc: urezki@gmail.com
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> As discussed over IRC, I updated the patch as shown below.  Does that
> work for you?

Yes, that works for me. Thanks!

 - Joel


> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit ec037e1f438074eb16fd68a63d699fc419c9ba0c
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Thu Jun 18 16:29:49 2020 -0400
> 
>     rcu/segcblist: Prevent useless GP start if no CBs to accelerate
>     
>     The rcu_segcblist_accelerate() function returns true iff it is necessary
>     to request another grace period.  A tracing session showed that this
>     function unnecessarily requests grace periods.
>     
>     For exmaple, consider the following sequence of events:
>     1. Callbacks are queued only on the NEXT segment of CPU A's callback list.
>     2. CPU A runs RCU_SOFTIRQ, accelerating these callbacks from NEXT to WAIT.
>     3. Thus rcu_segcblist_accelerate() returns true, requesting grace period N.
>     4. RCU's grace-period kthread wakes up on CPU B and starts grace period N.
>     4. CPU A notices the new grace period and invokes RCU_SOFTIRQ.
>     5. CPU A's RCU_SOFTIRQ again invokes rcu_segcblist_accelerate(), but
>        there are no new callbacks.  However, rcu_segcblist_accelerate()
>        nevertheless (uselessly) requests a new grace period N+1.
>     
>     This extra grace period results in additional lock contention and also
>     additional wakeups, all for no good reason.
>     
>     This commit therefore adds a check to rcu_segcblist_accelerate() that
>     prevents the return of true when there are no new callbacks.
>     
>     This change reduces the number of grace periods (GPs) and wakeups in each
>     of eleven five-second rcutorture runs as follows:
>     
>     +----+-------------------+-------------------+
>     | #  | Number of GPs     | Number of Wakeups |
>     +====+=========+=========+=========+=========+
>     | 1  | With    | Without | With    | Without |
>     +----+---------+---------+---------+---------+
>     | 2  |      75 |      89 |     113 |     119 |
>     +----+---------+---------+---------+---------+
>     | 3  |      62 |      91 |     105 |     123 |
>     +----+---------+---------+---------+---------+
>     | 4  |      60 |      79 |      98 |     110 |
>     +----+---------+---------+---------+---------+
>     | 5  |      63 |      79 |      99 |     112 |
>     +----+---------+---------+---------+---------+
>     | 6  |      57 |      89 |      96 |     123 |
>     +----+---------+---------+---------+---------+
>     | 7  |      64 |      85 |      97 |     118 |
>     +----+---------+---------+---------+---------+
>     | 8  |      58 |      83 |      98 |     113 |
>     +----+---------+---------+---------+---------+
>     | 9  |      57 |      77 |      89 |     104 |
>     +----+---------+---------+---------+---------+
>     | 10 |      66 |      82 |      98 |     119 |
>     +----+---------+---------+---------+---------+
>     | 11 |      52 |      82 |      83 |     117 |
>     +----+---------+---------+---------+---------+
>     
>     The reduction in the number of wakeups ranges from 5% to 40%.
>     
>     Cc: urezki@gmail.com
>     [ paulmck: Rework commit log and comment. ]
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 9a0f661..2d2a6b6b9 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -475,8 +475,16 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	 * Also advance to the oldest segment of callbacks whose
>  	 * ->gp_seq[] completion is at or after that passed in via "seq",
>  	 * skipping any empty segments.
> +	 *
> +	 * Note that segment "i" (and any lower-numbered segments
> +	 * containing older callbacks) will be unaffected, and their
> +	 * grace-period numbers remain unchanged.  For example, if i ==
> +	 * WAIT_TAIL, then neither WAIT_TAIL nor DONE_TAIL will be touched.
> +	 * Instead, the CBs in NEXT_TAIL will be merged with those in
> +	 * NEXT_READY_TAIL and the grace-period number of NEXT_READY_TAIL
> +	 * would be updated.  NEXT_TAIL would then be empty.
>  	 */
> -	if (++i >= RCU_NEXT_TAIL)
> +	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
>  		return false;
>  
>  	/*
