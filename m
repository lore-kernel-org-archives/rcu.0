Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EACBC4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60B32076B
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ieofj3pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgI3QsZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:48:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgI3QsZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 12:48:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601484503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtN3pR3Z/oium5GfdXD2uz9/2bfNv63HFSibvAivduA=;
        b=ieofj3pAkg5i6Sr6TjB0RUnbe67x+W/JYtJE8sv+gEAJGMujLFV76gqC6+h7tVN7LQ6OoL
        ClD+6YbWWbEVgIXXTgtUA/jAPy+RbYWK2LjHJIhvdgRWbnBbGxmx2WaR/glH8FtjG5gZGK
        R4tWOE6K525nzZztXdKKP697OLJn/h4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B0A1AFA9;
        Wed, 30 Sep 2020 16:48:23 +0000 (UTC)
Date:   Wed, 30 Sep 2020 18:48:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930164822.GX2277@dhcp22.suse.cz>
References: <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200930152517.GA1470428@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930152517.GA1470428@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 30-09-20 11:25:17, Joel Fernandes wrote:
> On Fri, Sep 25, 2020 at 05:47:41PM +0200, Michal Hocko wrote:
> > On Fri 25-09-20 17:31:29, Uladzislau Rezki wrote:
> > > > > > > 
> > > > > > > All good points!
> > > > > > > 
> > > > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > > > of the time.
> > > > > > > 
> > > > > > 
> > > > > > But it's very similar to what mempools are for.
> > > > > > 
> > > > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > > > to move things forward and it might be not efficient way. As a side
> > > > > effect, maintaining of the bulk arrays in the separate worker thread
> > > > > will introduce other drawbacks:
> > > > 
> > > > This is true but it is also true that it is RCU to require this special
> > > > logic and we can expect that we might need to fine tune this logic
> > > > depending on the RCU usage. We definitely do not want to tune the
> > > > generic page allocator for a very specific usecase, do we?
> > > > 
> > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > to provide a memory service for contexts which are not allowed to
> > > sleep, RCU is part of them. Both flags used to provide such ability
> > > before but not anymore.
> > > 
> > > Do you agree with it?
> > 
> > Yes this sucks. But this is something that we likely really want to live
> > with. We have to explicitly _document_ that really atomic contexts in RT
> > cannot use the allocator. From the past discussions we've had this is
> > likely the most reasonable way forward because we do not really want to
> > encourage anybody to do something like that and there should be ways
> > around that. The same is btw. true also for !RT. The allocator is not
> > NMI safe and while we should be able to make it compatible I am not
> > convinced we really want to.
> > 
> > Would something like this be helpful wrt documentation?
> > 
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 67a0774e080b..9fcd47606493 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -238,7 +238,9 @@ struct vm_area_struct;
> >   * %__GFP_FOO flags as necessary.
> >   *
> >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > - * watermark is applied to allow access to "atomic reserves"
> > + * watermark is applied to allow access to "atomic reserves".
> > + * The current implementation doesn't support NMI and other non-preemptive context
> > + * (e.g. raw_spin_lock).
> 
> I think documenting is useful.
> 
> Could it be more explicit in what the issue is? Something like:
> 
> * Even with GFP_ATOMIC, calls to the allocator can sleep on PREEMPT_RT
> systems. Therefore, the current low-level allocator implementation does not
> support being called from special contexts that are atomic on RT - such as
> NMI and raw_spin_lock. Due to these constraints and considering calling code
> usually has no control over the PREEMPT_RT configuration, callers of the
> allocator should avoid calling the allocator from these cotnexts even in
> non-RT systems.

I do not mind documenting RT specific behavior but as mentioned in other
reply, this should likely go via RT tree for now. There is likely more
to clarify about atomicity for PREEMPT_RT.
-- 
Michal Hocko
SUSE Labs
