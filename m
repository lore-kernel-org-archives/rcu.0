Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7252C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7487B2076B
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUh2mB6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI3QqE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:46:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgI3QqD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 12:46:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601484361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92hdBQ0+yqLjn7t4Piw/YoIQ6f47TF4BG37Q/DtfEDs=;
        b=kUh2mB6Ow8VCZ29mrkt+i1nOawaa3g5RaWz0wGyZWRw+C1sBG/mhUaxse5Lay4CSYnOh/H
        p00+DHKNHxKOfRQtQLOjY0UXTuD8KZAddjxcF10N9hA4uhCTRlpFhq9e8tzFWZNXTcZaQF
        KHV/tFY9wdnjhfQJR5R9KDYv9cVgdWI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77B19AC8C;
        Wed, 30 Sep 2020 16:46:01 +0000 (UTC)
Date:   Wed, 30 Sep 2020 18:46:00 +0200
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
Message-ID: <20200930164600.GW2277@dhcp22.suse.cz>
References: <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200929162514.GA8768@pc636>
 <20200930092732.GP2277@dhcp22.suse.cz>
 <20200930123535.GB18005@pc636>
 <20200930124413.GU2277@dhcp22.suse.cz>
 <20200930133954.GA19235@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930133954.GA19235@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 30-09-20 15:39:54, Uladzislau Rezki wrote:
> On Wed, Sep 30, 2020 at 02:44:13PM +0200, Michal Hocko wrote:
> > On Wed 30-09-20 14:35:35, Uladzislau Rezki wrote:
> > > On Wed, Sep 30, 2020 at 11:27:32AM +0200, Michal Hocko wrote:
> > > > On Tue 29-09-20 18:25:14, Uladzislau Rezki wrote:
> > > > > > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > > > > > to provide a memory service for contexts which are not allowed to
> > > > > > > sleep, RCU is part of them. Both flags used to provide such ability
> > > > > > > before but not anymore.
> > > > > > > 
> > > > > > > Do you agree with it?
> > > > > > 
> > > > > > Yes this sucks. But this is something that we likely really want to live
> > > > > > with. We have to explicitly _document_ that really atomic contexts in RT
> > > > > > cannot use the allocator. From the past discussions we've had this is
> > > > > > likely the most reasonable way forward because we do not really want to
> > > > > > encourage anybody to do something like that and there should be ways
> > > > > > around that. The same is btw. true also for !RT. The allocator is not
> > > > > > NMI safe and while we should be able to make it compatible I am not
> > > > > > convinced we really want to.
> > > > > > 
> > > > > > Would something like this be helpful wrt documentation?
> > > > > > 
> > > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > index 67a0774e080b..9fcd47606493 100644
> > > > > > --- a/include/linux/gfp.h
> > > > > > +++ b/include/linux/gfp.h
> > > > > > @@ -238,7 +238,9 @@ struct vm_area_struct;
> > > > > >   * %__GFP_FOO flags as necessary.
> > > > > >   *
> > > > > >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > > > > > - * watermark is applied to allow access to "atomic reserves"
> > > > > > + * watermark is applied to allow access to "atomic reserves".
> > > > > > + * The current implementation doesn't support NMI and other non-preemptive context
> > > > > > + * (e.g. raw_spin_lock).
> > > > > >   *
> > > > > >   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
> > > > > >   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> > > > > > 
> > > > > To me it is clear. But also above conflicting statement:
> > > > > 
> > > > > <snip>
> > > > > %GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
> > > > > <snip>
> > > > > 
> > > > > should be rephrased, IMHO.
> > > > 
> > > > Any suggestions? Or more specifics about which part is conflicting? It
> > > > tries to say that there is a higher demand to succeed even though the
> > > > context cannot sleep to take active measures to achieve that. So the
> > > > only way to achieve that is to break the watermakrs to a certain degree
> > > > which is making them more "higher class" than other allocations.
> > > > 
> > > Michal, i had only one concern about it. It says that %GFP_ATOMIC users
> > > can not sleep, i.e. callers know that they are in atomic, thus no any
> > > sleeping, but the chose they make will force them to sleep.
> > 
> > I am not sure I follow you here. Do you mean they will be forced to
> > sleep with PREEMPT_RT?
> > 
> Exactly :)

We can make that more specific once RT patchset is merged. As of now
this is not the thing in the Linus tree. I believe there will be more to
clarify about atomic contexts in the RT tree as it means something else
than people are used to think.

-- 
Michal Hocko
SUSE Labs
