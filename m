Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9360C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B041E2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897487;
	bh=oNI0rVyhAa3e3M0tZqUyhGaWitcL9S6WNg3KZaOXpts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kPiUeZnJX6I1KZsZDJMuUccK+ikSBx7K3GVaImwyi933DV5VOqRxldd6ZR3BxSFiI
	 e+unvZlsLZ5aQ1zwVlGAIGGIPkDXgPf03Gnc7yM3DAC9i0tdhc9xSv1+Cjtm01ijEe
	 6a2asE0SHRrSqVH4qtzJf1jL/dP+Iyp8lF2aOWo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgHaSL0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgHaSLW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6859A21473;
        Mon, 31 Aug 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897482;
        bh=oNI0rVyhAa3e3M0tZqUyhGaWitcL9S6WNg3KZaOXpts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlPYFOgAhxbA2tlWpScktn/PuyVp1TuYbusp0YeZIqMqVpXrm2B7tybWOIOPZjl5L
         mKhE9wl9SF6+evZDd2MPhQWQasM6obWUpnWnla45gBY2Am2tvdJNWNbHIHgH3T/yjR
         sA4TLKqV3MVzlELUKyq4JruziFAzLKYhD8+62Z/0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/13] rcu: Restrict default jiffies_till_first_fqs for strict RCU GPs
Date:   Mon, 31 Aug 2020 11:11:10 -0700
Message-Id: <20200831181120.1044-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
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
index 8ce77d9..8551159 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -485,7 +485,7 @@ module_param(qhimark, long, 0444);
 module_param(qlowmark, long, 0444);
 module_param(qovld, long, 0444);
 
-static ulong jiffies_till_first_fqs = ULONG_MAX;
+static ulong jiffies_till_first_fqs = IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 0 : ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 static int rcu_divisor = 7;
-- 
2.9.5

