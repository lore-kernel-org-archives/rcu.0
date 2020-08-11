Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32612C433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0641620658
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfRVNWn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHKLdi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgHKLdi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 07:33:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717BBC06174A;
        Tue, 11 Aug 2020 04:33:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so11697742ljc.8;
        Tue, 11 Aug 2020 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SMkuBJo8KjT0i67c85My8K7V8IYtugZCFjfRB5iQb6A=;
        b=CfRVNWn9/nIuW9aaP2jQZpMFZBBTiNXXjb+GUYvcDlhsrvH6yLD4BxJ8vQH+x2OVNk
         Pr3e3c+wpsFY9YitZeb2YWX6Q3XPTesJjEq4U7ZyH329bSOCleeTIzuuMGHRiMV2DTdp
         Utwm4vuorMG3LGREE/Q6+cz3S135YFIDgn8EDmUQ29kJez7WmGESXcIaShhnUaO/viPy
         dp+eOSX3PzaUTHs2eGDygdYvsiGGLosj4cRkq8hEqYNF5mzQGJNX7ZHvwWpCicjffhQw
         LYJbtdmQw33KmkGPR+JjnMT37B5Lfy8RSIrVIgmOyYz2UBNu5DB7ZnCNvvqzhkoDqYHH
         w2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SMkuBJo8KjT0i67c85My8K7V8IYtugZCFjfRB5iQb6A=;
        b=DMxF2wQqac7eXzV7CRPp/Hx30wwvh+37tGnGtaNIG/OCQhgxJVeYbuHLz/t7Rbnbo6
         uPZ/v8V+VyqOOXlIN1OyKq2Ar3s+Q5oPyNrNps8AvRfCUhYUhXTDB1wSRseaIYEhbIN8
         bugtRy3+yUGd4xrXmn5TE4VqifLc0+O3yDrE1SXCwxGUSPbQfedVGRg2VmeYnth7P+T9
         CQNlBovD1AMavC8M1dFHJVgpMn5adrcOstAqNo7HM7XEF8QRVpPPVOm6RKPWtpcYs9Yz
         pn5GQ387GH0MlSRDu8drW8IHhgyUdkIw96WdGnQoVs41j5RbjB0UoHLLCvavpwtKrSMM
         LOLA==
X-Gm-Message-State: AOAM532Ex/a0xjA8GkRFLbE2xykjXVt6dL5l7mf1ha5YPBe5b1cCU7gF
        PyFFiyL8wdTFxWZ954EJEYM=
X-Google-Smtp-Source: ABdhPJzS7SV0WXVoCZwR/JEFg9CmHJCaDbuBolh8AJloxfxMx3lWrgr/1lcaSwck6EXSpzcgXaOOSQ==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr2905899ljg.316.1597145615838;
        Tue, 11 Aug 2020 04:33:35 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j6sm9926933lja.23.2020.08.11.04.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:33:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Aug 2020 13:33:32 +0200
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
Message-ID: <20200811113332.GB5544@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811081917.GG4793@dhcp22.suse.cz>
 <20200811093713.GB2634@pc636>
 <20200811102649.GI4793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811102649.GI4793@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 12:26:49PM +0200, Michal Hocko wrote:
> On Tue 11-08-20 11:37:13, Uladzislau Rezki wrote:
> > On Tue, Aug 11, 2020 at 10:19:17AM +0200, Michal Hocko wrote:
> > > On Mon 10-08-20 21:25:26, Michal Hocko wrote:
> > > > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > > [...]
> > > > > The problem that i see is we can not use the page allocator from atomic
> > > > > contexts, what is our case:
> > > > > 
> > > > > <snip>
> > > > >     local_irq_save(flags) or preempt_disable() or raw_spinlock();
> > > > >     __get_free_page(GFP_ATOMIC);
> > > > > <snip>
> > > > > 
> > > > > So if we can convert the page allocator to raw_* lock it will be appreciated,
> > > > > at least from our side, IMHO, not from RT one. But as i stated above we need
> > > > > to sort raised questions out if converting is done.
> > > > > 
> > > > > What is your view?
> > > > 
> > > > To me it would make more sense to support atomic allocations also for
> > > > the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> > > > work for atomic context in RT sounds subtle and wrong.
> > > 
> > > I was thinking about this some more. I still think the above would be a
> > > reasonable goal we should try to achieve. If for not other then for
> > > future maintainability (especially after the RT patchset is merged).
> > > I have tried to search for any known problems/attempts to make
> > > zone->lock raw but couldn't find anything. Maybe somebody more involved
> > > in RT world have something to say about that.
> > > 
> > I tried yesterday to convert zone->lock. See below files i had to modify:
> > <snip>
> >         modified:   include/linux/mmzone.h
> >         modified:   mm/compaction.c
> >         modified:   mm/memory_hotplug.c
> >         modified:   mm/page_alloc.c
> >         modified:   mm/page_isolation.c
> >         modified:   mm/page_reporting.c
> >         modified:   mm/shuffle.c
> >         modified:   mm/vmscan.c
> >         modified:   mm/vmstat.c
> > <snip>
> > 
> > There is one more lock, that is zone->lru_lock one. Both zone->lock and this
> > one intersect between each other. If the lru_lock can be nested under zone->lock
> > it should be converted as well. But i need to analyze it farther. There are
> > two wrapper functions which are used as common interface to lock/unlock both
> > locks. See compact_lock_irqsave()/compact_unlock_should_abort_lru() in the 
> > mm/compaction.c.
> > 
> > Any thoughts here?
> 
> I am not an expert on compaction. Vlastimil would know better. My
> thinking was that zone->lock is a tail lock but compaction/page
> isolation might be doing something I am not aware of right now.
> 
> > Anyway i tried to convert only zone->lock and use page allocator passing there
> > gfp_mask=0 as argument. So it works. CONFIG_PROVE_RAW_LOCK_NESTING does not
> > complain about any "bad" lock nesting.
> > 
> > > Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
> > > only way I can see forward is to detect real (RT) atomic contexts and
> > > bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
> > > requests.
> > >
> > For RT kernel we can detect it for sure. preemtable() works just fine there,
> > i.e. we can identify the context we are currently in.
> 
> In previous email I didn't mention why I prefer full NOWAIT semantic
> over rt specific bailouts. There are users making NOWAIT allocation
> attempts as an opportunistic allocation request which is OK to fail
> as they have a fallback to go through. This would imply they would
> prefer to know this ASAP rather then get blocked and sleep. A lack of
> reports for PREEMPT_RT would suggest that nobody has noticed as this
> though.
>
I agree here and share your view on it. To me, making *_ATOMIC *_NOWAIT
to be fully workable on both kernels sounds like correct way to go. 

Indeed, there can be no complains as of now. But later on it can be
and the question will be raised again, what to do.

--
Vlad Rezki
