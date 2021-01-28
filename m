Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847BBC433E9
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3369D64E02
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhA1PMl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhA1PMi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 10:12:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775FC061573;
        Thu, 28 Jan 2021 07:11:57 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b2so8071474lfq.0;
        Thu, 28 Jan 2021 07:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYUwfR//UNM7rH1VOEkn/K+30W18z8yGULkJIiL5QLc=;
        b=l2nO/0WO6oAnUY51rYxsB80i8T+XJ1gLQiINbegvpfOtC6kmQjay/cnYY4IuSUNMUP
         98iplaDKdkkr/kUAhU0fOs+7KJ90XM10QkoW/+12cbf4L8U1/tpHGTh5sJw4TCW63tD+
         Yny9zus3jnEzGzobQj2N8jm2iUM9rpeY7ncdGsDrGS7Bjl/9A3r3TmIpCuYw1P0izAdR
         wBO3ZbxMMEyxQePSZ3O4tmgdqQLypLSQn65vSxZfq/bR0pLbKZ2UbbIDG53XfmbQqtL0
         Mw4B7vSS84cXDmx6D00cNu0TWtLx4JrQbLGOFhKA37atT/puMLJlKJjRgz+DQvWTYAN/
         A3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYUwfR//UNM7rH1VOEkn/K+30W18z8yGULkJIiL5QLc=;
        b=pCx3CK080MOtlTl9bm84s3RabPQ1Ui+EFRG3N/szVEWUfwDCdBQIaC68G6qBv0e5f+
         kaFbdqXGFR537pXS9Xshqi3nJegFdfIzP+5LYx1I0PKyAQYL6rbEtIkg4bZJzSus9QJo
         4BljgxB2nnK9BlNQHYSOUv1lVbnS28R0D50gq696W1PixPjuLcTee/1HugnZjERlK/zw
         nYp6L3qQk/o2EuwXYC5fLRAnf4WK4rHSlsiNnM3v2EKuyraagwYsZYfRm0ZzUPExj8I5
         52pNyeL4PN+KxKrxGDf1PRnd2W7wsVv31g+pMfqUKmejktScjufXTOPPaN38pRNhadVZ
         3mVw==
X-Gm-Message-State: AOAM532pS6g5Z3KERsOJNN7rkT9MNCRGAc/kyhTt9iuf/r4e7VxvfHnP
        voGIcJyTu9QZ4VEoOhi5BWc=
X-Google-Smtp-Source: ABdhPJwwTqEF9wklNavo3L5y9Lt1QHNJzWUHVrPrxHKvLTIpS8M1c2jhRmWPLrV/DjXEe9IItQyP3w==
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr8223299lfq.220.1611846716011;
        Thu, 28 Jan 2021 07:11:56 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id r26sm1708382lfe.137.2021.01.28.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 07:11:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Jan 2021 16:11:52 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210128151152.GA1867@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125162559.GA52712@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 25, 2021 at 05:25:59PM +0100, Uladzislau Rezki wrote:
> On Mon, Jan 25, 2021 at 04:39:43PM +0100, Michal Hocko wrote:
> > On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > > > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > > > For a single argument we can directly request a page from a caller
> > > > > context when a "carry page block" is run out of free spots. Instead
> > > > > of hitting a slow path we can request an extra page by demand and
> > > > > proceed with a fast path.
> > > > > 
> > > > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > > > and that its fallback is the relatively high latency synchronize_rcu().
> > > > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > > > to allow limited sleeping within the memory allocator.
> > > > 
> > > > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > > > way to allocate without triggering the OOM killer. Is this really what
> > > > you need/want? Is __GFP_NORETRY too weak?
> > > > 
> > > Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> > > Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> > > point: https://www.spinics.net/lists/rcu/msg02856.html
> > > 
> > > <snip>
> > >     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> > >     further decisions based on instrumentation of the success rates of
> > >     these opportunistic allocations.
> > > <snip>
> > 
> > I completely agree with Johannes here.
> > 
> > > but for some reason, i can't find a tail or head of it, we introduced
> > > __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> > > What we would like to avoid.
> > 
> > Not that I object to this use but I think it would be much better to use
> > it based on actual data. Going along with it right away might become a
> > future burden to make any changes in this aspect later on due to lack of 
> > exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
> > try as hard as it can get without being really disruptive (like OOM
> > killing something). And your wording didn't really give me that
> > impression.
> > 
> Initially i proposed just to go with GFP_NOWAIT flag. But later on there
> was a discussion about a fallback path, that uses synchronize_rcu() can be
> slow, thus minimizing its hitting would be great. So, here we go with a
> trade off.
> 
> Doing it hard as __GFP_RETRY_MAYFAIL can do, is not worth(IMHO), but to have some
> light-wait requests would be acceptable. That is why __GFP_NORETRY was proposed.
> 
> There were simple criterias we discussed which we would like to achieve:
> 
> a) minimize a fallback hitting;
> b) avoid of OOM involving;
> c) avoid of dipping into the emergency reserves. See kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
> 
One question here. Since the code that triggers a page request can be
directly invoked from reclaim context as well as outside of it. We had
a concern about if any recursion is possible, but what i see it is safe.
The context that does it can not enter it twice:

<snip>
    /* Avoid recursion of direct reclaim */
    if (current->flags & PF_MEMALLOC)
        goto nopage;
<snip>

What about any deadlocking in regards to below following flags?

GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN

Thanks!

--
Vlad Rezki
