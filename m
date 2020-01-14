Return-Path: <SRS0=FQhq=3D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE4AC33C9E
	for <rcu@archiver.kernel.org>; Tue, 14 Jan 2020 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11524656
	for <rcu@archiver.kernel.org>; Tue, 14 Jan 2020 16:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q0IopxeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgANQtk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:49:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANQtk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jan 2020 11:49:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so6646595pgt.7
        for <rcu@vger.kernel.org>; Tue, 14 Jan 2020 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ayd9f3cYgl4qWDrpBjsdRYd2mAYU8sWweONj/PljPbA=;
        b=q0IopxeGBQcol9tKXjrIxXw4M22bIyKZ/H0CD7tcK5oNf3ih/2hYCmdTw3T2mlLpVN
         K1740k2EmgIUpEIde0oLp+1K8RDo10D1L2eYXchk2ATwn/oV4iz1NaoMtLgHslqhXuRP
         hAsLD01aKVGfO7GYPYpg2aWXCwUStdIDyxfVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ayd9f3cYgl4qWDrpBjsdRYd2mAYU8sWweONj/PljPbA=;
        b=V95L3eFa9XgwXFnK8PTH7x4b5CIiN1IOHCyCQu4qfgF07snC9LIIx8f38ySa6deQjt
         HeOJ28PI12J3Nm73N2F0ZlZVlHQyPFqdWcFu4tt1IyJ6eJnzlbUwYqgDX5DQ94Bl2l9o
         yGR114/bb65I4aGaH1jBoSV0NVSNsfF3WmPKH8tCHGoQf6XD0QAj5/s1U8uHSoaluj3t
         /fEO2QUeCTo+HWdrswkO7sUU5PE8urVJr6V6ZY2tBhj4BtrSBSAkIqxkgJXe8WDvEqHu
         Ud2JJCVBAzXhFrD4zx9MXDqxAsGablkrKyyHly6oggbdkp+ZlEaa/IGiTZOR8HLNdmeu
         FP2A==
X-Gm-Message-State: APjAAAWaqZtiQyMYK/QYaqukW8AD+TsD+7aSK6Y1QzGxA9AEOx26jEJ4
        bIotuU5YD5c3KNcE94Abkztgcw==
X-Google-Smtp-Source: APXvYqxE3J+uShSftk2i77xK0VkwTN6jbDtvsEOSCPgxU/LuxRSrFHr7fwvb4op59vrZ8KmIueJowA==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr28011076pga.118.1579020579313;
        Tue, 14 Jan 2020 08:49:39 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j28sm18549513pgb.36.2020.01.14.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:49:38 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:49:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200114164937.GA50403@google.com>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113190315.GA12543@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, Jan 13, 2020 at 11:03:15AM -0800, Paul E. McKenney wrote:
> On Tue, Dec 31, 2019 at 01:22:41PM +0100, Uladzislau Rezki (Sony) wrote:
> > kfree_rcu() logic can be improved further by using kfree_bulk()
> > interface along with "basic batching support" introduced earlier.
> > 
> > The are at least two advantages of using "bulk" interface:
> > - in case of large number of kfree_rcu() requests kfree_bulk()
> >   reduces the per-object overhead caused by calling kfree()
> >   per-object.
> > 
> > - reduces the number of cache-misses due to "pointer chasing"
> >   between objects which can be far spread between each other.
> > 
> > This approach defines a new kfree_rcu_bulk_data structure that
> > stores pointers in an array with a specific size. Number of entries
> > in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
> > structure to be exactly one page.
> > 
> > Since it deals with "block-chain" technique there is an extra
> > need in dynamic allocation when a new block is required. Memory
> > is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> > allows to skip direct reclaim under low memory condition to
> > prevent stalling and fails silently under high memory pressure.
> > 
> > The "emergency path" gets maintained when a system is run out
> > of memory. In that case objects are linked into regular list
> > and that is it.
> > 
> > In order to evaluate it, the "rcuperf" was run to analyze how
> > much memory is consumed and what is kfree_bulk() throughput.
> > 
> > Testing on the HiKey-960, arm64, 8xCPUs with below parameters:
> > 
> > CONFIG_SLAB=y
> > kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> > 
> > 102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
> > 89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB
> > 
> > rcuperf shows approximately ~12% better throughput(Total time)
> > in case of using "bulk" interface. The "drain logic" or its RCU
> > callback does the work faster that leads to better throughput.
> 
> Nice improvement!
> 
> But rcuperf uses a single block size, which turns into kfree_bulk() using
> a single slab, which results in good locality of reference.  So I have to

You meant a "single cache" category when you say "single slab"? Just to
mention, the number of slabs (in a single cache) when a large number of
objects are allocated is more than 1 (not single). With current rcuperf, I
see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
32-byte slab object).

> ask...  Is this performance result representative of production workloads?

