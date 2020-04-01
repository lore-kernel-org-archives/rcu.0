Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C14C2D0F0
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BAA20719
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdTGEWph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbgDATfi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:35:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38692 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732780AbgDATfi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 15:35:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id c5so722027lfp.5;
        Wed, 01 Apr 2020 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cBGwSKFQoUy9yQfRkZN+LSw8IOHhJ+8pXF0jMXV6jtI=;
        b=mdTGEWph6Vq2uaR0tc/iifpcG/c3qY0Hb5ngWLIUu1WnoAB8NR6sznifiUDpTOtJ5T
         k93eZvr2OpbDPyQ5USWWW9Oy7KjsWFMwWkSA/D7XJsMJcHweC86r/DhV1IMy70nuroQY
         tq030XM3aJzQO5Ancl7qtzJqtr8jtR1NKtV219bh8oMAqFDb2JN7l1hKeWJNXXr1XZi4
         OYWDHN58geOD4f0vQdqNTHAKrnKjaPZGNPdDTaQqnTtYjFMGorBdnQ6LU4eFSZl4qsw4
         m170l2Yoe1mnNa26wfjdo4vfd1YfITS1vQu3yN4ZYLIgoC/CsTu4WyWjADSghEhGhG54
         /9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBGwSKFQoUy9yQfRkZN+LSw8IOHhJ+8pXF0jMXV6jtI=;
        b=eQP2BuooJbzNqd7GaUaDm3ZUKQ2km6ZueE4aVnSJvrGxgrFmk5GCczstL4kVk7Q5XP
         P4GDvnUAn9SJ7phMZey2lHl8bq4ii+hnAEzZHr6WcmM5wEdJ76HO8N/NSqWRAma8TiwL
         +ubY70vtcD41cZg13TOvTj4bzB+olYP1+Q+qJ3ncSE4ofMyJ1DVVlz+hhf4TitDz39Km
         h+YRpvSBIrBWr+yHU1CPhFzZC1o6PB73CYGpIJx+K9iN+7Vxtqpo5ianIV47KYWv7UmU
         HFch23gN7tJUabC0YrPxcdxRj7XXjgTyqsfaMmxew4DVxHFgLAGIBgcibRcEpQbahwWt
         K/sQ==
X-Gm-Message-State: AGi0PuborGjxwcLopyQNGFXj3QryZ2bHv6Uv8Y98z0IzSyclbxfLcdPV
        hz+aAH8LZqWUImM+AkIfGts=
X-Google-Smtp-Source: APiQypKMfYt0DX+KfPnN+lhcxZl2+YbgbU5zIV42ErNExS24cFdhwcnLKz7tal7KIdh6r3bYoYQqZA==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr14730366lfi.172.1585769734597;
        Wed, 01 Apr 2020 12:35:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y124sm2292003lff.48.2020.04.01.12.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:35:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 21:35:24 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401193524.GA6821@pc636>
References: <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
 <20200401181601.GA4042@pc636>
 <20200401182615.GE19865@paulmck-ThinkPad-P72>
 <20200401183745.GA5960@pc636>
 <20200401185439.GG19865@paulmck-ThinkPad-P72>
 <20200401190548.GA6360@pc636>
 <20200401193405.GH19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401193405.GH19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 12:34:05PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 01, 2020 at 09:05:48PM +0200, Uladzislau Rezki wrote:
> > On Wed, Apr 01, 2020 at 11:54:39AM -0700, Paul E. McKenney wrote:
> > > On Wed, Apr 01, 2020 at 08:37:45PM +0200, Uladzislau Rezki wrote:
> > > > On Wed, Apr 01, 2020 at 11:26:15AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Apr 01, 2020 at 08:16:01PM +0200, Uladzislau Rezki wrote:
> > > > > > > > > 
> > > > > > > > > Right. Per discussion with Paul, we discussed that it is better if we
> > > > > > > > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > > > > > > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > > > > > > > 
> > > > > > > > As discussed before, we can make use of memory pool API for such
> > > > > > > > purpose. But i am not sure if it should be one pool per CPU or
> > > > > > > > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > > > > > > > blocks.
> > > > > > > 
> > > > > > > There are advantages and disadvantages either way.  The advantage of the
> > > > > > > per-CPU pool is that you don't have to worry about something like lock
> > > > > > > contention causing even more pain during an OOM event.  One potential
> > > > > > > problem wtih the per-CPU pool can happen when callbacks are offloaded,
> > > > > > > in which case the CPUs needing the memory might never be getting it,
> > > > > > > because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> > > > > > > might never be invoking them.
> > > > > > > 
> > > > > > > But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> > > > > > > either don't have heavy callback loads (HPC systems) or are carefully
> > > > > > > configured (real-time systems).  Plus large systems would probably end
> > > > > > > up needing something pretty close to a slab allocator to keep from dying
> > > > > > > from lock contention, and it is hard to justify that level of complexity
> > > > > > > at this point.
> > > > > > > 
> > > > > > > Or is there some way to mark a specific slab allocator instance as being
> > > > > > > able to keep some amount of memory no matter what the OOM conditions are?
> > > > > > > If not, the current per-CPU pre-allocated cache is a better choice in the
> > > > > > > near term.
> > > > > > > 
> > > > > > As for mempool API:
> > > > > > 
> > > > > > mempool_alloc() just tries to make regular allocation taking into
> > > > > > account passed gfp_t bitmask. If it fails due to memory pressure,
> > > > > > it uses reserved preallocated pool that consists of number of
> > > > > > desirable elements(preallocated when a pool is created).
> > > > > > 
> > > > > > mempoll_free() returns an element to to pool, if it detects that
> > > > > > current reserved elements are lower then minimum allowed elements,
> > > > > > it will add an element to reserved pool, i.e. refill it. Otherwise
> > > > > > just call kfree() or whatever we define as "element-freeing function."
> > > > > 
> > > > > Unless I am missing something, mempool_alloc() acquires a per-mempool
> > > > > lock on each invocation under OOM conditions.  For our purposes, this
> > > > > is essentially a global lock.  This will not be at all acceptable on a
> > > > > large system.
> > > > > 
> > > > It uses pool->lock to access to reserved objects, so if we have one memory
> > > > pool per one CPU then it would be serialized.
> > > 
> > > I am having difficulty parsing your sentence.  It looks like your thought
> > > is to invoke mempool_create() for each CPU, so that the locking would be
> > > on a per-CPU basis, as in 128 invocations of mempool_init() on a system
> > > having 128 hardware threads.  Is that your intent?
> > > 
> > In order to serialize it, you need to have it per CPU. So if you have 128
> > cpus, it means:
> > 
> > <snip>
> > for_each_possible_cpu(...)
> >     cpu_pool = mempool_create();
> > <snip>
> > 
> > but please keep in mind that it is not my intention, but i had a though
> > about mempool API. Because it has pre-reserve logic inside.
> 
> OK, fair point on use of mempool API, but my guess is that extending
> the current kfree_rcu() logic will be simpler.
> 
Agree :)

--
Vlad Rezki
