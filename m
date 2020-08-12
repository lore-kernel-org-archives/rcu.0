Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C5C433E0
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F267A22BF5
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273093;
	bh=zy2r+61uBN1pJktsl9IlZc4fSFAY3znZwPcoLkq3Cks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfzFwRGxDDcQ4f9GNIECIt6E1IDJ4N+7yJze8tCPPFUwuvGh05ZK9WoGTHf7NNfr5
	 78NGIPoRoNT1JsYoFyoSWKQBo0+NAoCcVRx5F0aheg7hZJ9fZk/e+Y/GT6u129DIa3
	 IcPXPRXBomqdCtvoxRTKk64v42XP2bu28skkumOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHLW5f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgHLW5f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:35 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CC620B1F;
        Wed, 12 Aug 2020 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273055;
        bh=zy2r+61uBN1pJktsl9IlZc4fSFAY3znZwPcoLkq3Cks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxGaqD4DmxDokpJs2n5WPT9IROUgwWeJHCnNjedqnlRtj3b+uj2O622ohACXLb2Gj
         S5W8zyuysfCLCA/bitzzDv3fIHDUrIPV/8WCbgPRChou2apmlxbe3FsXWd181euH1h
         hGVp85bIted2Ei+MPnJndWvanlyb7kLRbbmDepGI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/12] rcu: Restrict default jiffies_till_first_fqs for strict RCU GPs
Date:   Wed, 12 Aug 2020 15:57:23 -0700
Message-Id: <20200812225732.20068-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If there are idle CPUs, RCU's grace-period kthread will wait several
jiffies before even thinking about polling them.  This promotes
efficiency, which is normally a good thing, but when the kernel
has been built with CONFIG_RCU_STRICT_GRACE_PERIOD=y, we care more
about short grace periods.  This commit therefore restricts the
default jiffies_till_first_fqs value to zero in kernels built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, which causes RCU's grace-period kthread
to poll for idle CPUs immediately after starting a grace period.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 65e1b5e..d333f1b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -471,7 +471,7 @@ module_param(qhimark, long, 0444);
 module_param(qlowmark, long, 0444);
 module_param(qovld, long, 0444);
 
-static ulong jiffies_till_first_fqs = ULONG_MAX;
+static ulong jiffies_till_first_fqs = IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 0 : ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 static int rcu_divisor = 7;
-- 
2.9.5

