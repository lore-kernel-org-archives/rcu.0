Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D062C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA412072D
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724604;
	bh=HwUNCGUdfre5UmNq9Q+iEz2ZVX6Edk3KkkIAZWEfhV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NB1+OoU+Ka/koqyTWdAJz+eBqIuZ3kHSf9LNYT6P2SNBl0FB5EDKqhMJlaYQfi3r8
	 S9r6jcQAy5rlQkMOiH8ITmNL738IG73Gkbsx8ERxAhf+8K9almRZUex9Da2cYQkkd2
	 sRgePQZ4j4MKNt2nfcYi2VMjkHuYp6TsPQVV+pKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBNX4o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX4n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:43 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABFA2467D;
        Fri, 14 Feb 2020 23:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724603;
        bh=HwUNCGUdfre5UmNq9Q+iEz2ZVX6Edk3KkkIAZWEfhV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCcJzu++A/qHESXdUUEcN90k9g7/Ms3GSjJUKfmW535E9iUj2LTPUlG/5Q8ANcVye
         Yk+MkuEl8hZMNZeZdcSZCC6dXGN94jFb4jVrCbPhchZPohJxOXRpX8Byq/+4TgamjC
         FNXPdKT7qxwOqJblpm6hk41EfLEsUGbKfd3t/3MU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/30] rcu: Add WRITE_ONCE() to rcu_node ->qsmaskinitnext
Date:   Fri, 14 Feb 2020 15:55:46 -0800
Message-Id: <20200214235607.13749-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's ->qsmaskinitnext field is read locklessly,
so this commit adds the WRITE_ONCE() to an update in order to provide
proper documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely for systems not doing incessant CPU-hotplug
operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9443909..346321a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3379,7 +3379,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	rnp->qsmaskinitnext |= mask;
+	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
 	oldmask = rnp->expmaskinitnext;
 	rnp->expmaskinitnext |= mask;
 	oldmask ^= rnp->expmaskinitnext;
@@ -3432,7 +3432,7 @@ void rcu_report_dead(unsigned int cpu)
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
-	rnp->qsmaskinitnext &= ~mask;
+	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	raw_spin_unlock(&rcu_state.ofl_lock);
 
-- 
2.9.5

