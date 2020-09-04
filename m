Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC64BC52D62
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B7C20678
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599242729;
	bh=Ag1A+X+Az5QSLdpFFohLqvlwDSmyTZHVcII5luMVwUw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tth4B4GGynL4SZYV0dc22jUxZr9nCBXsRTlf84lAVlbeHqWbQ4P0yuTknagZklsXH
	 Odz4sEv2Mcq9JPe99G+QdQ+VpyzRKzbiuyhgKxM6YuUgQwXPMKvr1vbpQqdu/Bthx4
	 Awl7NJGIQpMMdxuLBf5meAfx6nfUqF/RVa4ZpW3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIDSF3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgIDSF2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Sep 2020 14:05:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C083217BA;
        Fri,  4 Sep 2020 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599241811;
        bh=Ag1A+X+Az5QSLdpFFohLqvlwDSmyTZHVcII5luMVwUw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rELap8gXcynnujzMa1ArCQy5i1oLKt+Pgk2mQDiH1C/Jyun9ESs4BlzjsUyssTzP3
         hF/fYmLWCKu4NR718SioPAbtEnn/sgYIhbKsgQP+G5iabZPYepOxPdIEOrrntCahLj
         jGFCjcvukZRL8Ut5pVD8Qw6+4juZuRDjYy46dzvU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 552E935215BE; Fri,  4 Sep 2020 10:50:07 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:50:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     chao <chao@eero.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: allow multiple stalls before panic
Message-ID: <20200904175007.GG29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1598856077-58603-1-git-send-email-chao@eero.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598856077-58603-1-git-send-email-chao@eero.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 30, 2020 at 11:41:17PM -0700, chao wrote:
> Some stalls are transient and system can fully recover.
> Allow users to configure the number of stalls experienced
> to trigger kernel Panic.
> 
> Signed-off-by: chao <chao@eero.com>

Hearing no objections, I have queued this with wordsmithing as shown
below.  Please let me know if I messed something up.

One question, though.  It looks like setting this to (say) 5 would panic
after the fifth RCU CPU stall warning message, regardless whether all
five were reporting the same RCU CPU stall event or whether they instead
were five widely separated transient RCU CPU stall events, where the
system fully recovered from each event.  Is this the intent?

							Thanx, Paul

------------------------------------------------------------------------

commit e710c928fb52d8e56bc6173515805301da6aa22b
Author: chao <chao@eero.com>
Date:   Sun Aug 30 23:41:17 2020 -0700

    rcu: Panic after fixed number of stalls
    
    Some stalls are transient, so that system fully recovers.  This commit
    therefore allows users to configure the number of stalls that must happen
    in order to trigger kernel panic.
    
    Signed-off-by: chao <chao@eero.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def6..fc2dd3f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -536,6 +536,7 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0fde39b..228c55f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -13,6 +13,7 @@
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
@@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	static int cpu_stall;
+
+	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+		return;
+
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f..1bca490 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2651,6 +2651,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#if defined(CONFIG_TREE_RCU)
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 	{
 		.procname	= "stack_erasing",