I added more variation to allocation sizes to rcuperf (patch below) to distribute
allocations across 4 kmalloc slabs (32,64,96 and 128) and I see a signficant
improvement with Ulad's patch in SLAB in terms of completion time of the
test. Below are the results. With SLUB I see slightly higher memory
footprint, I have never used SLUB and not sure who is using it so I am not
too concerned since the degradation in memory footprint is only slight with
SLAB having the signifcant improvement.

with SLAB:

with Ulad's patch:
[   19.096052] Total time taken by all kfree'ers: 17519684419 ns, loops: 10000, batches: 3378, memory footprint: 319MB
[   18.980837] Total time taken by all kfree'ers: 17460918969 ns, loops: 10000, batches: 3399, memory footprint: 312MB
[   18.671535] Total time taken by all kfree'ers: 17116640301 ns, loops: 10000, batches: 3331, memory footprint: 268MB
[   18.737601] Total time taken by all kfree'ers: 17227635828 ns, loops: 10000, batches: 3311, memory footprint: 329MB

without Ulad's patch:
[   22.679112] Total time taken by all kfree'ers: 21174999896 ns, loops: 10000, batches: 2722, memory footprint: 314MB
[   22.099168] Total time taken by all kfree'ers: 20528110989 ns, loops: 10000, batches: 2611, memory footprint: 240MB
[   22.477571] Total time taken by all kfree'ers: 20975674614 ns, loops: 10000, batches: 2763, memory footprint: 341MB
[   22.772915] Total time taken by all kfree'ers: 21207270347 ns, loops: 10000, batches: 2765, memory footprint: 329MB

with SLUB:

without Ulad's patch:
[   10.714471] Total time taken by all kfree'ers: 9216968353 ns, loops: 10000, batches: 1099, memory footprint: 393MB
[   11.188174] Total time taken by all kfree'ers: 9613032449 ns, loops: 10000, batches: 1147, memory footprint: 387MB
[   11.077431] Total time taken by all kfree'ers: 9547675890 ns, loops: 10000, batches: 1292, memory footprint: 296MB
[   11.212767] Total time taken by all kfree'ers: 9712869591 ns, loops: 10000, batches: 1155, memory footprint: 387MB


with Ulad's patch
[   11.241949] Total time taken by all kfree'ers: 9681912225 ns, loops: 10000, batches: 1087, memory footprint: 417MB
[   11.651831] Total time taken by all kfree'ers: 10154268745 ns, loops: 10000, batches: 1184, memory footprint: 416MB
[   11.342659] Total time taken by all kfree'ers: 9844937317 ns, loops: 10000, batches: 1137, memory footprint: 477MB
[   11.718769] Total time taken by all kfree'ers: 10138649532 ns, loops: 10000, batches: 1159, memory footprint: 395MB

Test patch for rcuperf is below. The memory footprint measurement for rcuperf
is still under discussion in another thread, but I tested based on that anyway:

---8<-----------------------

From d44e4c6112c388d39f7c2241e061dd77cca28d9e Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 14 Jan 2020 09:59:23 -0500
Subject: [PATCH] rcuperf: Add support to vary the slab object sizes

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/rcu/rcuperf.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index a4a8d097d84d..216d7c072ca2 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -600,17 +600,29 @@ static int kfree_nrealthreads;
 static atomic_t n_kfree_perf_thread_started;
 static atomic_t n_kfree_perf_thread_ended;
 
-struct kfree_obj {
-	char kfree_obj[8];
-	struct rcu_head rh;
-};
+/*
+ * Define a kfree_obj with size as the @size parameter + the size of rcu_head
+ * (rcu_head is 16 bytes on 64-bit arch).
+ */
+#define DEFINE_KFREE_OBJ(size)	\
+struct kfree_obj_ ## size {	\
+	char kfree_obj[size];	\
+	struct rcu_head rh;	\
+}
+
+/* This should goto the right sized slabs on both 32-bit and 64-bit arch */
+DEFINE_KFREE_OBJ(16); // goes on kmalloc-32 slab
+DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
+DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
+DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
 static int
 kfree_perf_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
-	struct kfree_obj *alloc_ptr;
+	void *alloc_ptr;
+
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
 
@@ -635,11 +647,28 @@ kfree_perf_thread(void *arg)
 		}
 
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			int kfree_type = i % 4;
+
+			if (kfree_type == 0)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_16), GFP_KERNEL);
+			else if (kfree_type == 1)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_32), GFP_KERNEL);
+			else if (kfree_type == 2)
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_64), GFP_KERNEL);
+			else
+				alloc_ptr = kmalloc(sizeof(struct kfree_obj_96),  GFP_KERNEL);
+
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			if (kfree_type == 0)
+				kfree_rcu((struct kfree_obj_16 *)alloc_ptr, rh);
+			else if (kfree_type == 1)
+				kfree_rcu((struct kfree_obj_32 *)alloc_ptr, rh);
+			else if (kfree_type == 2)
+				kfree_rcu((struct kfree_obj_64 *)alloc_ptr, rh);
+			else
+				kfree_rcu((struct kfree_obj_96 *)alloc_ptr, rh);
 		}
 
 		cond_resched();
-- 
2.25.0.rc1.283.g88dfdc4193-goog

