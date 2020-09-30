Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB7C4727F
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6829820739
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vUcdbq2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgI3J1k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgI3J1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 05:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601458057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbc8B6vU59oEG9W3JMzEwnRNloOF/cIBuPfCLo3VkAE=;
        b=vUcdbq2QIKk5C/VB0n77/zrg1g7OE2ROYhA+Wb4h9EX9/s20mWtx4DVMGhtFUbS6uBzKWd
        FrGJCAsVIT+v+Aj659DEKVq45+wMd+mRgy/xjte/xNJBdW7Loyo4elhjeGNqytBkQ3CfFA
        KrJB2dONzz0Epcmz0/GFnVP3ZN2e89o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB788ACDF;
        Wed, 30 Sep 2020 09:27:37 +0000 (UTC)
Date:   Wed, 30 Sep 2020 11:27:32 +0200
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
Message-ID: <20200930092732.GP2277@dhcp22.suse.cz>
References: <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200929162514.GA8768@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929162514.GA8768@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 29-09-20 18:25:14, Uladzislau Rezki wrote:
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
> >   *
> >   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
> >   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> > 
> To me it is clear. But also above conflicting statement:
> 
> <snip>
> %GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
> <snip>
> 
> should be rephrased, IMHO.

Any suggestions? Or more specifics about which part is conflicting? It
tries to say that there is a higher demand to succeed even though the
context cannot sleep to take active measures to achieve that. So the
only way to achieve that is to break the watermakrs to a certain degree
which is making them more "higher class" than other allocations.

-- 
Michal Hocko
SUSE Labs
