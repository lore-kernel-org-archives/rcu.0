Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0EC4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35DA60551
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhG0QiS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:38:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhG0QiR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 12:38:17 -0400
Date:   Tue, 27 Jul 2021 18:38:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627403896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SG88rUf9soQTrs5WjqlEm5nKzzHtL93mYvnEYLgPbPM=;
        b=SvadL9rrsU4d0FD6tesiKilL1jagu2i8BPilrchs1IESrt4MxLumDmysELDUcSoPzyCVAA
        KCxARr/UXIUJpi+jZ37NtLSW42Dz5tqEYDCu/2xytFmvvuJnrO10VwXRRFfLh2EjcSaMZ1
        o/LK/NRMhznfNv8jnMfzoTVekDh7fFfQS4QGmWiEXGbfH9AKdNUGlZkfz2HWZOzH9otVyC
        y/eytArBVJmxBhSm6rP2NRLDIkT7QMO3r9nrz6fzLjL2gFfJIwGmdfQM02313BLLcafaFu
        0YqmWHkEO2KOiK+5qMJWt5QxoGuGiQx49ibJqRPHSNjUKYwHrXYZHRePwhRMWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627403896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SG88rUf9soQTrs5WjqlEm5nKzzHtL93mYvnEYLgPbPM=;
        b=nCMgvKJAecW2qCZNPWd6+OjSxiJ3WENfrI0y7CvPMoFddQBdihwkHtkGWxhKYSxLLzWZWM
        SE+MAmPzvIgms0CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] rcu/nocb: Extend checks for offloaded rdp by migrate_disable
Message-ID: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Commit 3820b513a2e33 ("rcu/nocb: Detect unsafe checks for offloaded
rdp") added checks for safe rdp usage in the nocb case.

On PREEMPT_RT this checks triggers in the
 rcu_cpu_kthread() -> rcu_core() -> rcu_check_quiescent_state() ->
  rcu_rdp_is_offloaded()

call chain. On !PREEMPT_RT this warnings is suppressed because rcu_core()
is invoked with disabled BH which also disables preemption and
"preemptible()" is part of the checks which are considered safe.
On PREEMPT_RT disabling BH does not disable preemption and since there
is no other criteria the warning triggers.

According to the mentioned commit the goal is to check if the rcu data
pointer is "stable =E2=80=A6 and prevent from its value to be changed under=
 us".
My understanding is that this may happen if the task is preemptible and
therefore free to be migrated to another CPU which would then lead to
another value of `rcu_data'.
One thing that has been overseen is that a task within a migrate-disable
region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
not be migrated to another CPU which should be enough to guarantee that
rdp remains stable.

Check also disabled migration of the task if the RCU data pointer is
=66rom current CPU. Put the whole check within an SMP ifdef block since
without SMP there are not CPU migrations to worry about (also
task_struct::migration_disabled is missing).

Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I don't fully understand why the CPU-hotplug lock matters here but this
is beside the point ;)

 kernel/rcu/tree_plugin.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0ff5e4fb933e7..d8a623ba7d243 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -57,16 +57,18 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 	 * timers have their own means of synchronization against the
 	 * offloaded state updaters.
 	 */
+#ifdef CONFIG_SMP
 	RCU_LOCKDEP_WARN(
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
 		  (rdp =3D=3D this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) ||
+		    current->migration_disabled)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
-
+#endif
 	return rcu_segcblist_is_offloaded(&rdp->cblist);
 }
=20
--=20
2.32.0

