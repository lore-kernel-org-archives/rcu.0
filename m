Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D2EC2D0E2
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3BF206B8
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mpQKbe36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVPfc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVPfb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 11:35:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600788929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mas1H8hGrnQpVC8euato2+uS4HKiD4shHs2BKrckZxI=;
        b=mpQKbe36vjEVH+o3o3TbNunfUyRD6S8P40P1zCUuYU2cAePSKFb79leIXAiHFoAM8bejxp
        KVAecwUAmYuhHHdgQzDFu2jUI4Qstor4TjmprXVOhHFdxEhm4yMwhtqT/x8Wnu/5pzs5hV
        QNnd+mRUTmeiUNulyXIj1nu630HoELI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 166B9AEC3;
        Tue, 22 Sep 2020 15:36:06 +0000 (UTC)
Date:   Tue, 22 Sep 2020 17:35:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200922153528.GB12990@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922131257.GA29241@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 22-09-20 15:12:57, Uladzislau Rezki wrote:
[...]
> > Mimicing a similar implementation shouldn't be all that hard
> > and you will get your own pool which doesn't affect other page allocator
> > users as much as a bonus.
> > 
> I see your point Michal. As i mentioned before, it is important to avoid of
> having such own pools, because the aim is not to waste memory resources. A
> page will be returned back to "page allocator" as soon as a scheduler place  
> our reclaim thread on a CPU and grace period is passed. So, the resource
> can be used for other needs. What is important.
> 
> Otherwise a memory footprint is increased what is bad for low memory
> conditions when OOM is involved. Just in case, it is a big issue for
> mobile devices.

Really, how much memory are we talking about here? Do you have any
estimation? How many pointers do you need to store at once? 10k (that
would be 20 pages per cpu? Doesn't sound too big to me. But again I do
not know the scale here. Also if you really care you can fine tune this
pool based on demand. All that is not a rocket science and it can be
tuned outside of the page allocator rather than other way around.

We will not move forward without any specific numbers here I am afraid.

[...]

> > Would a similar scaling as the page allocator feasible. Really I mostly
> > do care about shared nature of the pcp allocator list that one user can
> > easily monopolize with this API.
> > 
> I see your concern. pcplist can be monopolized by already existing API:
> 
>     while (i < 100)
>         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);

They will usually not, because even non-sleeping allocations will refill
them unless the memory is scarce and memory reclaim is needed. As
replied to Paul in other email, this is not a question of correctness.
It is a matter of shifting the overhead around.

> > > Single-argument details is here: https://lkml.org/lkml/2020/4/28/1626
> > 
> > Error 501
> > 
> Could you please elaborate? Do not want to speculate :)

It thrown 501 on me. lkml.org is quite unreliable. It works now. I will
read through that. Please use lore or lkml.kernel.org/r/$msg in future.

-- 
Michal Hocko
SUSE Labs
