Return-Path: <SRS0=sWdW=3E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF56C33CB1
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 13:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4972084D
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuI7sqWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAONO7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:14:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41029 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgAONO7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jan 2020 08:14:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so18506129ljc.8;
        Wed, 15 Jan 2020 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=We0P8Pq+KXemR/laZ1JLyQrh4KCjCcSAXP2L4Y8y67I=;
        b=PuI7sqWf0HYkhdy+s8zWqNG3v4bq4Ylmsp5svdRo276MtE18hgWifftzLg9NGBS851
         9fD8gsx7VJCA/S6RhESxLehsOhKqbEiG75A+zKmcakL8TodmtrT0KnNa6QTvWqpz45CX
         4KzJLTNx6U1S8z7IXjSD7vuYgMQnvDikMVvslXmcCX6LGU0/9kMLsoiT4m5GcOYNoLah
         rD1Y4EbDvA+5+2ilYUK7oNINkI/etAcJisI/rYs1c5KkKfV5CE2jHgSzcsCJzL1mUR6d
         vHg5kdhJQIJxLRWDTWFYFoRgUMp8JNUZe0MVskF9y/R5nubz0YFoqjvgqJg1wUfUUDkW
         S9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=We0P8Pq+KXemR/laZ1JLyQrh4KCjCcSAXP2L4Y8y67I=;
        b=N2UayrsRq1LjXDv+qhu2rGYwfCVN7rl7K6SSdtedZRWKSKMr2LXqYTbufplhLtwAFw
         1lbuzMJY/oiBp0y2PpPOAFNRFeeXnPrn/4lp7CAHsX0jrRpUG7X4IKNOKpEv2EehcBo8
         TFLEVJe1l9igyKpOs/3mLnO40xwDkFaxgTjVJeLKXZTBtu8TnkvCR7xYKpcFeWOGEWbt
         0f1GCnmZRj7Y7v2YBXdQ6gUKeOwTxtcMDIxZjrukn1rWnAV75fHfL57K8UJn4tFfK9az
         tomu7OGg27Q8KAd9n5Y1sSKbmGVhCOsxUI1YQiH/vTexR+EaE37vaUjSiuCXx2xLKnfV
         +mzw==
X-Gm-Message-State: APjAAAUjXnSV77PIvS4NpIoHTe0Gtn1eY/5UHrkI8Uiplmg8yhAxc/Eu
        7MkHWZg5JAme+yt6ehVItQ0=
X-Google-Smtp-Source: APXvYqwdwTsWVarBR4K8mtwUBdmdzTPPkx2HeVBnpubnFKG06kLYZBmKObc8TYNAp7mKbfDq67Gp9A==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr1749991ljo.153.1579094096078;
        Wed, 15 Jan 2020 05:14:56 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id k5sm8909991lfd.86.2020.01.15.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 05:14:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Jan 2020 14:14:46 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200115131446.GA18417@pc636>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114164937.GA50403@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel, Paul.

Thank you for comments and testing!

> > 
> > Nice improvement!
> > 
> > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > a single slab, which results in good locality of reference.  So I have to
> 
> You meant a "single cache" category when you say "single slab"? Just to
> mention, the number of slabs (in a single cache) when a large number of
> objects are allocated is more than 1 (not single). With current rcuperf, I
> see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> 32-byte slab object).
> 
I think that is about using different slab caches to break locality. It
makes sense, IMHO, because usually the system make use of different slabs,
because of different object sizes. From the other hand i guess there are
test cases when only one slab gets used.

> > ask...  Is this performance result representative of production workloads?
> 
> I added more variation to allocation sizes to rcuperf (patch below) to distribute
> allocations across 4 kmalloc slabs (32,64,96 and 128) and I see a signficant
> improvement with Ulad's patch in SLAB in terms of completion time of the
> test. Below are the results. With SLUB I see slightly higher memory
> footprint, I have never used SLUB and not sure who is using it so I am not
> too concerned since the degradation in memory footprint is only slight with
> SLAB having the signifcant improvement.
> 
Nice patch! I think, it would be useful to have it in "rcuperf" tool with
extra parameter like "different_obj_sizes".

