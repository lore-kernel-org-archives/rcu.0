Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A8EB8FDD
	for <rcu@archiver.kernel.org>; Wed,  6 Sep 2023 14:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjIFOfg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjIFOff (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Sep 2023 10:35:35 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF98F
        for <rcu@vger.kernel.org>; Wed,  6 Sep 2023 07:35:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34e202a9cc9so12099155ab.2
        for <rcu@vger.kernel.org>; Wed, 06 Sep 2023 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694010931; x=1694615731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGlUYGV6FKGTKrHXEc/8wfyJkTzTkG8Ak90V0Yv/IDA=;
        b=lJbe7jpGQOtBWb7sJ5JdKWmxAo6GMRzn9w156ep18GsK4jzr0tNSCpnY8Suku7FNxo
         WZdny7C+/UR26wtAkZ6/HfTZjp2gYAT7Yc+75IzkfnIusIOFce0B240jccSIpYxHOETj
         0JfD15Tj8Q2Tpk6i5A+C8BGuOWwnT8z2Brd+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010931; x=1694615731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGlUYGV6FKGTKrHXEc/8wfyJkTzTkG8Ak90V0Yv/IDA=;
        b=dgC+TXhAvxXedlrrAVJtZTq8lhamTdKOn5U3nVOpCsqOlDGVThs2I8itG4UPcbwsu4
         xcrWzIvSrCSYHiK9m1W8joYgN1Jq0BmLACYcVSP1ikzeglXT8WILXAeaYjeUQj+WF53s
         Rq9Q0ytWKEylaWW93kxBnSTwuyNDy3xH8i57ut2K15b+PTFdg5AeOWmhKs8fDao1Q7DA
         SH6X8QmJ+X0RQamGkI9RK5xwso7t3+/bvTeMjcpyL8OSkuy84nhjnye3z9xrHEsD2t6m
         vWIV16FkQwIundBuGLak18ZCButBxhgoEqdFifODsnEG/t+RfoiQK93ShcUNaOQHJddz
         jZdA==
X-Gm-Message-State: AOJu0YxJnZOgHaa7F5oVjONh92qyfiGsEaBu1nmamQrlK1qXxAF1W4xA
        CSws29i9PAGxFZUacb11fr2s6A==
X-Google-Smtp-Source: AGHT+IHsCY3MvLSvr8Ngr8FPPEj7HK/rV7+hrLWxXlyYEoQzLi6qAJ0h6qWiBxXIAAnxESC2vbm02Q==
X-Received: by 2002:a05:6e02:1d11:b0:349:86f6:e94a with SMTP id i17-20020a056e021d1100b0034986f6e94amr20928744ila.3.1694010930854;
        Wed, 06 Sep 2023 07:35:30 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id b17-20020a923411000000b0034e1acce730sm3879620ila.42.2023.09.06.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:35:29 -0700 (PDT)
Date:   Wed, 6 Sep 2023 14:35:29 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <20230906143529.GB1127143@google.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPc+HGjmY2ZC4WO3@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Catalin,

On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > On Mon, Sep 04, 2023 at 10:22:56PM +0100, Catalin Marinas wrote:
> > > On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
> > > > for the MPTCP upstream project, we are running syzkaller [1] continuously to
> > > > qualify our kernel changes.
> > > > 
> > > > We found one issue with kmemleak and its handling of kfree_rcu.
> > > > 
> > > > Specifically, it looks like kmemleak falsely reports memory-leaks when the
> > > > object is being freed by kfree_rcu after a certain grace-period.
> > > > 
> > > > For example, https://github.com/multipath-tcp/mptcp_net-next/issues/398#
> > > > issuecomment-1584819482 shows how the syzkaller program reliably produces a
> > > > kmemleak report, although the object is not leaked (we confirmed that by simply
> > > > increasing MSECS_MIN_AGE to something larger than the grace-period).
> > > 
> > > Not sure which RCU variant you are using but most likely the false
> > > positives are caused by the original reference to the object being lost
> > > and the pointer added to a new location that kmemleak does not track
> > > (e.g. bnode->records[] in the tree-based variant).
> > > 
> > > A quick attempt (untested, not even compiled):
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > 
> > I am not sure if that works. Correct me if I'm wrong but the issue is that
> > the allocated pointer being RCU-freed is no longer reachable by kmemleak (it
> > is scanned but not reachable), however it might still be reachable via an
> > RCU reader. In such a situation, it is a false-positive.
> 
> Yes, with a small correction that the object being RCU-freed is not
> scanned if it cannot be reached by kmemleak (unless explicitly marked as
> not a leak).

Yes I used wrong wording. I meant it is added to the kmemleak rbtree as
something that needs to be reachable, but cannot be reached. Hopefully that
makes sense.

> > The correct fix then should probably be to mark the object as
> > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > to not be reported but still be scanned until eventually the lower layers
> > will remove the object from kmemleak-tracking after the grace period. Per the
> > docs also, that API is used to prevent false-positives.
> 
> This should work as well but I'd use kmemleak_ignore() instead of
> kmemleak_not_leak(). The former, apart from masking the false positive,
> also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> object shouldn't have any valid references to other objects, so not
> worth scanning.

Yes I am also OK with that, however to me I consider the object as alive as
long as the grace period does not end. But I agree with you and it may not be
worth tracking them or scanning them.

> > Instead what the below diff appears to do is to mark the bnode cache as a
> > kmemleak object itself, which smells a bit wrong. The bnode is not an
> > allocated object in the traditional sense, it is simple an internal data
> > structure.
> 
> We do this in other places for objects containing pointers and which
> aren't tracked by kmemleak (it doesn't track page allocations as there
> would be too many leading to lots of false positives or overlapping
> objects - the slab itself uses the page allocator). An example where we
> do something similar is alloc_large_system_hash(). We could add a
> wrapper API if kmemleak_alloc() feels wrong but underlying in kmemleak
> it would use the same mechanism for recording and scanning the bnode.

Ah I see what you did, you basically made the bnode as a kmemleak object in
its own right, and perhaps the kmemleak detector can reach the object you
added. That actually (though sounding like a little of a hack) would work too.
I say hack because the object you added is not an allocated object in the
traditional sense :-D. But as you said, there is precendent for that.

> > That may not solve the issue as the false-positive unreachable
> > object is still unreachable.
> 
> It should solve the issue as long as the bnode is reachable from the
> root objects (e.g. the data/bss sections; I think it is via the
> per_cpu_ptr(&krc, cpu)->bkvcache llist_head). When the bnode is scanned,
> it will find the pointer to the RCU-freed object and mark it as
> referenced (not a leak).

Right! That's what I was missing.

> Anyway, as we trust the RCU freeing implementation not to leak data, we
> can go with your simpler suggestion of a kmemleak_ignore() call on the
> kvfree_rcu() path. Probably even better as the object pending to be
> freed will no longer be scanned.

Sounds good and thanks a lot Catalin! Unless you beat me to it, I'll send a
patch out along those lines by the weekend and CC you with your suggested-by
and the reported-by from the reporter ;-). Let me know if you have a preference.

thanks,

 - Joel

