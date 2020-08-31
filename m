Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB5FC43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3252083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897359;
	bh=LmVslC1dU5CCoRMoEl6kiVj9HhpjeVhgru+RnSIzBRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+2bxXlnGG13JDzxUmKFcXL8B90d4NHUY9DjhSyYE4Sxauqqcm5QbCjmFjUW8glis
	 DBVxZHC3LhbZCW67TnqBis7nTqBCLDi7MDpCFmQBKEwDDXoi2dL2foUNo5JHo8RiJr
	 zfrW2MTMTdYlGP9pA/xxsY6bOTZEmpk173qWgB3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgHaSJT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgHaSHz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533D521527;
        Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897273;
        bh=LmVslC1dU5CCoRMoEl6kiVj9HhpjeVhgru+RnSIzBRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzk+nlOXerMYMhcMLhxutunfy2aKWT/opTfzRgMWDAE2A1JliF6SsFhTasaoajT8f
         XkQWO56jABFEFb0JTlNPRzOgIYGeZBmqOm3xHal4whXgQchEaM6YhVRKCFlOmxpJJn
         9B7c55XjOKNBQYRSNQFOwc9XpNCcxwxEEnrT5+sU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/19] scftorture: Add smp_call_function_many() memory-ordering checks
Date:   Mon, 31 Aug 2020 11:07:38 -0700
Message-Id: <20200831180749.843-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds checks for memory misordering across calls to and
returns from smp_call_function_many() in the case where the caller waits.
Misordering results in a splat.

Note that in contrast to smp_call_function_single(), this code does not
test memory ordering into the handler in the no-wait case because none
of the handlers would be able to free the scf_check structure without
introducing heavy synchronization to work out which was last.

[ paulmck: s/GFP_KERNEL/GFP_ATOMIC/ per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 9b42271..3519ad1 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -240,8 +240,11 @@ static void scf_handler(void *scfc_in)
 	unsigned long r = torture_random(this_cpu_ptr(&scf_torture_rand));
 	struct scf_check *scfcp = scfc_in;
 
-	if (likely(scfcp) && WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
-		atomic_inc(&n_mb_in_errs);
+	if (likely(scfcp)) {
+		WRITE_ONCE(scfcp->scfc_out, false); // For multiple receivers.
+		if (WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
+			atomic_inc(&n_mb_in_errs);
+	}
 	this_cpu_inc(scf_invoked_count);
 	if (longwait <= 0) {
 		if (!(r & 0xffc0))
@@ -325,11 +328,28 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 		break;
 	case SCF_PRIM_MANY:
+		if (scfsp->scfs_wait) {
+			scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
+			if (WARN_ON_ONCE(!scfcp))
+				atomic_inc(&n_alloc_errs);
+		}
 		if (scfsp->scfs_wait)
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		smp_call_function_many(cpu_online_mask, scf_handler, NULL, scfsp->scfs_wait);
+		if (scfcp) {
+			scfcp->scfc_cpu = -1;
+			scfcp->scfc_wait = true;
+			scfcp->scfc_out = false;
+			scfcp->scfc_in = true;
+		}
+		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
+		if (scfcp) {
+			if (WARN_ON_ONCE(!scfcp->scfc_out))
+				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
+			else
+				kfree(scfcp);
+		}
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
-- 
2.9.5

