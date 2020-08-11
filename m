Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4335C433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DE32076B
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJBwH5fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHKJSN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHKJSM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 05:18:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B010C06174A;
        Tue, 11 Aug 2020 02:18:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so12724731ljc.3;
        Tue, 11 Aug 2020 02:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rc2k0yMpOdSHkseT6oPEXxwHuzZlfRokXZB8zKwWVMU=;
        b=gJBwH5fP5BWi29W99iFxYmFcTLFS0V/Nap1R5fSSC1C5baTO1zsB8AQBWWKj4ilX54
         Ec05PNjgmtEynrpEss9CKT3go/P8VILxR+O9+EwHtU/BLjn+9Q+GQsm59lUL5l6Jb50G
         caf2JuqTu/vVr397vf65bsb/Tyv8qVZIqpvnHRjLEy3zo84FDN0WSBZ4LAmKloDgcHde
         sRWd+hSJjVZmMkeQ/slssOSM5YhKTAeL28VbNPBI9hGEIp4MZSrx6amPpQHzv2G4bUWy
         4ZcAl/cfipW2i+am73SIBbGJopgI3AcnT0tQ2HE/00G+RNCv/W4qTO23wlHEFS/vk37p
         JTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rc2k0yMpOdSHkseT6oPEXxwHuzZlfRokXZB8zKwWVMU=;
        b=S36VlQQ/aX+A/Sx7p24KfrkFDLJYbHNUjkOS7nyU4aezLQvN+3YlntnFshmWr9/0Zd
         MvtX9kgxrpH5RnCG2sUCemZyYb+NVqDwArwmDnxF88S79RW+QIrtPVuQCND7rhsu5ZVk
         fcCUm1CSA1Ks/SJmnFUclqjzTAQFl3yrHTY1EgM99A8fNXiMmn1Rx0LA2WVwktzNHoi8
         /phoKtYf8tyDfiygJgOTgGg6PujjJVRZnyrgGyZxY2vQNgbICs0d9HD39SaRRVbvQCxg
         9XVjq+n8sn9TSQKmJKVsi6YM79aZOEk6S80RpXvzfqar1QAZyqXTSXzf4xpvXOwBOzk6
         5D2w==
X-Gm-Message-State: AOAM530UgeD6obSMVF+w+uMFluZkDznfyTBLHwjld4chC+2L60SuzRdX
        AOq3R+OCv9gMsFaOw6dPkkg=
X-Google-Smtp-Source: ABdhPJwUokTJiYEOYi5f6SL0zm+V9uMIpcGHyGrrtUyI6vBfULNt8i7g+WR1f/oGMPahxlXqecMvSA==
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr2586384ljb.452.1597137490384;
        Tue, 11 Aug 2020 02:18:10 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g21sm9947885ljh.103.2020.08.11.02.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:18:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Aug 2020 11:18:07 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811091807.GA2634@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810192525.GG4773@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 10, 2020 at 09:25:25PM +0200, Michal Hocko wrote:
> On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
> > > [...]
> > > > Limitations and concerns (Main part)
> > > > ====================================
> > > > The current memmory-allocation interface presents to following
> > > > difficulties that this patch is designed to overcome:
> > > > 
> > > > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> > > >    complain about violation("BUG: Invalid wait context") of the
> > > >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> > > >    checks, i.e. it is not legal to acquire a spinlock_t while
> > > >    holding a raw_spinlock_t.
> > > > 
> > > >    Internally the kfree_rcu() uses raw_spinlock_t(in rcu-dev branch)
> > > >    whereas the "page allocator" internally deals with spinlock_t to
> > > >    access to its zones. The code also can be broken from higher level
> > > >    of view:
> > > >    <snip>
> > > >        raw_spin_lock(&some_lock);
> > > >        kfree_rcu(some_pointer, some_field_offset);
> > > >    <snip>
> > > 
> > > Is there any fundamental problem to make zone raw_spin_lock?
> > > 
> > Good point. Converting a regular spinlock to the raw_* variant can solve 
> > an issue and to me it seems partly reasonable. Because there are other
> > questions if we do it:
> > 
> > a) what to do with kswapd and "wake-up path" that uses sleepable lock:
> >     wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> 
> If there is no RT friendly variant for waking up process from the atomic
> context then we might need to special case this for the RT tree.
> 
I do not see it in RT kernel. The waiting primitives, see the wait.c,
use sleepable locks all over the file.

> > b) How RT people reacts on it? I guess they will no be happy.
> 
> zone->lock should be held for a very limited amount of time.
> 
> > As i described before, calling the __get_free_page(0) with 0 as argument
> > will solve the (a). How correctly is it? From my point of view the logic
> > that bypass the wakeup path should be explicitly defined.
> 
> gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
> doesn't wake up kswapd. So if the wakeup is a problem then this would be
> a way to go.
> 
What do you mean Michal? gfp_mask 0 != GFP_NOWAIT:

#define GFP_NOWAIT (__GFP_KSWAPD_RECLAIM)

it does wakeup of the kswapd. Or am i missing something? Please comment.
If we are about to avoid the kswapd, should we define something special?

#define GFP_NOWWAKE_KSWAPD 0

> > Or we can enter the allocator with (__GFP_HIGH|__GFP_ATOMIC) that bypass
> > the __GFP_KSWAPD_RECLAIM as well.
> 
> This would be an alternative which consumes memory reserves. Is this
> really needed for the particular case?
> 
No. That was just another example illustrating how to bypass the
__GFP_KSWAPD_RECLAIM.

> > 
> > Any thoughts here? Please comment.
> > 
> > Having proposed flag will not heart RT latency and solve all concerns.
> > 
> > > > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> > > >    is converted into sleepable variant. Invoking the page allocator from
> > > >    atomic contexts leads to "BUG: scheduling while atomic".
> > > 
> > > [...]
> > > 
> > > > Proposal
> > > > ========
> > > > 1) Make GFP_* that ensures that the allocator returns NULL rather
> > > > than acquire its own spinlock_t. Having such flag will address a and b
> > > > limitations described above. It will also make the kfree_rcu() code
> > > > common for RT and regular kernel, more clean, less handling corner
> > > > cases and reduce the code size.
> > > 
> > > I do not think this is a good idea. Single purpose gfp flags that tend
> > > to heavily depend on the current implementation of the page allocator
> > > have turned out to be problematic. Users used to misunderstand their
> > > meaning resulting in a lot of abuse which was not trivial to remove.
> > > This flag seem to fall into exactly this sort of category. If there is a
> > > problem in nesting then that should be addressed rather than a new flag
> > > exported IMHO. If that is absolutely not possible for some reason then
> > > we can try to figure out what to do but that really need a very strong
> > > justification.
> > > 
> > The problem that i see is we can not use the page allocator from atomic
> > contexts, what is our case:
> > 
> > <snip>
> >     local_irq_save(flags) or preempt_disable() or raw_spinlock();
> >     __get_free_page(GFP_ATOMIC);
> > <snip>
> > 
> > So if we can convert the page allocator to raw_* lock it will be appreciated,
> > at least from our side, IMHO, not from RT one. But as i stated above we need
> > to sort raised questions out if converting is done.
> > 
> > What is your view?
> 
> To me it would make more sense to support atomic allocations also for
> the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> work for atomic context in RT sounds subtle and wrong.
>
Same view on it.

Thank you for your comments!

--
Vlad Rezki
