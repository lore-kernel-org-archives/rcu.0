Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8BC4363D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B869021D7A
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PJtdYSR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIYPro (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:47:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgIYPro (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 11:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601048862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v859nZdRdAvozMlID3w2V9JVl0a2kKP1Gfe6Ju4Q9a8=;
        b=PJtdYSR5RZRSslz9jEpJc38LfXP/nFtPltVJseci6dvmqYxTfPJkFM6dUs6sSr0GBlmPl4
        Y0dQ4GEdqYI8qHCcZZ5IOl+TT+vtoLyZVUIrdQB/Ksk621juKWed2hOcCzKDTWr3nwOaij
        4N405sQxwGwW+/Zq3rcRV2NKxl81r9w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 059D4ACA3;
        Fri, 25 Sep 2020 15:47:42 +0000 (UTC)
Date:   Fri, 25 Sep 2020 17:47:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200925154741.GI3389@dhcp22.suse.cz>
References: <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925153129.GB25350@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri 25-09-20 17:31:29, Uladzislau Rezki wrote:
> > > > > 
> > > > > All good points!
> > > > > 
> > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > of the time.
> > > > > 
> > > > 
> > > > But it's very similar to what mempools are for.
> > > > 
> > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > to move things forward and it might be not efficient way. As a side
> > > effect, maintaining of the bulk arrays in the separate worker thread
> > > will introduce other drawbacks:
> > 
> > This is true but it is also true that it is RCU to require this special
> > logic and we can expect that we might need to fine tune this logic
> > depending on the RCU usage. We definitely do not want to tune the
> > generic page allocator for a very specific usecase, do we?
> > 
> I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> to provide a memory service for contexts which are not allowed to
> sleep, RCU is part of them. Both flags used to provide such ability
> before but not anymore.
> 
> Do you agree with it?

Yes this sucks. But this is something that we likely really want to live
with. We have to explicitly _document_ that really atomic contexts in RT
cannot use the allocator. From the past discussions we've had this is
likely the most reasonable way forward because we do not really want to
encourage anybody to do something like that and there should be ways
around that. The same is btw. true also for !RT. The allocator is not
NMI safe and while we should be able to make it compatible I am not
convinced we really want to.

Would something like this be helpful wrt documentation?

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..9fcd47606493 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -238,7 +238,9 @@ struct vm_area_struct;
  * %__GFP_FOO flags as necessary.
  *
  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
- * watermark is applied to allow access to "atomic reserves"
+ * watermark is applied to allow access to "atomic reserves".
+ * The current implementation doesn't support NMI and other non-preemptive context
+ * (e.g. raw_spin_lock).
  *
  * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.

[...]
-- 
Michal Hocko
SUSE Labs
