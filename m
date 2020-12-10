Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581FC4361B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA9923B85
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbgLJOKN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgLJOKE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 09:10:04 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87323C061794
        for <rcu@vger.kernel.org>; Thu, 10 Dec 2020 06:09:23 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id t9so5410578ilf.2
        for <rcu@vger.kernel.org>; Thu, 10 Dec 2020 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPBbRhY2fa8scqQYa6fuHv3sg6vR+F2lX2rvUeIAO48=;
        b=JkdYsiUIuaKjkh9mnEn6K9UjsggLbkAEstkUertGwGfUsrbxgckPjN8K4kAMT+Qtn8
         E1t1cBIBcazvAi9hCvM7zR3BLzqI8d1JXZZqzB4xP6jFGjrIpE9B39At2l7g5WeuGT+u
         SUeS+KVEo87WLtzh1KVlcunTMvAhrHDXOXfIFHyEJjxSPl9zK7NzQ2NoGP2FqV6bV8JS
         WUuNs4AFeWDtn9cZXLh7WR1kMYqCQ1j/ZE7yoylDLN1I3uPqQHo5/HuELmzpXUgPjOg8
         WOqCY8CyqI9d81Lq6oF/oADMTwgUau75o3QgtjlBOZ0n/opE23HyfFKRTjq+oBfqVfV/
         3GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPBbRhY2fa8scqQYa6fuHv3sg6vR+F2lX2rvUeIAO48=;
        b=DRiD6GwrlXotbgfVAcJ1rE7WRv5SUhQv/qo+2JY8+a+p7qDxB8UO1woy3QzXvbpLfc
         zd77zVMVLD41ob0b65EgWQX1tAzJP/Sy2+VtCIpssMF7KjIKgMu/N7aBM82Y32q488MA
         rb/QNwk/p6CxJdLgAq9XUwc0j1Qb7IW7r9lrm+e65QXn5uKYdL0DrI5KUsmT6hH1uDAl
         2iG42hkw2pQN9uwtqC3HgdDPhlyLNSsvr/mcu3KIio6fFDtJ6VJ72HCfL6I1n4dVftc0
         fa6zbsIqfbBHWoAwogvf30MQBU9DKfep4OFOaotgDhP8/WqoAC6P0CygmnPVHjwSHR1v
         7L7g==
X-Gm-Message-State: AOAM5319wy7kjkfKOIcrBMmEkAfQZIzqiqw/tOwVO3Oc7svRlHoq/GCX
        2CRKET+PMuOlu0kMOmv997eyhnDN1RIt9lCcJgv5xw==
X-Google-Smtp-Source: ABdhPJy2c1PmZgAZz7NGUShF5YWd6ef23nP2jmGcLoSepngzWOBONwg3/eAjoiLwkee6Bcyu/sTpGjzZWWAJ44XjHeE=
X-Received: by 2002:a92:b12:: with SMTP id b18mr9243965ilf.216.1607609362100;
 Thu, 10 Dec 2020 06:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20201210080844.23741-1-sjpark@amazon.com>
In-Reply-To: <20201210080844.23741-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 10 Dec 2020 15:09:10 +0100
Message-ID: <CANn89i+egqwjJqGE6mZFB+-GuT_1dOQJP=pccREEZvEwQ1SGiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] net: Reduce rcu_barrier() contentions from 'unshare(CLONE_NEWNET)'
To:     SeongJae Park <sjpark@amazon.com>
Cc:     David Miller <davem@davemloft.net>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Florian Westphal <fw@strlen.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        netdev <netdev@vger.kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 10, 2020 at 9:09 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> On a few of our systems, I found frequent 'unshare(CLONE_NEWNET)' calls
> make the number of active slab objects including 'sock_inode_cache' type
> rapidly and continuously increase.  As a result, memory pressure occurs.
>
> In more detail, I made an artificial reproducer that resembles the
> workload that we found the problem and reproduce the problem faster.  It
> merely repeats 'unshare(CLONE_NEWNET)' 50,000 times in a loop.  It takes
> about 2 minutes.  On 40 CPU cores, 70GB DRAM machine, it reduced about
> 15GB of available memory in total.  Note that the issue don't reproduce
> on every machine.  On my 6 CPU cores machine, the problem didn't
> reproduce.

OK, that is the number before the patch, but what is the number after
the patch ?

I think the idea is very nice, but this will serialize fqdir hash
tables destruction on one single cpu,
this might become a real issue _if_ these hash tables are populated.

(Obviously in your for (i=1;i<50000;i++) unshare(CLONE_NEWNET);  all
these tables are empty...)

As you may now, frags are often used as vectors for DDOS attacks.

I would suggest maybe to not (ab)use system_wq, but a dedicated work queue
with a limit (@max_active argument set to 1 in alloc_workqueue()) , to
make sure that the number of
threads is optimal/bounded.

Only the phase after hash table removal could benefit from your
deferral to a single context,
so that a single rcu_barrier() is active, since the part after
rcu_barrier() is damn cheap and _can_ be serialized

  if (refcount_dec_and_test(&f->refcnt))
                complete(&f->completion);

Thanks !

>
> 'cleanup_net()' and 'fqdir_work_fn()' are functions that deallocate the
> relevant memory objects.  They are asynchronously invoked by the work
> queues and internally use 'rcu_barrier()' to ensure safe destructions.
> 'cleanup_net()' works in a batched maneer in a single thread worker,
> while 'fqdir_work_fn()' works for each 'fqdir_exit()' call in the
> 'system_wq'.
>
> Therefore, 'fqdir_work_fn()' called frequently under the workload and
> made the contention for 'rcu_barrier()' high.  In more detail, the
> global mutex, 'rcu_state.barrier_mutex' became the bottleneck.
>
> I tried making 'fqdir_work_fn()' batched and confirmed it works.  The
> following patch is for the change.  I think this is the right solution
> for point fix of this issue, but someone might blame different parts.
>
> 1. User: Frequent 'unshare()' calls
> From some point of view, such frequent 'unshare()' calls might seem only
> insane.
>
> 2. Global mutex in 'rcu_barrier()'
> Because of the global mutex, 'rcu_barrier()' callers could wait long
> even after the callbacks started before the call finished.  Therefore,
> similar issues could happen in another 'rcu_barrier()' usages.  Maybe we
> can use some wait queue like mechanism to notify the waiters when the
> desired time came.
>
> I personally believe applying the point fix for now and making
> 'rcu_barrier()' improvement in longterm make sense.  If I'm missing
> something or you have different opinion, please feel free to let me
> know.
>
>
> Patch History
> -------------
>
> Changes from v1
> (https://lore.kernel.org/netdev/20201208094529.23266-1-sjpark@amazon.com/)
> - Keep xmas tree variable ordering (Jakub Kicinski)
> - Add more numbers (Eric Dumazet)
> - Use 'llist_for_each_entry_safe()' (Eric Dumazet)
>
> SeongJae Park (1):
>   net/ipv4/inet_fragment: Batch fqdir destroy works
>
>  include/net/inet_frag.h  |  2 +-
>  net/ipv4/inet_fragment.c | 28 ++++++++++++++++++++--------
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>
