Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEBC433EF
	for <rcu@archiver.kernel.org>; Fri, 17 Jun 2022 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379216AbiFQANh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbiFQANa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jun 2022 20:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70217072;
        Thu, 16 Jun 2022 17:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57EA0617E6;
        Fri, 17 Jun 2022 00:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB541C34114;
        Fri, 17 Jun 2022 00:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424808;
        bh=ohoeaegv47M6RhH5VlNTnW8YSbZgwvL4ZLTZUOUAo9o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NfioYQ1AbMpVHDuXd0SFWNESVVc4D2K1ImEXmMW2c9p6hzA1qOdeaKtSc0BNrqjE6
         v4tE7H8mu2GJ53ImDmHWoiLkKVWNRLRtbklsjaGu1ScJNOHtX8o2cxrROvIw56Wc1C
         hmjTuPZQGgCHOHLbey6dAOR70HypmppdGeYDbI190UMAvV0NdIz0bd2//Wxh7kKPqA
         +IX86U9i3DOuJTjGCJL8xbnlV8b3oJwFCN7u+MMLCBTmwVv+0AIx29mpc6WOpxf2CG
         4BK+Bk2VB6p9csTNkS5GDqAQs4IDQfe65OiB690LOO4K0/ZBvU+GTeBUq1GY2NnG5D
         JjRuCaxEwAlCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A4EF5C1363; Thu, 16 Jun 2022 17:13:28 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:13:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock_strict() strict QS reporting
Message-ID: <20220617001328.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220616135347.1351441-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616135347.1351441-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 16, 2022 at 09:53:47PM +0800, Zqiang wrote:
> When running a kerenl with CONFIG_PREEMPT=n and
> CONFIG_RCU_STRICT_GRACE_PERIOD=y, the QS state will be reported
> directly after exiting the last level of RCU critical section and
> in non irqs-disable context, but maybe the CPU's rcu_data
> structure's ->cpu_no_qs.b.norm is not cleared, as a result the
> rcu_report_qs_rdp() will exit early, and not report QS state.
> 
> This commit will clear CPU's rcu_data structure's ->cpu_no_qs.b.norm
> before invoke rcu_report_qs_rdp().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good point, thank you!  Queued for review and testing with the usual
wordsmithing shown below.  As always, please check.

							Thanx, Paul

------------------------------------------------------------------------

commit cb58562318cf1fa7ad7c2c4c8d8e847c7942df66
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Thu Jun 16 21:53:47 2022 +0800

    rcu: Fix rcu_read_unlock_strict() strict QS reporting
    
    Kernels built with CONFIG_PREEMPT=n and CONFIG_RCU_STRICT_GRACE_PERIOD=y
    report the quiescent state directly from the outermost rcu_read_unlock().
    However, the current CPU's rcu_data structure's ->cpu_no_qs.b.norm
    might still be set, in which case rcu_report_qs_rdp() will exit early,
    thus failing to report quiescent state.
    
    This commit therefore causes rcu_read_unlock_strict() to clear
    CPU's rcu_data structure's ->cpu_no_qs.b.norm field before invoking
    rcu_report_qs_rdp().
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b2c01919b92c0..dc78726b993fd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -824,6 +824,7 @@ void rcu_read_unlock_strict(void)
 	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
+	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
