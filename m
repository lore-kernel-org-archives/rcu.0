Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B4EC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818E820702
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAFRRx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbhAFRRw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63C0B2312C;
        Wed,  6 Jan 2021 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953432;
        bh=Wd5SuBgyYJ7osFk47m6/sHwsn+9VJSlGE+rI2pD29n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyGE2KBhCVrNduS9fEBWQ/O5/hPbQqWWFXtfTNtEqYOl59mnSYJUwyuVQbg6AjMqF
         4WoK7mhF2QX/kZAY5UZh2QeUKBTyk9Bis4cWcGKnj/STzZBqF2/+f3q+HgULcmftiG
         xVGS7ULpigjRAsB+cjeCPiEzrXdjAUA7TA3lQd1tImCQRBuKdzJNdSozqSEbEtJYmR
         6jGRFAjqyNsJiTL7jY1MclHN+nBaz3uT8ZupcPRs6PUQUWIcxbUIZtUOfha8YhHeO+
         1F5+WKx/WPQharszquUGnYwoBFziEpVDyjrxk8aOkYjW0nNyyACiINBKpLClbqDiWz
         sV2vsfLm758Og==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/17] scftorture: Add debug output for wrong-CPU warning
Date:   Wed,  6 Jan 2021 09:16:55 -0800
Message-Id: <20210106171710.22239-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the desired CPU, the actual CPU, and nr_cpu_ids to
the wrong-CPU warning in scftorture_invoker(), the better to help with
debugging.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index d55a9f8..2377cbb 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -398,6 +398,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 static int scftorture_invoker(void *arg)
 {
 	int cpu;
+	int curcpu;
 	DEFINE_TORTURE_RANDOM(rand);
 	struct scf_statistics *scfp = (struct scf_statistics *)arg;
 	bool was_offline = false;
@@ -412,7 +413,10 @@ static int scftorture_invoker(void *arg)
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, smp_processor_id());
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(smp_processor_id() != scfp->cpu);
+	curcpu = smp_processor_id();
+	WARN_ONCE(curcpu != scfp->cpu % nr_cpu_ids,
+		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
+		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
 
 	if (!atomic_dec_return(&n_started))
 		while (atomic_read_acquire(&n_started)) {
-- 
2.9.5

