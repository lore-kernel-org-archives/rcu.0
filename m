Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5617C433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E172083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897363;
	bh=4XdryG1RiS9pScSJTZHEAUnlZQ1xRBaxkunLznXSh3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUtLTdHPTDEC5C4qa0qGx6EVMA0ERw8r67jNmCH7trKmqzQVLutOVrNeGrAsIVcNx
	 dRGY9NpPExyTMxkQhN/m6G9dEoYOWwkaM+f/FStOX5OiVYk4sFb5tE3RgTFaScP9Pl
	 U1XeL8wrCHsRVv72c7Fnw1GJObR7yS+L+2fAU63Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHaSJX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgHaSHy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF3421582;
        Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897273;
        bh=4XdryG1RiS9pScSJTZHEAUnlZQ1xRBaxkunLznXSh3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJaMfqeU/GjtBbGqlL6h5tZeBfk4frMJyYuK35tMvGizmlN6qs+aiF6wKSefTtf07
         YchP8MbeLxv3mnXudWEveZ27BBPjFK+RtuU2z7Vvl5iSGYf2fFYCXsMEUT3yq+J+yz
         YOCmd7q3QPBAUrVih5Jd3j+RZn57mtiMjY6f03Hg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/19] scftorture: Add smp_call_function_single() memory-ordering checks
Date:   Mon, 31 Aug 2020 11:07:37 -0700
Message-Id: <20200831180749.843-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds checks for memory misordering across calls to
smp_call_function_single() and also across returns in the case where
the caller waits.  Misordering results in a splat.

[ paulmck: s/GFP_KERNEL/GFP_ATOMIC/ per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 09a6242..9b42271 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -117,9 +117,20 @@ static struct scf_selector scf_sel_array[SCF_NPRIMS];
 static int scf_sel_array_len;
 static unsigned long scf_sel_totweight;
 
+// Communicate between caller and handler.
+struct scf_check {
+	bool scfc_in;
+	bool scfc_out;
+	int scfc_cpu; // -1 for not _single().
+	bool scfc_wait;
+};
+
 // Use to wait for all threads to start.
 static atomic_t n_started;
 static atomic_t n_errs;
+static atomic_t n_mb_in_errs;
+static atomic_t n_mb_out_errs;
+static atomic_t n_alloc_errs;
 static bool scfdone;
 
 DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
@@ -222,24 +233,27 @@ static struct scf_selector *scf_sel_rand(struct torture_random_state *trsp)
 // Update statistics and occasionally burn up mass quantities of CPU time,
 // if told to do so via scftorture.longwait.  Otherwise, occasionally burn
 // a little bit.
-static void scf_handler(void *unused)
+static void scf_handler(void *scfc_in)
 {
 	int i;
 	int j;
 	unsigned long r = torture_random(this_cpu_ptr(&scf_torture_rand));
+	struct scf_check *scfcp = scfc_in;
 
+	if (likely(scfcp) && WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
+		atomic_inc(&n_mb_in_errs);
 	this_cpu_inc(scf_invoked_count);
 	if (longwait <= 0) {
 		if (!(r & 0xffc0))
 			udelay(r & 0x3f);
-		return;
+		goto out;
 	}
 	if (r & 0xfff)
-		return;
+		goto out;
 	r = (r >> 12);
 	if (longwait <= 0) {
 		udelay((r & 0xff) + 1);
-		return;
+		goto out;
 	}
 	r = r % longwait + 1;
 	for (i = 0; i < r; i++) {
@@ -248,14 +262,24 @@ static void scf_handler(void *unused)
 			cpu_relax();
 		}
 	}
+out:
+	if (unlikely(!scfcp))
+		return;
+	if (scfcp->scfc_wait)
+		WRITE_ONCE(scfcp->scfc_out, true);
+	else
+		kfree(scfcp);
 }
 
 // As above, but check for correct CPU.
-static void scf_handler_1(void *me)
+static void scf_handler_1(void *scfc_in)
 {
-	if (WARN_ON_ONCE(smp_processor_id() != (uintptr_t)me))
+	struct scf_check *scfcp = scfc_in;
+
+	if (likely(scfcp) && WARN_ONCE(smp_processor_id() != scfcp->scfc_cpu, "%s: Wanted CPU %d got CPU %d\n", __func__, scfcp->scfc_cpu, smp_processor_id())) {
 		atomic_inc(&n_errs);
-	scf_handler(NULL);
+	}
+	scf_handler(scfcp);
 }
 
 // Randomly do an smp_call_function*() invocation.
@@ -263,6 +287,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 {
 	uintptr_t cpu;
 	int ret;
+	struct scf_check *scfcp = NULL;
 	struct scf_selector *scfsp = scf_sel_rand(trsp);
 
 	if (use_cpus_read_lock)
@@ -271,17 +296,32 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	switch (scfsp->scfs_prim) {
 	case SCF_PRIM_SINGLE:
+		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
+		if (WARN_ON_ONCE(!scfcp))
+			atomic_inc(&n_alloc_errs);
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
 			scfp->n_single_wait++;
 		else
 			scfp->n_single++;
-		ret = smp_call_function_single(cpu, scf_handler_1, (void *)cpu, scfsp->scfs_wait);
+		if (scfcp) {
+			scfcp->scfc_cpu = cpu;
+			scfcp->scfc_wait = scfsp->scfs_wait;
+			scfcp->scfc_out = false;
+			scfcp->scfc_in = true;
+		}
+		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
 		if (ret) {
 			if (scfsp->scfs_wait)
 				scfp->n_single_wait_ofl++;
 			else
 				scfp->n_single_ofl++;
+			kfree(scfcp);
+		} else if (scfcp && scfsp->scfs_wait) {
+			if (WARN_ON_ONCE(!scfcp->scfc_out))
+				atomic_inc(&n_mb_out_errs); // Leak rather than trash!
+			else
+				kfree(scfcp);
 		}
 		break;
 	case SCF_PRIM_MANY:
-- 
2.9.5

