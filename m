Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21845C4332F
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 16:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKYQFU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKYQFT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 11:05:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5824C249
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 08:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA0A8B82B4C
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 16:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E69C433D6;
        Fri, 25 Nov 2022 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669392316;
        bh=FV2UvZaeNaDKSVAG9i53DH2c/RgN9HJcKp02vLHLHK4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hitxecCt47emte2SBzELfZcECol0Nv7oLtiFT4eNLjg0ftwVnH8FEaTEaWenjTkFL
         nfgC0XB0HLzLg0MRGcqS6xc5VATBKbRp14fXR/MEUVyVel0v5JUVd9rmwIWPTR125T
         BaWXzXA7yEC0r4QJNaIsKXhJMMSNTyKRE1Rhc7IZ3zs02L7NA+4+zzgWS2LNJceJnN
         Mu9Da4tSbcwG84Rwi+FXekQbqIooCDS0aEK3GNTjwsjFYk9uSh7CXAQoSnpqmbkkBb
         99L5goo4uspAsDfdRwOaCWf84Raqif0t/egJlJW/SkS9GpNTNjMI2dFK98EoBWgK7t
         /lL0RvW65Lh9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2898D5C09A9; Fri, 25 Nov 2022 08:05:16 -0800 (PST)
Date:   Fri, 25 Nov 2022 08:05:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     urezki@gmail.com
Cc:     rcu@vger.kernel.org
Subject: get_state_synchronize_rcu() at boot time
Message-ID: <20221125160516.GA303456@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Uladzislau,

Here is where I placed that probe code and the corresponding output.
Where should I be placing it instead?

						Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 219b4b516f387..308cbc5e68a64 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4546,8 +4546,17 @@ void rcu_scheduler_starting(void)
 	local_irq_restore(flags);
 
 	// Switch out of early boot mode.
+	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
+	synchronize_rcu();
+	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
 	rcu_scheduler_active = RCU_SCHEDULER_INIT;
+	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
+	synchronize_rcu();
+	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
 	rcu_test_sync_prims();
+	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
+	synchronize_rcu();
+	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
 }
 
 /*
@@ -4817,6 +4826,9 @@ void __init rcu_init(void)
 
 	kfree_rcu_batch_init();
 	rcu_bootup_announce();
+	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
+	synchronize_rcu();
+	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
 	sanitize_kthread_prio();
 	rcu_init_geometry();
 	rcu_init_one();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 7b1e183b0eb23..2993be46f81d5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -557,9 +557,12 @@ struct early_boot_kfree_rcu {
 static void early_boot_test_call_rcu(void)
 {
 	static struct rcu_head head;
+	int idx;
 	static struct rcu_head shead;
 	struct early_boot_kfree_rcu *rhp;
 
+	idx = srcu_down_read(&early_srcu);
+	srcu_up_read(&early_srcu, idx);
 	call_rcu(&head, test_callback);
 	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
 	call_srcu(&early_srcu, &shead, test_callback);

------------------------------------------------------------------------

[    0.016333] rcu: -> [0] Invoke synchronize_rcu(): seq number: 12
[    0.016334] rcu: -> [0] Done. A seq number: 16
[    0.114209] rcu: -> [0] Invoke synchronize_rcu(): seq number: 32
[    0.114662] rcu: -> [0] Done. A seq number: 36
[    0.115191] rcu: -> [0] Invoke synchronize_rcu(): seq number: 36
[    0.115684] rcu: -> [0] Done. A seq number: 40
[    0.116046] rcu: -> [0] Invoke synchronize_rcu(): seq number: 48
[    0.116202] rcu: -> [0] Done. A seq number: 52
