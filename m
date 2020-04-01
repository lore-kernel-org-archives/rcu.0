Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625AFC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C720787
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3p33A/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgDATF7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:05:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43016 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgDATF7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 15:05:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so607278ljn.10;
        Wed, 01 Apr 2020 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3gOU6KvThAZ/bQ9zaPHgqs0KyrN+k/G9LgmPKVwVsg=;
        b=C3p33A/BRXhUYLxfrivTHH70/6MyRFvTmN9PTYhjXrj1PQjHhkjQgEpG49zwsezCB9
         fYD8hwXhwSLYNCF/ueKd1SqJYhP0LYe7mTmXJ1VnNjowibX/9IPL95ig4cJ1fC6zwjYt
         Y25dqgUr3aATMzAU/qz18lOn8ygfAWTTDphvgHII0MIHni/kfbJfXbtIxT8vFKkkx3S0
         KzCJioRqizSgK/Co20+D9bK81E7d/HpMVUpINDSlX2phTtqPtsERKdOyGNaq90QbyV/2
         u51cZ6s6CQDVdYYEhjCjB8NOHd4NjJIZluxN/SWNWXVV/Q0q4w87eqPSTKAxRDCkBAE3
         jvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3gOU6KvThAZ/bQ9zaPHgqs0KyrN+k/G9LgmPKVwVsg=;
        b=dEqF/owOsji10AJ1Bf9eQRqH84zF+IJAx61MOR7oqLRp92qD6TVHAgSv2yrS4fHuiF
         M37Pzx/+GYhPXmLEWMjbEYBulU83rNHvRStWhUjO/+qJOpiDzJw0So6zXvSzvNK8uP4f
         WhcoCpM2JYOS41GNNllSp9G/m33/5MoXgbuz90ZDxlVOfY7UoRE2jUk/TLStIpVZ57Mc
         pLmAIekIy/gGWhCe2EjNUb379s35HVY8+4B2LvnEE4IS1Wc9Sd2Be5iXMK5AExWBMuOE
         Fjjt2wyF5SLnrACt+0aC3ywCqnuw7R/8KDW/3W3NfGX4T+vCUJZtpQ+2NzO8GNM8ekDm
         gRmQ==
X-Gm-Message-State: AGi0PuYWGA5DfZlrFy8+q5wMb2Bf1tzeUoWNWgt3tK3oZMInxLDvmsX1
        s258l8jHCKy+HfLsOuWKfDU=
X-Google-Smtp-Source: APiQypJpxlS6Y1IDkvmvwhV7f/drPoarZ841bQI8pXJPemsMJAjo/zXMT2qjSiPnfb1IjIHBYet/hg==
X-Received: by 2002:a05:651c:1102:: with SMTP id d2mr14234025ljo.102.1585767956556;
        Wed, 01 Apr 2020 12:05:56 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y124sm2245266lff.48.2020.04.01.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:05:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 21:05:48 +0200
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
Message-ID: <20200401190548.GA6360@pc636>
References: <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
 <20200401181601.GA4042@pc636>
 <20200401182615.GE19865@paulmck-ThinkPad-P72>
 <20200401183745.GA5960@pc636>
 <20200401185439.GG19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401185439.GG19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 11:54:39AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 01, 2020 at 08:37:45PM +0200, Uladzislau Rezki wrote:
> > On Wed, Apr 01, 2020 at 11:26:15AM -0700, Paul E. McKenney wrote:
> > > On Wed, Apr 01, 2020 at 08:16:01PM +0200, Uladzislau Rezki wrote:
> > > > > > > 
> > > > > > > Right. Per discussion with Paul, we discussed that it is better if we
> > > > > > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > > > > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > > > > > 
> > > > > > As discussed before, we can make use of memory pool API for such
> > > > > > purpose. But i am not sure if it should be one pool per CPU or
> > > > > > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > > > > > blocks.
> > > > > 
> > > > > There are advantages and disadvantages either way.  The advantage of the
> > > > > per-CPU pool is that you don't have to worry about something like lock
> > > > > contention causing even more pain during an OOM event.  One potential
> > > > > problem wtih the per-CPU pool can happen when callbacks are offloaded,
> > > > > in which case the CPUs needing the memory might never be getting it,
> > > > > because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> > > > > might never be invoking them.
> > > > > 
> > > > > But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> > > > > either don't have heavy callback loads (HPC systems) or are carefully
> > > > > configured (real-time systems).  Plus large systems would probably end
> > > > > up needing something pretty close to a slab allocator to keep from dying
> > > > > from lock contention, and it is hard to justify that level of complexity
> > > > > at this point.
> > > > > 
> > > > > Or is there some way to mark a specific slab allocator instance as being
> > > > > able to keep some amount of memory no matter what the OOM conditions are?
> > > > > If not, the current per-CPU pre-allocated cache is a better choice in the
> > > > > near term.
> > > > > 
> > > > As for mempool API:
> > > > 
> > > > mempool_alloc() just tries to make regular allocation taking into
> > > > account passed gfp_t bitmask. If it fails due to memory pressure,
> > > > it uses reserved preallocated pool that consists of number of
> > > > desirable elements(preallocated when a pool is created).
> > > > 
> > > > mempoll_free() returns an element to to pool, if it detects that
> > > > current reserved elements are lower then minimum allowed elements,
> > > > it will add an element to reserved pool, i.e. refill it. Otherwise
> > > > just call kfree() or whatever we define as "element-freeing function."
> > > 
> > > Unless I am missing something, mempool_alloc() acquires a per-mempool
> > > lock on each invocation under OOM conditions.  For our purposes, this
> > > is essentially a global lock.  This will not be at all acceptable on a
> > > large system.
> > > 
> > It uses pool->lock to access to reserved objects, so if we have one memory
> > pool per one CPU then it would be serialized.
> 
> I am having difficulty parsing your sentence.  It looks like your thought
> is to invoke mempool_create() for each CPU, so that the locking would be
> on a per-CPU basis, as in 128 invocations of mempool_init() on a system
> having 128 hardware threads.  Is that your intent?
> 
In order to serialize it, you need to have it per CPU. So if you have 128
cpus, it means:

<snip>
for_each_possible_cpu(...)
    cpu_pool = mempool_create();
<snip>

but please keep in mind that it is not my intention, but i had a though
about mempool API. Because it has pre-reserve logic inside.

--
Vlad Rezki
