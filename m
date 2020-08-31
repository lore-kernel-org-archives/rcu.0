Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C90C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE662083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897336;
	bh=jjAdQOb2DvCbOXuoKkbDDkv1j8pMSjYUmKzNcvABNNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EwXQ8MVFdpwA7itL0F8WppLiAfQ2QchLhfp2hJJnwjbsr3kneph7J+HeBnwrjmZiA
	 tNmyo/GBe4U/xjfVGAg0V0DRucKukJG+9cgiuwL4tOnw0PY3lK/32uM/slzCP0ADgr
	 Tsihw+0VQOMjDTPODE3/0+VVcVMNabjNCTo/EfOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgHaSIL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgHaSH6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238CE2166E;
        Mon, 31 Aug 2020 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897275;
        bh=jjAdQOb2DvCbOXuoKkbDDkv1j8pMSjYUmKzNcvABNNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjndsHj/sKgkuG7EeozZvpX8oR2zp6sxUvQ8UhjPBXK5y7/+9D2WPiWe52UXyzDV9
         b9d9Qfue28tERO3x/9jSAUTPXSBfNJ8u37bl/QrcTZQ4Oead8o/EA3jmyBwfNye8RB
         +z6lY3KYt01R+9z489VfmaSFN6ogTbAMflrPa7co=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/19] scftorture: Block scftorture_invoker() kthreads for offline CPUs
Date:   Mon, 31 Aug 2020 11:07:46 -0700
Message-Id: <20200831180749.843-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, CPU-hotplug operations might result in all but two
of (say) 100 CPUs being offline, which in turn might result in
false-positive diagnostics due to overload.  This commit therefore
causes scftorture_invoker() kthreads for offline CPUs to loop blocking
for 200 milliseconds at a time, thus continuously adjusting the number
of threads to match the number of online CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index d9c01c7..04d3a42 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -381,11 +381,14 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 // smp_call_function() family of functions.
 static int scftorture_invoker(void *arg)
 {
+	int cpu;
 	DEFINE_TORTURE_RANDOM(rand);
 	struct scf_statistics *scfp = (struct scf_statistics *)arg;
+	bool was_offline = false;
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
-	set_cpus_allowed_ptr(current, cpumask_of(scfp->cpu % nr_cpu_ids));
+	cpu = scfp->cpu % nr_cpu_ids;
+	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 	set_user_nice(current, MAX_NICE);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
@@ -408,6 +411,14 @@ static int scftorture_invoker(void *arg)
 
 	do {
 		scftorture_invoke_one(scfp, &rand);
+		while (cpu_is_offline(cpu) && !torture_must_stop()) {
+			schedule_timeout_interruptible(HZ / 5);
+			was_offline = true;
+		}
+		if (was_offline) {
+			set_cpus_allowed_ptr(current, cpumask_of(cpu));
+			was_offline = false;
+		}
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
-- 
2.9.5

