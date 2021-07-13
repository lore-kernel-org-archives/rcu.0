Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F6C07E96
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 04:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57CC611F1
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 04:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhGMES5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jul 2021 00:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhGMES5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jul 2021 00:18:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDF1A611C1;
        Tue, 13 Jul 2021 04:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626149768;
        bh=gQSEfxPEb8SfRt8lkUNQ707+GbkhAy0StWkQEhuA4wQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jyXBMGpF3LmSgHWegVFYPXLaxpBWbEO1N3u/55sLlEsN+4M+WMCc7gQeD+Yihp73s
         NjnHXwjGPk7F710ROt3Q3dxIaQXHo5DzntP0H64MYh4cG9FhnAQ1fvH89yrJdJ4YkT
         CB2a/ID7XcNxw5KeAB9N+48+9PJh2/BBclvlktTJbK43sYkPikEZPCxquqyNs4gjv9
         FL4egaiOoGXQkDOlnQz8bCBu5ETkEy1TEmRRh+EtOs5lodI2lgMZRj8ob4Q/Kt7c03
         zMr77recEb+xlY0imnRckrng0n/ugNZTRd482LgOBpUigqQGTQB/+vLfKbDjrYVnHt
         1kg+j/zphndNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE0015C027D; Mon, 12 Jul 2021 21:16:07 -0700 (PDT)
Date:   Mon, 12 Jul 2021 21:16:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhouzhouyi@gmail.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713005645.8565-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> Hi Paul,
> 
> During my studying of RCU, I did a grep in the kernel source tree.
> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> should be CONFIG_TASKS_TRACE_RCU instead.
> 
> Without memory fencing, the idle/userspace task inspection may not
> be so accurate.
> 
> Thanks for your constant encouragement for my studying.
> 
> Best Wishes
> Zhouyi
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good eyes, and those could cause real bugs, so thank you!

Could you please check the wordsmithed version below?

							Thanx, Paul

------------------------------------------------------------------------

commit fdcf5524b64f2cc8e6201447644079d9f8d4c821
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue Jul 13 08:56:45 2021 +0800

    RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
    
    This commit fixes several typos where CONFIG_TASKS_RCU_TRACE should
    instead be CONFIG_TASKS_TRACE_RCU.  Among other things, these typos
    could cause CONFIG_TASKS_TRACE_RCU_READ_MB=y kernels to suffer from
    memory-ordering bugs that could result in false-positive quiescent
    states and too-short grace periods.
    
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index cfeb43bfc719..434d12fe2d4f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -167,7 +167,7 @@ void synchronize_rcu_tasks(void);
 # define synchronize_rcu_tasks synchronize_rcu
 # endif
 
-# ifdef CONFIG_TASKS_RCU_TRACE
+# ifdef CONFIG_TASKS_TRACE_RCU
 # define rcu_tasks_trace_qs(t)						\
 	do {								\
 		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 27b74352cccf..a8e3acead6f6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1498,17 +1498,17 @@ static void noinstr rcu_dynticks_task_exit(void)
 /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
 static void rcu_dynticks_task_trace_enter(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = true;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
 /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
 static void rcu_dynticks_task_trace_exit(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = false;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
