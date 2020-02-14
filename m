Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C451C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE0B2072D
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724656;
	bh=AATjJkj/K9gZ+OR1b+FVcOdq8fxYASQmbpJhi2mOvJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R42h05ngC/9D5XE0x3ZnrjsvSotGSOYPCP31TqurE4Pqpc5KmtX2jQzSZBBEBN/dg
	 s/duf5SoYsG4a6N1xLgq+dXEK+KC+ow4sF/yNADgxlKkxGWpDMCxbqyA5p0EPJaygZ
	 PEhaQhlmEQEHTpYe0mAD9mu9z9+iw5I7bnj8N62U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgBNX5f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBNX5f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:35 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7C624673;
        Fri, 14 Feb 2020 23:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724654;
        bh=AATjJkj/K9gZ+OR1b+FVcOdq8fxYASQmbpJhi2mOvJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ9p30zlHb8oVLxX0q+R4Cfyqd9OPyIQfS/rvam/LyzZVesogAAd9xnSqweqGpnzp
         x2yP4qO9svgjco/HOqtyTMAwjCGZMljUUiiX6hUu5dwii150pbMnbK3esV1HmErkky
         sAXSFEWWcDvSkitqgILSgjfFPzhN4WneZEUEmU8Y=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/30] rcu: Add missing annotation for rcu_nocb_bypass_lock()
Date:   Fri, 14 Feb 2020 15:56:00 -0800
Message-Id: <20200214235607.13749-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports warning at rcu_nocb_bypass_lock()

|warning: context imbalance in rcu_nocb_bypass_lock() - wrong count at exit

To fix this, this commit adds an __acquires(&rdp->nocb_bypass_lock).
Given that rcu_nocb_bypass_lock() does actually call raw_spin_lock()
when raw_spin_trylock() fails, this not only fixes the warning but also
improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0f8b714..6db2cad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1486,6 +1486,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
  * flag the contention.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
+	__acquires(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
-- 
2.9.5

