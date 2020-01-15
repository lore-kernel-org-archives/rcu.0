Return-Path: <SRS0=sWdW=3E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552EFC33CB3
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE22187F
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ucxBhF9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgAOWxx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:53:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgAOWxx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jan 2020 17:53:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so8870356pgk.12
        for <rcu@vger.kernel.org>; Wed, 15 Jan 2020 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GBzXufLzDJf0sHQ0gmQgUghK5kTG0Zw6fGrZMAl/WRE=;
        b=ucxBhF9gmKhxRRTHRgzyBJg6UBrPac7VbqHUe7y+eA2oWfMo7S1mHzCLfF5G53q+nw
         mhY1WlZWdY6b7/7VlGZNciC6Dp/hI6ujEroAPpL9n53b5QZTVNtgeVmsi+JrYbc0USMC
         OVlEuT7fy8WJSdmgJOcMneIzsoGx6Cb7SELBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GBzXufLzDJf0sHQ0gmQgUghK5kTG0Zw6fGrZMAl/WRE=;
        b=j6pcpD8Oh7ZMPhctLnKg4qDyaEA1AxjSfNgqdaGcI8lal6ZcdPRBYSaPUVe4D9Tjw2
         8dTPEP9IMxuuqTawzBYvo2jEromaWkw9v4CcPstX/3wohlhAK1i1/rY4ySdRjo/mtwyh
         j8K85Ub/Ailz2dAFfHtqwUODBFqXq1aFZkMmbWuWM+sxZyEyiRYRzn0iu1UwxsKsZdZv
         idKQjjbRc+416AxGOJDaUeOGzw8XB7ci6ExpiPefT6ChFWbMUWhbuJZy4cmSdNGg5uoE
         K8LmDdyOQvz1meqpVEZULUJ6UF0pHoQWZJhzeLc+T3s1DK2z+gSdqsN3aZ7O/0AOugpr
         claA==
X-Gm-Message-State: APjAAAUX2bOoLajEst/pByocsHL05qck//PbasrXuT0lnUpwSXu4Y4lA
        KxgVK9ASSXcKogRTGnGd2vQ6+g==
X-Google-Smtp-Source: APXvYqwCafHlO3bZd2DN42C9FNLol8CwUcxt9NFfWW2vdlC5Dt685s8SPAss2EZqyC090EuG1aF25w==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr35095028pfa.244.1579128832241;
        Wed, 15 Jan 2020 14:53:52 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 11sm23508325pfz.25.2020.01.15.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:53:51 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:53:50 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200115225350.GA246464@google.com>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115131446.GA18417@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 02:14:46PM +0100, Uladzislau Rezki wrote:
> Hello, Joel, Paul.
> 
> Thank you for comments and testing!
> 
> > > 
> > > Nice improvement!
> > > 
> > > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > > a single slab, which results in good locality of reference.  So I have to
> > 
> > You meant a "single cache" category when you say "single slab"? Just to
> > mention, the number of slabs (in a single cache) when a large number of
> > objects are allocated is more than 1 (not single). With current rcuperf, I
> > see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> > slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> > 32-byte slab object).
> > 
> I think that is about using different slab caches to break locality. It
> makes sense, IMHO, because usually the system make use of different slabs,
> because of different object sizes. From the other hand i guess there are
> test cases when only one slab gets used.

I was wondering about "locality". A cache can be split into many slabs. Only
the data on a page is local (contiguous). If there are a large number of
objects, then it goes to a new slab (on the same cache). At least on the
kmalloc slabs, there is only 1 slab per page. So for example, if on
kmalloc-32 slab, there are more than 128 objects, then it goes to a different
slab / page. So how is there still locality?

Further the slab (not sure about slub) doesn't seem to do anything at the
moment to take advantage of locality within a slab.

That said, I am fully supportive of your patch and see the same
improvements as well which are for the reasons you mentioned in the changelog.

> > > ask...  Is this performance result representative of production workloads?
> > 
> > I added more variation to allocation sizes to rcuperf (patch below) to distribute
> > allocations across 4 kmalloc slabs (32,64,96 and 128) and I see a signficant
> > improvement with Ulad's patch in SLAB in terms of completion time of the
> > test. Below are the results. With SLUB I see slightly higher memory
> > footprint, I have never used SLUB and not sure who is using it so I am not
> > too concerned since the degradation in memory footprint is only slight with
> > SLAB having the signifcant improvement.
> > 
> Nice patch! I think, it would be useful to have it in "rcuperf" tool with
> extra parameter like "different_obj_sizes".

cool, I posted something like this.

