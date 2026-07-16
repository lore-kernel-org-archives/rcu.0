Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936952D8399;
	Thu, 16 Jul 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161528; cv=none; b=PAOrcxmOwHZOYUFgk4x4j6ZJODQOAMrU+BSktFgWiO+vTBVyJP6v2KlXqvh7eV0/JibTABTAh4pK/b+jQQGeDpaObpprmRKxE63xLZfg1mJOYIEZUbtEJVS11DrJhbtladUVNMPnPtWGq6pWVgj0F0PhUve/mFnlOl89UXU623c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161528; c=relaxed/simple;
	bh=aCTJ8iBFcRGQD3b/DWJ3keWmzQPZGG0Mc5oLdXyY4Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qoLp1jxqPj4OzMYV2cGbAN42iACWlNkGLuYS66/gHhciqc1dBaozOny2mhM7ewq0tvVeW8pLigE8jeQZhyPVtc9LCjBKKDaoUj+EnZxFn68jHNK60Q88ELULpGqrt82LVMHBiOo6FTVMxhxQlVbRdmXMnm+zlcdfM9FOJ3cV1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMPoebig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMPoebig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82B31F00ADF;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=JH5EDmWuDn+RBKTBXQ04GfMfNJ2NrkdwVZ5DmZSS+bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMPoebigerv2Zcx/myqvuYOEjRT2Gps3NRjuDrzZGkIZ4A5C52DMZia2FuZHmgjBY
	 rFMPZhv6eA389QZeXitzuAinCau+H9FQP73qzkZP+sa8/hBGWA7AJQbgH6qDNt30em
	 BrIgUo4w9TzJ3SquKG+tnZDHiIG8I0S88hLYIIopmUYEGlXrGpcodXzVcRCp9Grg4d
	 vKGTLAQktrHEFkFevfSAr9hnAf0zjRosfj1kP1UtemAq9i6il2gFi2i5HeXV75FZKX
	 VORf/QHlG9FdIpFyFINbo3w8C/nsvsq1ogINUCAqgbRNpQvsK7Z70hpk3K1VXis4TZ
	 QkGynk7Oa0B0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F049CE0E0B; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 07/11] rcutorture: Add nwriters module parameter
Date: Wed, 15 Jul 2026 17:25:16 -0700
Message-Id: <20260716002520.11895-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Believe it or not, there are people who would like to run rcutorture
without actually torturing RCU.  For example, some people would like to
induce various types of stall warnings without placing any unnecessary
additional overhead on their systems running in production.  And
rcutorture provides the stall_cpu, stall_cpu_holdoff, stall_no_softlockup,
stall_cpu_irqsoff, stall_cpu_block, and stall_cpu_repeat module parameters
in order to allow the user to force numerous types of stalls.  In addition,
rcutorture provides a great number of other module parameters to allow the
user to reduce other overhead.

But unfortunately, there is no way to turn of the rcu_torture_writer()
portion of this torture test, which on my x86 laptop consumes somewhere
between 40% and 45% of a CPU.  Although this is quite lightweight for a
torture test, it is not welcome on systems running production workloads.
This commit therefore adds an nwriters module parameter that defaults
to 1 but can be set to 0 in order to disable the rcu_torture_writer()
portion of the torture test, but that cannot be set to any other value
(that is what the fakewriters module parameter is for!).  This reduces
the overhead to well under 1% of a CPU, which is much more likely to be
compatible with production workloads.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Puranjay Mohan <puranjay@kernel.org>
Reported-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/rcutorture.c                         | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f2281..b942149720c9bf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6117,6 +6117,11 @@ Kernel parameters
 			the number of CPUs.  For example, -2 selects N
 			(the number of CPUs), -3 selects N+1, and so on.
 
+	rcutorture.nwriters= [KNL]
+			Set number of RCU writers, which must be either
+			zero or one.  For additional writers, use instead
+			the rcutorture.nfakewriters parameter.
+
 	rcutorture.object_debug= [KNL]
 			Enable debug-object double-call_rcu() testing.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 05ef7bb65f710e..a6a8b9ba342d02 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -116,6 +116,7 @@ torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testin
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
+torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
@@ -3163,7 +3164,7 @@ static void
 rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s: nreaders=%d nfakewriters=%d "
+		 "--- %s: nreaders=%d nwriters=%d nfakewriters=%d "
 		 "stat_interval=%d verbose=%d test_no_idle_hz=%d "
 		 "shuffle_interval=%d stutter=%d irqreader=%d "
 		 "fqs_duration=%d fqs_holdoff=%d fqs_stutter=%d "
@@ -3178,7 +3179,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
-		 torture_type, tag, nrealreaders, nrealfakewriters,
+		 torture_type, tag, nrealreaders, nwriters, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -4754,10 +4755,11 @@ rcu_torture_init(void)
 			goto unwind;
 	}
 
-	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
-					  writer_task);
-	if (torture_init_error(firsterr))
-		goto unwind;
+	if (nwriters) {
+		firsterr = torture_create_kthread(rcu_torture_writer, NULL, writer_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	firsterr = rcu_torture_updown_init();
 	if (torture_init_error(firsterr))
-- 
2.40.1

