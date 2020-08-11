Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBCC433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27637205CB
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alkV5ofL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHKJm5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgHKJm4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 05:42:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557AC06174A;
        Tue, 11 Aug 2020 02:42:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v9so12790407ljk.6;
        Tue, 11 Aug 2020 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cG+mdHf95KQRIR+PKH39qHiQQBcfkHhvVQL3Yw1iFA=;
        b=alkV5ofLUR3s35AVSXiHLEemK1HlnmUwQdT46XyqgiXOtF9Gann/KZSvJFYzoknh7C
         kgl/NpEJWdDUB4HrnQ/UVXbm00TiLnFmGcZp6MiUNkaXnOzFH+YBWRNLNVjlD4e1Hwmy
         jnrD+sso9JE/9LcVuGRYYwXGQjnRCr3WmXDCpYVhJQ0Law1NwFv9qrzFLNEXbGN1PfJx
         mCRoSJ5mq3RtFnl1hhWrNSZqI/AAaAeer0kGQSZrwJ/fMZAWx8ag9ptuaSZpTDAmZxEd
         V+1bsLE4hDtp6o/I+Oz7HCRt3cqGc9hjep7W/bT5va5VuHPqQy71dhuqKE2LlKXMdvvL
         grOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cG+mdHf95KQRIR+PKH39qHiQQBcfkHhvVQL3Yw1iFA=;
        b=lBRxa/RHpAKSi0wDXt1NHnlA3DI++oj88I+a4JXXqUVp4KPd69kJFcX4eMZAAERbLp
         9Gft7GHYnmSMFcop5biDStY8UaeRMDCekzkq60jlLc1Mx7VrsUYimZ754kvmMPKA47du
         16UQU+E1Em5ULBY//9tK821bfTGJuLaPMqF3T5JbWVwTT/zSxt3uJ2aFPFGfdOeEB6dT
         w2NE9ME1m3jBiwvD/o3kV+xboIrjfami6QNKNEcnKvrpeZ/ftQWwGCkdDMNs8IVZQ+Xk
         aHDzYryQDs7Z27+T3rSgjBbr7pOD6/AkHV1Kn2xJpNlQtjn0YGnd/EU+McWvLGuV4HGH
         VgMA==
X-Gm-Message-State: AOAM531RnuP29lX12I0Mr7BXCRJJ8VEGp/QlV3UUhmYhU8Z6A1s/2y30
        IEy5GRyl0DL7geUJuQMQYxY=
X-Google-Smtp-Source: ABdhPJyNGflrxmVaITS5tgvQdm7i90I/xy8vmlJZcCFjye4UCBWH9OtbOX757ngIByawg0vHNoFNhA==
X-Received: by 2002:a2e:6808:: with SMTP id c8mr2860160lja.13.1597138974134;
        Tue, 11 Aug 2020 02:42:54 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id e14sm9883332ljl.96.2020.08.11.02.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:42:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Aug 2020 11:42:51 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200811094251.GA3767@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811081917.GG4793@dhcp22.suse.cz>
 <20200811093713.GB2634@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811093713.GB2634@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 11:37:13AM +0200, Uladzislau Rezki wrote:
> On Tue, Aug 11, 2020 at 10:19:17AM +0200, Michal Hocko wrote:
> > On Mon 10-08-20 21:25:26, Michal Hocko wrote:
> > > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > [...]
> > > > The problem that i see is we can not use the page allocator from atomic
> > > > contexts, what is our case:
> > > > 
> > > > <snip>
> > > >     local_irq_save(flags) or preempt_disable() or raw_spinlock();
> > > >     __get_free_page(GFP_ATOMIC);
> > > > <snip>
> > > > 
> > > > So if we can convert the page allocator to raw_* lock it will be appreciated,
> > > > at least from our side, IMHO, not from RT one. But as i stated above we need
> > > > to sort raised questions out if converting is done.
> > > > 
> > > > What is your view?
> > > 
> > > To me it would make more sense to support atomic allocations also for
> > > the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> > > work for atomic context in RT sounds subtle and wrong.
> > 
> > I was thinking about this some more. I still think the above would be a
> > reasonable goal we should try to achieve. If for not other then for
> > future maintainability (especially after the RT patchset is merged).
> > I have tried to search for any known problems/attempts to make
> > zone->lock raw but couldn't find anything. Maybe somebody more involved
> > in RT world have something to say about that.
> > 
> I tried yesterday to convert zone->lock. See below files i had to modify:
> <snip>
>         modified:   include/linux/mmzone.h
>         modified:   mm/compaction.c
>         modified:   mm/memory_hotplug.c
>         modified:   mm/page_alloc.c
>         modified:   mm/page_isolation.c
>         modified:   mm/page_reporting.c
>         modified:   mm/shuffle.c
>         modified:   mm/vmscan.c
>         modified:   mm/vmstat.c
> <snip>
> 
> There is one more lock, that is zone->lru_lock one. Both zone->lock and this
> one intersect between each other. If the lru_lock can be nested under zone->lock
> it should be converted as well. But i need to analyze it farther. There are
> two wrapper functions which are used as common interface to lock/unlock both
> locks. See compact_lock_irqsave()/compact_unlock_should_abort_lru() in the 
> mm/compaction.c.
> 
> Any thoughts here?
> 
> Anyway i tried to convert only zone->lock and use page allocator passing there
> gfp_mask=0 as argument. So it works. CONFIG_PROVE_RAW_LOCK_NESTING does not
> complain about any "bad" lock nesting.
> 
> > Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
> > only way I can see forward is to detect real (RT) atomic contexts and
> > bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
> > requests.
> >
This is similar what i have done with mm: Add __GFP_NO_LOCKS flag. I just
did it for order-0 pages(other paths are impossible) and made it common for
any kernel.

Because when you say "bail out early" i suspect that we would like to check
the per-cpu-list cache.

> For RT kernel we can detect it for sure. preemtable() works just fine there,
> i.e. we can identify the context we are currently in.
> 

--
Vlad Rezki
