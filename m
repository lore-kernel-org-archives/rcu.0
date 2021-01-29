Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF8C433E0
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 16:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803EB64DD6
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhA2Qh2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Jan 2021 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhA2QgQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Jan 2021 11:36:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A0C061573;
        Fri, 29 Jan 2021 08:35:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a8so13317573lfi.8;
        Fri, 29 Jan 2021 08:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6fq8e4z28JlnpiCL40UdTorSI0TpSUjQk9y+4nElOw4=;
        b=YnNJodsq3OkuHPwUnfveUSab/+p6Dc2IGLiHHd6EhjSNy54bzYgheAlcyezq/Qw7IY
         YTxjd6i9AtiJW189vjS9zXjigcZDZ/a6iH2daYMOSxCmANSInncvlPEf8x2lxs9wO57l
         /z8Ys64b5KAopVTJDPr3CapUhiybk71C0dwS3Ly9oAb1hJpz1nrBzAupia7MX9slk7OE
         B8QDj8ARDYeTNE9eIebrQDPyl8vWeEkblY0Lu+dIWGtVDQPda8biwbbmafYjHTEQsVce
         8xfJPB+cNPUZOa70OXzHHtVuNmo/4Z1nWpi4WuPXyz4KizXS/jKVV5k4pz9q+BbTN3yG
         PC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6fq8e4z28JlnpiCL40UdTorSI0TpSUjQk9y+4nElOw4=;
        b=In+kCeLQKV1qHm2S39V4/zUcyjk1tnprJcEYYC3IXux56J5fyhL3ECHYR7TCod6XKN
         FR0bxx0yDvTMMseckLDRDCihaiz8p+UKGj2494Gj6sKHoN4G3MWz3VU487o60T8pRYzk
         GVEIFxqxNkH6qtfmx5k7BnonwtHkcQdO1SFrvhro8H6CRS2+kmcXj/EsnokLl1CXxA/+
         tgrzeWjb55+e2OZ5YHXJi8CTXQArP26LRbVoXwBd86/bfupjIG31Bs+BDxjXgDxK/CO9
         yAFvU1e7g6zGvbzQIEdKYSE5pIlzfvGm+6CQwDfYDn1vO0pRhmlkNelxmbS2CIyiqbIV
         6yzw==
X-Gm-Message-State: AOAM532dZMunTpM8Er+dj218c0MkBsG7vKoZ88IbAS2x9afSZIvDvxLQ
        iuSc/DqD3GFs8L09Z3E1pfhlsJbKC5tvEw==
X-Google-Smtp-Source: ABdhPJz6SmGqombELjjB+CHU7M8LtdnaXezweuOYRtkBycQH2JrZNPHgG1RM8+qv1UyTqCcVhex8zg==
X-Received: by 2002:a05:6512:3182:: with SMTP id i2mr2559396lfe.553.1611938134087;
        Fri, 29 Jan 2021 08:35:34 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id s2sm2071998lfr.107.2021.01.29.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 08:35:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 29 Jan 2021 17:35:31 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20210129163531.GA30500@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
 <YBLVbZzy0KSONizm@dhcp22.suse.cz>
 <20210128153017.GA2006@pc638.lan>
 <20210128180237.GA5144@pc638.lan>
 <YBPNvbJLg56XU8co@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBPNvbJLg56XU8co@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 29, 2021 at 09:56:29AM +0100, Michal Hocko wrote:
> On Thu 28-01-21 19:02:37, Uladzislau Rezki wrote:
> [...]
> > >From 0bdb8ca1ae62088790e0a452c4acec3821e06989 Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Wed, 20 Jan 2021 17:21:46 +0100
> > Subject: [PATCH v2 1/1] kvfree_rcu: Directly allocate page for single-argument
> >  case
> > 
> > Single-argument kvfree_rcu() must be invoked from sleepable contexts,
> > so we can directly allocate pages.  Furthermmore, the fallback in case
> > of page-allocation failure is the high-latency synchronize_rcu(), so it
> > makes sense to do these page allocations from the fastpath, and even to
> > permit limited sleeping within the allocator.
> > 
> > This commit therefore allocates if needed on the fastpath using
> > GFP_KERNEL|__GFP_NORETRY.
> 
> Yes, __GFP_NORETRY as a lightweight allocation mode should be fine. It
> is more robust than __GFP_NOWAIT on memory usage spikes.  The caller is
> prepared to handle the failure which is likely much less disruptive than
> OOM or potentially heavy reclaim __GFP_RETRY_MAYFAIL.
> 
> I cannot give you ack as I am not familiar with the code but this makes
> sense to me.
> 
No problem, i can separate it. We can have a patch on top of what we have so
far. The patch only modifies the gfp_mask passed to __get_free_pages():

From ec2feaa9b7f55f73b3b17e9ac372151c1aab5ae0 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Fri, 29 Jan 2021 17:16:03 +0100
Subject: [PATCH 1/1] kvfree_rcu: replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY

__GFP_RETRY_MAYFAIL is a bit heavy from reclaim process of view,
therefore a time consuming. That is not optional and there is
no need in doing it so hard, because we have a fallback path.

__GFP_NORETRY in its turn can perform some light-weight reclaim
and it rather fails under high memory pressure or low memory
condition.

In general there are four simple criterias we we would like to
achieve:
    a) minimize a fallback hitting;
    b) avoid of OOM invoking;
    c) do a light-wait page request;
    d) avoid of dipping into the emergency reserves.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 70ddc339e0b7..1e862120db9e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3489,8 +3489,20 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
+
+			// __GFP_NORETRY - allows a light-weight direct reclaim
+			// what is OK from minimizing of fallback hitting point of
+			// view. Apart of that it forbids any OOM invoking what is
+			// also beneficial since we are about to release memory soon.
+			//
+			// __GFP_NOMEMALLOC - prevents from consuming of all the
+			// memory reserves. Please note we have a fallback path.
+			//
+			// __GFP_NOWARN - it is supposed that an allocation can
+			// be failed under low memory or high memory pressure
+			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
-- 
2.20.1

--
Vlad Rezki
