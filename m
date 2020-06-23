Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FBC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A71E20702
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871792;
	bh=f4PXroet3kk9dCV8EekSuydwLuif35P7Fjo5XqU/DcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JmWSfV4OPmuMW5EVoxwgMQWT3h7W0S6DnN50GlUTYrFHLjpcVdCxeFi3pIGypZe3+
	 yucGsUoyI948Lz4jqtu60n7x5Q+rpRcUH690xP4Kn/gyWgt6dxttLSBUQpK6Jo3cHQ
	 gNS3Z2Rd0EDqlkQLQdfev9U1uYC6+ba5+5UDqFpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgFWAXL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgFWAVv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753AD2083B;
        Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871710;
        bh=f4PXroet3kk9dCV8EekSuydwLuif35P7Fjo5XqU/DcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXbe1t1pgutHiniEPFQnC68ybenwwIK7wkHrIgWdUU2Vj8WCmfLzEUsn2dgFJgPKm
         75bcFCBqssuKSbe78GDMuQja6ir4v6+MO4yK69hEouYIAt82JPC878b+ZlNqdVWZ1b
         3DR1rl4Dsd2NYxf0r+L4mGn7kuLNC4GkenEEH8ig=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/26] trace: events: rcu: Change description of rcu_dyntick trace event
Date:   Mon, 22 Jun 2020 17:21:27 -0700
Message-Id: <20200623002147.25750-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The different strings used for describing the polarity are
Start, End and StillNonIdle. Since StillIdle is not used in any trace
point for rcu_dyntick, it can be removed and StillNonIdle can be added
in the description. Because StillNonIdle is used in a few tracepoints for
rcu_dyntick.

Similarly, USER, IDLE and IRQ are used for describing context in
the rcu_dyntick tracepoints. Since, "KERNEL" is not used for any
of the rcu_dyntick tracepoints, remove it from the description.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811..af274d1 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -435,11 +435,12 @@ TRACE_EVENT_RCU(rcu_fqs,
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
- * Tracepoint for dyntick-idle entry/exit events.  These take a string
- * as argument: "Start" for entering dyntick-idle mode, "Startirq" for
- * entering it from irq/NMI, "End" for leaving it, "Endirq" for leaving it
- * to irq/NMI, "--=" for events moving towards idle, and "++=" for events
- * moving away from idle.
+ * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
+ * as argument:
+ * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
+ *            being in dyntick-idle mode.
+ * context: "USER" or "IDLE" or "IRQ".
+ * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
-- 
2.9.5

