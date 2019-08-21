Return-Path: <SRS0=fRmI=WR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DFAC3A59D
	for <rcu@archiver.kernel.org>; Wed, 21 Aug 2019 00:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1722DA7
	for <rcu@archiver.kernel.org>; Wed, 21 Aug 2019 00:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uB/jPvMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfHUAbv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:31:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUAbv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Aug 2019 20:31:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so247034pgb.10
        for <rcu@vger.kernel.org>; Tue, 20 Aug 2019 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGZU4to+JH2ynnItzlCfyGO2D2JXvmBS1/hQr+XjagE=;
        b=uB/jPvMMWe78gyRJ9eagqPIwLyFECzA7q9WKMBNjTU/6G2JZma4n4n/uL5m5wlB2Up
         1gfgr67skkUedIHKqO0K2SwyrOIfOXQ+qC4KShXElhiKF/jpSBtAnslqmTdfUVxmEyme
         0ezbQDoS1bljFV9jwKITiZncErcCjr9/jFEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGZU4to+JH2ynnItzlCfyGO2D2JXvmBS1/hQr+XjagE=;
        b=F/49pKiXVtg7UtA4GUUSzARVwY2kUvwe554Fp3tYHPDAbgZsA6o6FZm5zClECraj1p
         qJ6D8jUsZEW9NGJcx4gZw4uoFu9P48QRC1+eMHUCVu++stnv4NtWffwX13TjBR0B0JCA
         IJPc4gZ1raKzbFyORVnQi2Gen6/6EwK/ZcKg02qbM+epOVZuxDtcdxjEyfAHdAE77XTt
         K6J3LQWJTsZEfnfFZA/M2zJZfcDcb3p/GUuHxV/TJ15KCNsh/BR6QzpT1eOWAtIN6VLc
         f8sSyAxDNOojVA1kQGw3svbuFZc7+d4Qtvoc2Y5dOfmEEBV3Tkn8KsUU0klzVgFQT86c
         OhzQ==
X-Gm-Message-State: APjAAAXBLAZ5uRV2sFNaXofuGPJu0CeBJbyCgdNfSDBoK0q/K2/vG9iq
        E/gXmqfG/73KD53nK17brt1N3Q==
X-Google-Smtp-Source: APXvYqx4mQcarCROCbcxc7e6eWU6lk5N71VDfrOvx8fi4OIqhijc20+KY2+CYev+hSfAPmUqw5n28g==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr33404227pfd.44.1566347509699;
        Tue, 20 Aug 2019 17:31:49 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id s14sm20231752pfe.16.2019.08.20.17.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 17:31:48 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:31:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190821003132.GA25611@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
 <20190819235123.GA185164@google.com>
 <20190820025056.GL28441@linux.ibm.com>
 <20190821002705.GA212946@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821002705.GA212946@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 20, 2019 at 08:27:05PM -0400, Joel Fernandes wrote:
[snip]
> > > > Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> > > > any such separate timing, though.)
> > > 
> > > The kmalloc() times are included within the kfree loop. The timing of
> > > kfree_rcu() is not separate in my patch.
> > 
> > You lost me on this one.  What happens when you just interleave the
> > kmalloc() and kfree_rcu(), without looping, compared to the looping
> > above?  Does this get more expensive?  Cheaper?  More vulnerable to OOM?
> > Something else?
> 
> You mean pairing a single kmalloc() with a single kfree_rcu() and doing this
> several times? The results are very similar to doing kfree_alloc_num
> kmalloc()s, then do kfree_alloc_num kfree_rcu()s; and repeat the whole thing
> kfree_loops times (as done by this rcuperf patch we are reviewing).
> 
> Following are some numbers. One change is the case where we are not at all
> batching does seem to complete even faster when we fully interleave kmalloc()
> with kfree() while the case of batching in the same scenario completes at the
> same time as did the "not fully interleaved" scenario. However, the grace
> period reduction improvements and the chances of OOM'ing are pretty much the
> same in either case.
[snip]
> Not fully interleaved: do kfree_alloc_num kmallocs, then do kfree_alloc_num kfree_rcu()s. And repeat this kfree_loops times.
> =======================
> (1) Batching
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=0 rcuperf.kfree_rcu_test=1
> 
> root@(none):/# free -m
>               total        used        free      shared  buff/cache   available
> Mem:            977         251         686           0          39         684
> Swap:             0           0           0
> 
> [   15.574402] Total time taken by all kfree'ers: 14185970787 ns, loops: 20000, batches: 1548
> 
> (2) No Batching
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=1 rcuperf.kfree_rcu_test=1
> 
> root@(none):/# free -m
>               total        used        free      shared  buff/cache   available
> Mem:            977          82         855           0          39         853
> Swap:             0           0           0
> 
> [   13.724554] Total time taken by all kfree'ers: 12246217291 ns, loops: 20000, batches: 7262

And the diff for changing the test to do this case is as follows (I don't
plan to fold this diff in, since I feel the existing test suffices and
results are similar):

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 46f9c4449348..e4e4be4aaf51 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -618,18 +618,13 @@ kfree_perf_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
-	struct kfree_obj **alloc_ptrs;
+	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
-	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
-						  GFP_KERNEL);
-	if (!alloc_ptrs)
-		return -ENOMEM;
-
 	start_time = ktime_get_mono_fast_ns();
 
 	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
@@ -646,19 +641,17 @@ kfree_perf_thread(void *arg)
 	 */
 	do {
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
-			if (!alloc_ptrs[i])
+			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			if (!alloc_ptr)
 				return -ENOMEM;
-		}
 
-		for (i = 0; i < kfree_alloc_num; i++) {
 			if (!kfree_no_batch) {
-				kfree_rcu(alloc_ptrs[i], rh);
+				kfree_rcu(alloc_ptr, rh);
 			} else {
 				rcu_callback_t cb;
 
 				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
-				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
+				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
 			}
 		}
 
@@ -682,7 +675,6 @@ kfree_perf_thread(void *arg)
 		}
 	}
 
-	kfree(alloc_ptrs);
 	torture_kthread_stopping("kfree_perf_thread");
 	return 0;
 }
