Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB92C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278BD2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971994;
	bh=x/pRCLer6rp72HqNGGnkhkYJNBCXT47lhuBfzel1ReA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5OdUKK8/Pb50pmelLOgePIiY1GTrny1xahzBw5OFGMcfu9TkY5izb/vbo0jtN97P
	 Hz6UNva7GKOjzHQbp0/Jjl/xU7/GyZ61JPg+e1uvteGZ6Y2ngu03WLBdmy3lW6VWZJ
	 rYb72FVGWljCUleyw7SmaVt3yxyI7kHUUI+RXgjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411135AbgDORbI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411119AbgDORbE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E2121582;
        Wed, 15 Apr 2020 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971863;
        bh=x/pRCLer6rp72HqNGGnkhkYJNBCXT47lhuBfzel1ReA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRaME366xHhkbOa4vrmnf8LgP30PHZEkKj7TQTE3z4oFc8Zfj3fQbINwQRqRyPF7L
         9208qVZHFcOK/sa6vEq6p9Sb9iZ7nj4wNXCHY7tc1O6vygLKdjcQrkHC4DBVbI3d9w
         74Z59IYkC3L6wl1gv+trddZ8piR5hwo/qYaH1qxM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/18] Default enable RCU list lockdep debugging with PROVE_RCU
Date:   Wed, 15 Apr 2020 10:30:47 -0700
Message-Id: <20200415173100.9927-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch default enables CONFIG_PROVE_RCU_LIST option with
CONFIG_PROVE_RCU for RCU list lockdep debugging.

With this change, RCU list lockdep debugging will be default
enabled in CONFIG_PROVE_RCU=y kernels.

Most of the RCU users (in core kernel/, drivers/, and net/
subsystem) have already been modified to include lockdep
expressions hence RCU list debugging can be enabled by
default.

However, there are still chances of enountering
false-positive lockdep splats because not everything is converted,
in case RCU list primitives are used in non-RCU read-side critical
section but under the protection of a lock. It would be okay to
have a few false-positives, as long as bugs are identified, since this
patch only affects debugging kernels.

Co-developed-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02ee..ec4bb6c 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -9,15 +9,10 @@ config PROVE_RCU
 	def_bool PROVE_LOCKING
 
 config PROVE_RCU_LIST
-	bool "RCU list lockdep debugging"
-	depends on PROVE_RCU && RCU_EXPERT
-	default n
+	def_bool PROVE_RCU
 	help
-	  Enable RCU lockdep checking for list usages. By default it is
-	  turned off since there are several list RCU users that still
-	  need to be converted to pass a lockdep expression. To prevent
-	  false-positive splats, we keep it default disabled but once all
-	  users are converted, we can remove this config option.
+	  Enable RCU lockdep checking for list usages. It is default
+	  enabled with CONFIG_PROVE_RCU.
 
 config TORTURE_TEST
 	tristate
-- 
2.9.5

