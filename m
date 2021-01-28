Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A97C433DB
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B937A60235
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhA1Pb4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhA1PbC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 10:31:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6C0C061573;
        Thu, 28 Jan 2021 07:30:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p21so8105968lfu.11;
        Thu, 28 Jan 2021 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+Hue0PWlTxdyWc5K6RSHcz9rExWoyGU+yGHd9hzTV0=;
        b=aOVKWLC/LNskFli8f/Sqb0ejCNpPOgvj4L+dRMZXBxLUD2ua5XcEr4YAs93zwtIhbp
         JK1172wcLyUJ1HAUgQcsSUqZtoAZANorPdQRa6eoIGGew3NI3ZVOBQQVbY8waDUhhRmA
         itMIsLiSp2JWeMazv5MczitXTQhUnEaoJA1ckuFeopYgdr1/dZ7DWwMnv20twYfuj+NC
         nQxDFNsLhnT++nhT+qLCxbgCsUocjYVRgTFxoEPx7sNM7VNBLnsq2bVGB6zcKOaLuHej
         XyQ2sqsyM8/UDlRu2AOmsv7QaCZtdZkiC1bSkoEOdkVLJWAuJakE798fAiXwsHHENJrC
         3y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+Hue0PWlTxdyWc5K6RSHcz9rExWoyGU+yGHd9hzTV0=;
        b=X62FrZBZ9Y9+/T2rJKARWIgidWJGoAOzyXTnmdVIPw+pyIBgv6kHdsdG5qoIqB0A/+
         ZT+fCl7j6xd5BPnNIYmwPTqiM/NDt1tvrqtDqHqghHc/OaG5m14HPa5mo/aVAE8m0FLD
         +1dguAy2y5BqlDErNXGynNaneAzq6NJ4KUm6FB2vP2a2Dl702vbAN6rcE3L0+2i6FSQL
         e6JNII3PQPfQtquwOBdgkWAbtl1bjgzYr/un10wOKfW+VT+IHuf9yj+btN2fBLahJb/7
         +ALbBlN/FVL565PnHC/DvJFxgvRybu5C2XpBj+LOESQbA3D3O1jTFvAGgxxCyvC84704
         yAnA==
X-Gm-Message-State: AOAM533Fib1FmWtlzxepvko2p6rLwWGTpCfvKACyUZAhgBcrPb1WxcKF
        x91+WCbDhqCCZSRud6UtuzI=
X-Google-Smtp-Source: ABdhPJy56uEiInFhFpbpttAzsRdD+R+o4+uVFk6y67VZEtJzVAKTz0VYUpxH6QPZcvuXH5mmH84K9g==
X-Received: by 2002:a05:6512:510:: with SMTP id o16mr7817099lfb.378.1611847820573;
        Thu, 28 Jan 2021 07:30:20 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t22sm689273lfk.128.2021.01.28.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 07:30:19 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Jan 2021 16:30:17 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20210128153017.GA2006@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
 <YBLVbZzy0KSONizm@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBLVbZzy0KSONizm@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 28, 2021 at 04:17:01PM +0100, Michal Hocko wrote:
> On Thu 28-01-21 16:11:52, Uladzislau Rezki wrote:
> > On Mon, Jan 25, 2021 at 05:25:59PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Jan 25, 2021 at 04:39:43PM +0100, Michal Hocko wrote:
> > > > On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > > > > > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > > > > > For a single argument we can directly request a page from a caller
> > > > > > > context when a "carry page block" is run out of free spots. Instead
> > > > > > > of hitting a slow path we can request an extra page by demand and
> > > > > > > proceed with a fast path.
> > > > > > > 
> > > > > > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > > > > > and that its fallback is the relatively high latency synchronize_rcu().
> > > > > > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > > > > > to allow limited sleeping within the memory allocator.
> > > > > > 
> > > > > > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > > > > > way to allocate without triggering the OOM killer. Is this really what
> > > > > > you need/want? Is __GFP_NORETRY too weak?
> > > > > > 
> > > > > Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> > > > > Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> > > > > point: https://www.spinics.net/lists/rcu/msg02856.html
> > > > > 
> > > > > <snip>
> > > > >     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> > > > >     further decisions based on instrumentation of the success rates of
> > > > >     these opportunistic allocations.
> > > > > <snip>
> > > > 
> > > > I completely agree with Johannes here.
> > > > 
> > > > > but for some reason, i can't find a tail or head of it, we introduced
> > > > > __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> > > > > What we would like to avoid.
> > > > 
> > > > Not that I object to this use but I think it would be much better to use
> > > > it based on actual data. Going along with it right away might become a
> > > > future burden to make any changes in this aspect later on due to lack of 
> > > > exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
> > > > try as hard as it can get without being really disruptive (like OOM
> > > > killing something). And your wording didn't really give me that
> > > > impression.
> > > > 
> > > Initially i proposed just to go with GFP_NOWAIT flag. But later on there
> > > was a discussion about a fallback path, that uses synchronize_rcu() can be
> > > slow, thus minimizing its hitting would be great. So, here we go with a
> > > trade off.
> > > 
> > > Doing it hard as __GFP_RETRY_MAYFAIL can do, is not worth(IMHO), but to have some
> > > light-wait requests would be acceptable. That is why __GFP_NORETRY was proposed.
> > > 
> > > There were simple criterias we discussed which we would like to achieve:
> > > 
> > > a) minimize a fallback hitting;
> > > b) avoid of OOM involving;
> > > c) avoid of dipping into the emergency reserves. See kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
> > > 
> > One question here. Since the code that triggers a page request can be
> > directly invoked from reclaim context as well as outside of it. We had
> > a concern about if any recursion is possible, but what i see it is safe.
> > The context that does it can not enter it twice:
> > 
> > <snip>
> >     /* Avoid recursion of direct reclaim */
> >     if (current->flags & PF_MEMALLOC)
> >         goto nopage;
> > <snip>
> 
> Yes this is a recursion protection.
> 
> > What about any deadlocking in regards to below following flags?
> > 
> > GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
> 
> and __GFP_NOMEMALLOC will make sure that the allocation will not consume
> all the memory reserves. The later should be clarified in one of your
> patches I have acked IIRC.
>
Yep, it is clarified and reflected in another patch you ACKed.

Thanks!

--
Vlad Rezki