> > 2.25.0.rc1.283.g88dfdc4193-goog
> I also have done some tests with your patch on my Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz, 12xCPUs
> machine to simulate different slab usage:
> 
> dev.2020.01.10a branch
> 
> # Default, CONFIG_SLAB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
> [   83.762963] Total time taken by all kfree'ers: 53607352517 ns, loops: 200000, batches: 1885, memory footprint: 1248MB
> [   80.108401] Total time taken by all kfree'ers: 53529637912 ns, loops: 200000, batches: 1921, memory footprint: 1193MB
> [   76.622252] Total time taken by all kfree'ers: 53570175705 ns, loops: 200000, batches: 1929, memory footprint: 1250MB
> 
> # With the patch, CONFIG_SLAB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
> [   48.265008] Total time taken by all kfree'ers: 23981587315 ns, loops: 200000, batches: 810, memory footprint: 1219MB
> [   53.263943] Total time taken by all kfree'ers: 23879375281 ns, loops: 200000, batches: 822, memory footprint: 1190MB
> [   50.366440] Total time taken by all kfree'ers: 24086841707 ns, loops: 200000, batches: 794, memory footprint: 1380MB
> 
> # Default, CONFIG_SLUB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
> [   81.818576] Total time taken by all kfree'ers: 51291025022 ns, loops: 200000, batches: 1713, memory footprint: 741MB
> [   77.854866] Total time taken by all kfree'ers: 51278911477 ns, loops: 200000, batches: 1671, memory footprint: 719MB
> [   76.329577] Total time taken by all kfree'ers: 51256183045 ns, loops: 200000, batches: 1719, memory footprint: 647MB
> 
> # With the patch, CONFIG_SLUB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
> [   76.254485] Total time taken by all kfree'ers: 50709919132 ns, loops: 200000, batches: 1618, memory footprint: 456MB
> [   75.891521] Total time taken by all kfree'ers: 50736297452 ns, loops: 200000, batches: 1633, memory footprint: 507MB
> [   76.172573] Total time taken by all kfree'ers: 50660403893 ns, loops: 200000, batches: 1628, memory footprint: 429MB
> 
> in case of CONFIG_SLAB there is double increase in performance but slightly higher memory usage.
> As for CONFIG_SLUB, i still see higher performance figures + lower memory usage with the patch.

Ok, testing today, our results are quite similar.

> 
> Apart of that, I have got the report from the "kernel test robot":
> <snip>
> [   13.957168] ------------[ cut here ]------------
> [   13.958256] ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
> [   13.962148] WARNING: CPU: 0 PID: 212 at lib/debugobjects.c:484 debug_print_object+0x95/0xd0
> [   13.964298] Modules linked in:
> [   13.964960] CPU: 0 PID: 212 Comm: kworker/0:2 Not tainted 5.5.0-rc1-00136-g883a2cefc0684 #1
> [   13.966712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   13.968528] Workqueue: events kfree_rcu_work
> [   13.969466] RIP: 0010:debug_print_object+0x95/0xd0
> [   13.970480] Code: d2 e8 2f 06 d6 ff 8b 43 10 4d 89 f1 4c 89 e6 8b 4b 14 48 c7 c7 88 73 be 82 4d 8b 45 00 48 8b 14 c5 a0 5f 6d 82 e8 7b 65 c6 ff <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 98 b8 0c 83 e8
> [   13.974435] RSP: 0000:ffff888231677bf8 EFLAGS: 00010282
> [   13.975531] RAX: 0000000000000000 RBX: ffff88822d4200e0 RCX: 0000000000000000
> [   13.976730] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8306e028
> [   13.977568] RBP: ffff888231677c18 R08: 0000000000000000 R09: ffff888231670790
> [   13.978412] R10: ffff888231670000 R11: 0000000000000003 R12: ffffffff82bc5299
> [   13.979250] R13: ffffffff82e77360 R14: 0000000000000000 R15: dead000000000100
> [   13.980089] FS:  0000000000000000(0000) GS:ffffffff82e4f000(0000) knlGS:0000000000000000
> [   13.981069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.981746] CR2: 00007f1e913fc77c CR3: 0000000225ce9000 CR4: 00000000000006f0
> [   13.982587] Call Trace:
> [   13.982911]  __debug_check_no_obj_freed+0x19a/0x200
> [   13.983494]  debug_check_no_obj_freed+0x14/0x20
> [   13.984036]  free_pcp_prepare+0xee/0x1d0
> [   13.984541]  free_unref_page+0x1b/0x80
> [   13.984994]  __free_pages+0x19/0x20
> [   13.985503]  __free_pages+0x13/0x20
> [   13.985924]  slob_free_pages+0x7d/0x90
> [   13.986373]  slob_free+0x34f/0x530
> [   13.986784]  kfree+0x154/0x210
> [   13.987155]  __kmem_cache_free_bulk+0x44/0x60
> [   13.987673]  kmem_cache_free_bulk+0xe/0x10
> [   13.988163]  kfree_rcu_work+0x95/0x310
> [   13.989010]  ? kfree_rcu_work+0x64/0x310
> [   13.989884]  process_one_work+0x378/0x7c0
> [   13.990770]  worker_thread+0x40/0x600
> [   13.991587]  kthread+0x14e/0x170
> [   13.992344]  ? process_one_work+0x7c0/0x7c0
> [   13.993256]  ? kthread_create_on_node+0x70/0x70
> [   13.994246]  ret_from_fork+0x3a/0x50
> [   13.995039] ---[ end trace cdf242638b0e32a0 ]---
> [child0:632] trace_fd was -1
> <snip>
> 
> the trace happens when the kernel is built with CONFIG_DEBUG_OBJECTS_FREE
> and CONFIG_DEBUG_OBJECTS_RCU_HEAD. Basically it is not a problem of the patch
> itself or there is any bug there. It just does not pair with debug_rcu_head_queue(head)
> in the kfree_rcu_work() function, that is why the kernel thinks about freeing
> an active object that is not active in reality.
> 
> I will upload a V2 to fix that.

Oh good point. Thanks for fixing that.

thanks,

 - Joel

