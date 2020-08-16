Return-Path: <SRS0=FxgN=B2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF67C433E3
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AF1206F4
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 22:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tozs28+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgHPW5D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPW5B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Aug 2020 18:57:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA7C061786;
        Sun, 16 Aug 2020 15:57:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so15413302ljj.5;
        Sun, 16 Aug 2020 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ISqgAr5mVsqcVa5T/RQjHidddeXrpowXieFk+y0N8M=;
        b=Tozs28+Qr6u9Y2FikwR+jDpH9HiXrIZYuArZFgKGp6L+61g+WIW8akdKsM8pV6R5rf
         zPoM3Dqd71cnXwoXmfKE+pm/QJUO/9lbJgEaogX9I1++lIJu+Co37tPr/fYD6kcuZPXR
         HN49bkQ7vRNngQUZCBgEPszGRnQ5DhQtYTVc3qidPucZ/6sjdd3bYtNMMal5enKQoQov
         O/GxVyvlP0sI22J876DhcRauqgbPl2x5mFBZjxjr0l8zkguCWhFmj3jXZaDv3rBJteNC
         v5v0/pIbtWP0qCP4brtQ2Qidqk36Nip/rWFcFDmlm/SHpwNxXZqh+aoF3MPGZFIGjRrt
         zeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ISqgAr5mVsqcVa5T/RQjHidddeXrpowXieFk+y0N8M=;
        b=nIpAG48h/xGqR0STmkhO5U7KQOxc0+IjTbPqUe+YR4P6ggTsn149wJLRDC+1vVCg4E
         7TlAVUfDMYhEnLDIdXGfBG9VU6xVim3J3GJCmzSWH5259Ag76ck4B+K2aFYFwYqtJcFA
         nt/UizvynnFTnnf2NmjAhMbisBpUIm7KTtOIj9d4sAfATtrlxEvhGu66b5XT8eVna+tq
         q74wEwQlcxyeT3jAE8NzYWaEf5KT8D/bhhBH4DtEBiOPJJvxLCI/s6RyBPlkcDATQZPF
         bV+lmblz/Q36YWgkpV3JaSf55WMjr6J8vosQYcKrc/pwbMH/2XOndN8pGrCzbLb9mn/u
         W7ew==
X-Gm-Message-State: AOAM532Ui74pScBdhi1jnmxGmHiAoOL4NrgxwbO85RHJ4qP51pRP3E5X
        44LVM8Nn4KbEOwp9fNdU3sI=
X-Google-Smtp-Source: ABdhPJygnaGyT1ZhEKzm7pUMmPKtXAXP6IeR+TsG4iwr2FYwxzI3Aop8J8fPG/+EY1xIjca9gaMHiA==
X-Received: by 2002:a2e:9f46:: with SMTP id v6mr5755863ljk.66.1597618619303;
        Sun, 16 Aug 2020 15:56:59 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm4634109lfi.76.2020.08.16.15.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:56:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 17 Aug 2020 00:56:55 +0200
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200816225655.GA17869@pc636>
References: <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814215206.GL3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 11:52:06PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 14, 2020 at 01:41:40PM -0700, Paul E. McKenney wrote:
> > > And that enforces the GFP_NOLOCK allocation mode or some other solution
> > > unless you make a new rule that calling call_rcu() is forbidden while
> > > holding zone lock or any other lock which might be nested inside the
> > > GFP_NOWAIT zone::lock held region.
> > 
> > Again, you are correct.  Maybe the forecasted weekend heat will cause
> > my brain to hallucinate a better solution, but in the meantime, the
> > GFP_NOLOCK approach looks good from this end.
> 
> So I hate __GFP_NO_LOCKS for a whole number of reasons:
> 
>  - it should be called __GFP_LOCKLESS if anything
>  - it sprinkles a bunch of ugly branches around the allocator fast path
>  - it only works for order==0
> 
I had a look at your proposal, that is below. An underlying logic stays
almost the same as what has been proposed by this RFC. I mean i do not
see any difference in your approach that does exactly the same - providing
lock-less access to the per-cpu-lists. I am not talking about implementation
details and farther improvements, like doing also a search over zonelist -> ZONE_NORMAL.

Also, please note. The patch was tagged as RFC.

>
> Combined I really odn't think this should be a GFP flag. How about a
> special purpose allocation function, something like so..
> 
I agree with you. Also i think, Michal, does not like the GFP flag, it introduces
more complexity to the page allocator. So, providing lock-less access as a separate
function is better approach, IMHO.

Michal asked to provide some data regarding how many pages we need and how
"lockless allocation" behaves when it comes to success vs failed scenarios.

Please see below some results. The test case is a tight loop of 1 000 000 allocations
doing kmalloc() and kfree_rcu():

sudo ./test_vmalloc.sh run_test_mask=2048 single_cpu_test=1

<snip>
 for (i = 0; i < 1 000 000; i++) {
  p = kmalloc(sizeof(*p), GFP_KERNEL);
  if (!p)
   return -1;

  p->array[0] = 'a';
  kvfree_rcu(p, rcu);
 }
<snip>

wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_0.png
wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png

Also i would like to underline, that kfree_rcu() reclaim logic can be improved further,
making the drain logic more efficient when it comes to time, thus to reduce a footprint
as a result number of required pages.

--
Vlad Rezki
