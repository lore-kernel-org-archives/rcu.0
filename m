Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD12C63798
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28296127C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbhGUTkz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236645AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08B661353;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=QUqMqT880NTnSp4mKtTyqHOCDRWBO5LbjpDhT+NOKN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5nAYhXVaf1nG9NC1Fd/CoKUkFS0v6Qc8tH6fy3MJtu/2UIM7IMrBLVozP3zoKHrq
         nlx4G+KdlD7sQFFCHIiUp1vSeekJSp16g0o7vjz9xG33ynRPRHusEyxOzoFy4TFT1x
         Eo/IEs2U4pA6d3B69TYTGIUTmgLKWBbSSy3h9VI80vXhY/G4ukUzc6Zzd27PVhBdbs
         t3PDZkml3zJsCzINuxo6IYo/V9DOxjXG+sezpE4wUjjcWWAxicU1JD+rXwvfS4A+jg
         kor7rE2hxPNUPXBR+BuJK7gvAwmo7ljgJ3XBNjKo5cT7J7AgSeVHP9u9F4pzfLlRNe
         HlCOjionKi85g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23B0A5C0DBB; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/18] rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()
Date:   Wed, 21 Jul 2021 13:21:16 -0700
Message-Id: <20210721202127.2129660-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

rcu_cpu_stall_reset() is one of the functions virtual CPUs
execute during VM resume in order to handle jiffies skew
that can trigger false positive stall warnings. Paul has
pointed out that this approach is problematic because
rcu_cpu_stall_reset() disables RCU grace period stall-detection
virtually forever, while in fact it can just restart the
stall-detection timeout.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0e7a60706d1c0..e199022dce9dc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -119,17 +119,14 @@ static void panic_on_rcu_stall(void)
 }
 
 /**
- * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
- *
- * Set the stall-warning timeout way off into the future, thus preventing
- * any RCU CPU stall-warning messages from appearing in the current set of
- * RCU grace periods.
+ * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
+	WRITE_ONCE(rcu_state.jiffies_stall,
+		   jiffies + rcu_jiffies_till_stall_check());
 }
 
 //////////////////////////////////////////////////////////////////////////////
-- 
2.31.1.189.g2e36527f23