> with SLAB:
> 
> with Ulad's patch:
> [   19.096052] Total time taken by all kfree'ers: 17519684419 ns, loops: 10000, batches: 3378, memory footprint: 319MB
> [   18.980837] Total time taken by all kfree'ers: 17460918969 ns, loops: 10000, batches: 3399, memory footprint: 312MB
> [   18.671535] Total time taken by all kfree'ers: 17116640301 ns, loops: 10000, batches: 3331, memory footprint: 268MB
> [   18.737601] Total time taken by all kfree'ers: 17227635828 ns, loops: 10000, batches: 3311, memory footprint: 329MB
> 
> without Ulad's patch:
> [   22.679112] Total time taken by all kfree'ers: 21174999896 ns, loops: 10000, batches: 2722, memory footprint: 314MB
> [   22.099168] Total time taken by all kfree'ers: 20528110989 ns, loops: 10000, batches: 2611, memory footprint: 240MB
> [   22.477571] Total time taken by all kfree'ers: 20975674614 ns, loops: 10000, batches: 2763, memory footprint: 341MB
> [   22.772915] Total time taken by all kfree'ers: 21207270347 ns, loops: 10000, batches: 2765, memory footprint: 329MB
> 
> with SLUB:
> 
> without Ulad's patch:
> [   10.714471] Total time taken by all kfree'ers: 9216968353 ns, loops: 10000, batches: 1099, memory footprint: 393MB
> [   11.188174] Total time taken by all kfree'ers: 9613032449 ns, loops: 10000, batches: 1147, memory footprint: 387MB
> [   11.077431] Total time taken by all kfree'ers: 9547675890 ns, loops: 10000, batches: 1292, memory footprint: 296MB
> [   11.212767] Total time taken by all kfree'ers: 9712869591 ns, loops: 10000, batches: 1155, memory footprint: 387MB
> 
> 
> with Ulad's patch
> [   11.241949] Total time taken by all kfree'ers: 9681912225 ns, loops: 10000, batches: 1087, memory footprint: 417MB
> [   11.651831] Total time taken by all kfree'ers: 10154268745 ns, loops: 10000, batches: 1184, memory footprint: 416MB
> [   11.342659] Total time taken by all kfree'ers: 9844937317 ns, loops: 10000, batches: 1137, memory footprint: 477MB
> [   11.718769] Total time taken by all kfree'ers: 10138649532 ns, loops: 10000, batches: 1159, memory footprint: 395MB
> 
> Test patch for rcuperf is below. The memory footprint measurement for rcuperf
> is still under discussion in another thread, but I tested based on that anyway:
> 
> ---8<-----------------------
> 
> From d44e4c6112c388d39f7c2241e061dd77cca28d9e Mon Sep 17 00:00:00 2001
> From: Joel Fernandes <joelaf@google.com>
> Date: Tue, 14 Jan 2020 09:59:23 -0500
> Subject: [PATCH] rcuperf: Add support to vary the slab object sizes
> 
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/rcu/rcuperf.c | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index a4a8d097d84d..216d7c072ca2 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -600,17 +600,29 @@ static int kfree_nrealthreads;
>  static atomic_t n_kfree_perf_thread_started;
>  static atomic_t n_kfree_perf_thread_ended;
>  
> -struct kfree_obj {
> -	char kfree_obj[8];
> -	struct rcu_head rh;
> -};
> +/*
> + * Define a kfree_obj with size as the @size parameter + the size of rcu_head
> + * (rcu_head is 16 bytes on 64-bit arch).
> + */
> +#define DEFINE_KFREE_OBJ(size)	\
> +struct kfree_obj_ ## size {	\
> +	char kfree_obj[size];	\
> +	struct rcu_head rh;	\
> +}
> +
> +/* This should goto the right sized slabs on both 32-bit and 64-bit arch */
> +DEFINE_KFREE_OBJ(16); // goes on kmalloc-32 slab
> +DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
> +DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
> +DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
>  
>  static int
>  kfree_perf_thread(void *arg)
>  {
>  	int i, loop = 0;
>  	long me = (long)arg;
> -	struct kfree_obj *alloc_ptr;
> +	void *alloc_ptr;
> +
>  	u64 start_time, end_time;
>  	long long mem_begin, mem_during = 0;
>  
> @@ -635,11 +647,28 @@ kfree_perf_thread(void *arg)
>  		}
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			int kfree_type = i % 4;
> +
> +			if (kfree_type == 0)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_16), GFP_KERNEL);
> +			else if (kfree_type == 1)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_32), GFP_KERNEL);
> +			else if (kfree_type == 2)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_64), GFP_KERNEL);
> +			else
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_96),  GFP_KERNEL);
> +
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			if (kfree_type == 0)
> +				kfree_rcu((struct kfree_obj_16 *)alloc_ptr, rh);
> +			else if (kfree_type == 1)
> +				kfree_rcu((struct kfree_obj_32 *)alloc_ptr, rh);
> +			else if (kfree_type == 2)
> +				kfree_rcu((struct kfree_obj_64 *)alloc_ptr, rh);
> +			else
> +				kfree_rcu((struct kfree_obj_96 *)alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
I also have done some tests with your patch on my Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz, 12xCPUs
machine to simulate different slab usage:

dev.2020.01.10a branch

# Default, CONFIG_SLAB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
[   83.762963] Total time taken by all kfree'ers: 53607352517 ns, loops: 200000, batches: 1885, memory footprint: 1248MB
[   80.108401] Total time taken by all kfree'ers: 53529637912 ns, loops: 200000, batches: 1921, memory footprint: 1193MB
[   76.622252] Total time taken by all kfree'ers: 53570175705 ns, loops: 200000, batches: 1929, memory footprint: 1250MB

# With the patch, CONFIG_SLAB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
[   48.265008] Total time taken by all kfree'ers: 23981587315 ns, loops: 200000, batches: 810, memory footprint: 1219MB
[   53.263943] Total time taken by all kfree'ers: 23879375281 ns, loops: 200000, batches: 822, memory footprint: 1190MB
[   50.366440] Total time taken by all kfree'ers: 24086841707 ns, loops: 200000, batches: 794, memory footprint: 1380MB

# Default, CONFIG_SLUB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
[   81.818576] Total time taken by all kfree'ers: 51291025022 ns, loops: 200000, batches: 1713, memory footprint: 741MB
[   77.854866] Total time taken by all kfree'ers: 51278911477 ns, loops: 200000, batches: 1671, memory footprint: 719MB
[   76.329577] Total time taken by all kfree'ers: 51256183045 ns, loops: 200000, batches: 1719, memory footprint: 647MB

# With the patch, CONFIG_SLUB, kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1, 16, 32, 64, 96 obj sizes
[   76.254485] Total time taken by all kfree'ers: 50709919132 ns, loops: 200000, batches: 1618, memory footprint: 456MB
[   75.891521] Total time taken by all kfree'ers: 50736297452 ns, loops: 200000, batches: 1633, memory footprint: 507MB
[   76.172573] Total time taken by all kfree'ers: 50660403893 ns, loops: 200000, batches: 1628, memory footprint: 429MB

in case of CONFIG_SLAB there is double increase in performance but slightly higher memory usage.
As for CONFIG_SLUB, i still see higher performance figures + lower memory usage with the patch.

Apart of that, I have got the report from the "kernel test robot":

<snip>
[   13.957168] ------------[ cut here ]------------
[   13.958256] ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
[   13.962148] WARNING: CPU: 0 PID: 212 at lib/debugobjects.c:484 debug_print_object+0x95/0xd0
[   13.964298] Modules linked in:
[   13.964960] CPU: 0 PID: 212 Comm: kworker/0:2 Not tainted 5.5.0-rc1-00136-g883a2cefc0684 #1
[   13.966712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   13.968528] Workqueue: events kfree_rcu_work
[   13.969466] RIP: 0010:debug_print_object+0x95/0xd0
[   13.970480] Code: d2 e8 2f 06 d6 ff 8b 43 10 4d 89 f1 4c 89 e6 8b 4b 14 48 c7 c7 88 73 be 82 4d 8b 45 00 48 8b 14 c5 a0 5f 6d 82 e8 7b 65 c6 ff <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 98 b8 0c 83 e8
[   13.974435] RSP: 0000:ffff888231677bf8 EFLAGS: 00010282
[   13.975531] RAX: 0000000000000000 RBX: ffff88822d4200e0 RCX: 0000000000000000
[   13.976730] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8306e028
[   13.977568] RBP: ffff888231677c18 R08: 0000000000000000 R09: ffff888231670790
[   13.978412] R10: ffff888231670000 R11: 0000000000000003 R12: ffffffff82bc5299
[   13.979250] R13: ffffffff82e77360 R14: 0000000000000000 R15: dead000000000100
[   13.980089] FS:  0000000000000000(0000) GS:ffffffff82e4f000(0000) knlGS:0000000000000000
[   13.981069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.981746] CR2: 00007f1e913fc77c CR3: 0000000225ce9000 CR4: 00000000000006f0
[   13.982587] Call Trace:
[   13.982911]  __debug_check_no_obj_freed+0x19a/0x200
[   13.983494]  debug_check_no_obj_freed+0x14/0x20
[   13.984036]  free_pcp_prepare+0xee/0x1d0
[   13.984541]  free_unref_page+0x1b/0x80
[   13.984994]  __free_pages+0x19/0x20
[   13.985503]  __free_pages+0x13/0x20
[   13.985924]  slob_free_pages+0x7d/0x90
[   13.986373]  slob_free+0x34f/0x530
[   13.986784]  kfree+0x154/0x210
[   13.987155]  __kmem_cache_free_bulk+0x44/0x60
[   13.987673]  kmem_cache_free_bulk+0xe/0x10
[   13.988163]  kfree_rcu_work+0x95/0x310
[   13.989010]  ? kfree_rcu_work+0x64/0x310
[   13.989884]  process_one_work+0x378/0x7c0
[   13.990770]  worker_thread+0x40/0x600
[   13.991587]  kthread+0x14e/0x170
[   13.992344]  ? process_one_work+0x7c0/0x7c0
[   13.993256]  ? kthread_create_on_node+0x70/0x70
[   13.994246]  ret_from_fork+0x3a/0x50
[   13.995039] ---[ end trace cdf242638b0e32a0 ]---
[child0:632] trace_fd was -1
<snip>

the trace happens when the kernel is built with CONFIG_DEBUG_OBJECTS_FREE
and CONFIG_DEBUG_OBJECTS_RCU_HEAD. Basically it is not a problem of the patch
itself or there is any bug there. It just does not pair with debug_rcu_head_queue(head)
in the kfree_rcu_work() function, that is why the kernel thinks about freeing
an active object that is not active in reality.

I will upload a V2 to fix that.

--
Vlad Rezki
