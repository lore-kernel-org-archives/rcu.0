Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23083C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEE5222C4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724642;
	bh=kkWVvzcfYyb6s78K6hN+gaYRTSKBYtihy3ywc/PWw0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyUVi+sZIkRGv2z6tG00r/35wHLC1Dl+gVS/FxsrAvaN9tIWSs3Bp16T/P54vhrnr
	 Il9n+eSFTP0tA90BBBjCi27H9PBeuP7LQNY92Q0Yr//rNZX1QDL+Ohs80Z9mtbwITV
	 k9+4Nr/SRPVDwUabZ1FKq7I4w53mkJv1r84JcvOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBNX5V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBNX5U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:20 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0012072D;
        Fri, 14 Feb 2020 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724640;
        bh=kkWVvzcfYyb6s78K6hN+gaYRTSKBYtihy3ywc/PWw0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWLuvl+84o+an7+qt+WDrebPj8KayftX7SorxGevPy685saazQGtkr3lEsh60Xi9Y
         W9vVX2noUO8yStBcG+v4Gyr5NMyqyS6pabjj57WlALznGSZZpmlffESBiJ8IJ/t6iJ
         g9bnZc/jgLLoO/CmqfnyiWR3HA0g0hNTzq3Mh77E=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/30] rcu: Add WRITE_ONCE() to rcu_state ->gp_start
Date:   Fri, 14 Feb 2020 15:55:56 -0800
Message-Id: <20200214235607.13749-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's ->gp_start field is read locklessly, so this
commit adds the WRITE_ONCE() to an update in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 3275f27..56df88e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -102,7 +102,7 @@ static void record_gp_stall_check_time(void)
 	unsigned long j = jiffies;
 	unsigned long j1;
 
-	rcu_state.gp_start = j;
+	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
 	/* Record ->gp_start before ->jiffies_stall. */
 	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
-- 
2.9.5

