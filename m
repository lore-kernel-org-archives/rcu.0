Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE9C433DB
	for <rcu@archiver.kernel.org>; Tue,  9 Feb 2021 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36CD64DDF
	for <rcu@archiver.kernel.org>; Tue,  9 Feb 2021 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBIVbi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhBIUtk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D456C0698C5;
        Tue,  9 Feb 2021 12:13:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d24so11076447lfs.8;
        Tue, 09 Feb 2021 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5+fGMZCBv+LX6Fd/SrNSAlxhhs2vLbUqZN6a29K54M=;
        b=i2BFtvhwa8jM8Pm80PbTOH8p3nPmv9T5XqNA5TMw8IQWgDorjsrQmbhTa3u4V78M35
         JO0L3ckd4RF20yngyjJasvoURRUIOaezHZgOVeCSGzGEdIC0I41wtfAi4Vb1lEVl2y62
         B800KKueJceFfJvZU3l+NKh5FnW171sxK0AYU2H1r41lhKR3kDFhJB8HZGS3KeOHWt1x
         jaEWAnxHclAphFMGt74ptSZeXBE4E8psNVzgfi9AnxT1tUm+Iv+u0WeBg31NJgV8Asks
         3nviTWt7tREDJMveptqx0y7pIZ+EOndKUj9KzT2MSkILGpuBuSs6o3Lv1P/1x0PQTn5H
         7cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5+fGMZCBv+LX6Fd/SrNSAlxhhs2vLbUqZN6a29K54M=;
        b=qSr6dIi4wjGXWXuh15idpRwPkQ4Mvmc8MCBV7RbDPc58ZrQRbq2loldvMUqWN8ukhk
         xfWfnH3envdBlqe3qXnJi8yehkELoIDcFC1lhuN0MxyYMQeNSqFYtjNbYSkcsVTm/3Ip
         CBsy/ZsEUsHTiMUBMp/pDGLu6ZKwwIJC/FdNeam06c105EyCdRhH5MDI3Rpg2l+rb6sl
         xxzpeFink78hv8zdGcPXYj+56FVX8Po+m1QAGOCmxu5a2W8Pq7d8AwlqagB7qDMuB3W9
         k8VxoQ+iYiZhtZrMOzx1LTfzgTSQIbJPhEj+2ZbfGPSUcWrfTACmakmwJPnPVF7R86IZ
         MxSw==
X-Gm-Message-State: AOAM532exYkJps6TOl5xRshI45u2vxMWwv2Cy+mk8/I89R24R5c4FX5H
        Y06jb4fqL0WbMVk2Aa70Pcc=
X-Google-Smtp-Source: ABdhPJz6E7tQtfYjvjFSMx1ax/p6QLntU6i9DZUt0BUAPsmofon+UUtpoJUQTKqm58Erk4gjDeUW4w==
X-Received: by 2002:a05:6512:1156:: with SMTP id m22mr14407253lfg.637.1612901626811;
        Tue, 09 Feb 2021 12:13:46 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f15sm1075644lfa.19.2021.02.09.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:13:45 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 9 Feb 2021 21:13:43 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Message-ID: <20210209201343.GA15619@pc638.lan>
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210204214648.GL2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204214648.GL2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 04, 2021 at 01:46:48PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 29, 2021 at 09:05:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > To stress and test a single argument of kfree_rcu() call, we
> > should to have a special coverage for it. We used to have it
> > in the test-suite related to vmalloc stressing. The reason is
> > the rcuscale is a correct place for RCU related things.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> This is a great addition, but it would be even better if there was
> a way to say "test both in one run".  One way to do this is to have
> torture_param() variables for both kfree_rcu_test_single and (say)
> kfree_rcu_test_double, both bool and both initialized to false.  If both
> have the same value (false or true) both are tested, otherwise only
> the one with value true is tested.  The value of this is that it allows
> testing of both options with one test.
> 
Make sense to me :)

From ba083a543a123455455c81230b7b5a9aa2a9cb7f Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Fri, 29 Jan 2021 19:51:27 +0100
Subject: [PATCH v2 1/1] rcuscale: add kfree_rcu() single-argument scale test

To stress and test a single argument of kfree_rcu() call, we
should to have a special coverage for it. We used to have it
in the test-suite related to vmalloc stressing. The reason is
the rcuscale is a correct place for RCU related things.

Therefore introduce two torture_param() variables, one is for
single-argument scale test and another one for double-argument
scale test.

By default kfree_rcu_test_single and kfree_rcu_test_double are
initialized to false. If both have the same value (false or true)
both are tested in one run, otherwise only the one with value
true is tested. The value of this is that it allows testing of
both options with one test.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5530db..0cde5c17f06c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
+torture_param(int, kfree_rcu_test_double, 0, "Do we run a kfree_rcu() double-argument scale test?");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -641,7 +643,7 @@ kfree_scale_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
-	struct kfree_obj *alloc_ptr;
+	struct kfree_obj *alloc_ptr[2];
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
 
@@ -665,12 +667,33 @@ kfree_scale_thread(void *arg)
 			mem_during = (mem_during + si_mem_available()) / 2;
 		}
 
+		// By default kfree_rcu_test_single and kfree_rcu_test_double are
+		// initialized to false. If both have the same value (false or true)
+		// both are tested in one run, otherwise only the one with value
+		// true is tested.
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
-			if (!alloc_ptr)
-				return -ENOMEM;
+			alloc_ptr[0] = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
+			alloc_ptr[1] = (kfree_rcu_test_single == kfree_rcu_test_double) ?
+				kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL) : NULL;
+
+			// 0 ptr. is freed either over single or double argument.
+			if (alloc_ptr[0]) {
+				if (kfree_rcu_test_single == kfree_rcu_test_double ||
+						kfree_rcu_test_single) {
+					kfree_rcu(alloc_ptr[0]);
+				} else {
+					kfree_rcu(alloc_ptr[0], rh);
+				}
+			}
+
+			// 1 ptr. is always freed over double argument.
+			if (alloc_ptr[1])
+				kfree_rcu(alloc_ptr[1], rh);
 
-			kfree_rcu(alloc_ptr, rh);
+			if (!alloc_ptr[0] ||
+					(kfree_rcu_test_single == kfree_rcu_test_double &&
+						!alloc_ptr[1]))
+				return -ENOMEM;
 		}
 
 		cond_resched();
-- 
2.20.1

--
Vlad Rezki
