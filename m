Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B682DF134;
	Thu, 16 Jul 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161531; cv=none; b=SHQwCsmxv4tenD7gdLuBcFK+v2ZhA0H53YRCbGqVRccMm+vwnBOPDeoCf4JAMXeFJZ6V3bwjDkP9Q+FK1vXuk9YBkMOJwQULr+/wHS4EbyAsWp7azDyuuujWvU/GUVRxom3tohOKtHMcsRbBsW4R3oiK/1RlrCwxcTga+aQ9daE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161531; c=relaxed/simple;
	bh=Jjl3SE2rLdpUtNPn4o7XuSq/LnB/VF011jsxpNIOszA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5FHCV5HXpipt1lKRWD0ik94qs7/mF3McTRN5NQdpPUwk0LA4J4ZOAAAPjpYdCiNObIwHtetFk7sThUZMkyUWA9u9L1G6M0aXa+JWK+QOOB+3bg3g7xrMo5gRLFDSQZYwNJs3w10elIBKIjAWdxkig+l8NgTDP+/OP6qtUmKvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhNqibui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhNqibui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F8A1F01558;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=pdF7AJpaq+Dg2l9UISLXY1kgDLD+XAKQk0wFurP0uhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhNqibuiKEw0UpJmfMltIaiuIYAk14JWMmYsmAMR+1P9vbW2OfHyFLUDHgJ5T50Jo
	 2Gt2MOnAbUU2CWvI4vpOB4An9dslvD8F8Hd15OqeqOEjVRIWb3FosryoEwH6GQVWpV
	 07x8hwLkiEyl9IvgIK/0ZTDCFLhVDGKjncSYiQXi8w5XIxw8tPmEkVfA0hmSwdrLh2
	 6r/cie2ThX5DFsYwmSx7uS8vssll7c+vwgF8zWnqbZvjpDTAJORA1YbDs/8JUFyRw6
	 zBOtpeBEtXvki05nwhD23Db3qGWQ7x3LvHgHWl6VOfm1pJ5/ZuGzax5I1UaZM3YnnJ
	 tGJcNYS1OaJsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81B41CE0E2A; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 08/11] rcutorture: Add a stall_only module parameter
Date: Wed, 15 Jul 2026 17:25:17 -0700
Message-Id: <20260716002520.11895-8-paulmck@kernel.org>
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

This commit adds a stall_only module parameter that shuts off all
rcutorture kthreads other than the RCU CPU stall-warning test kthreads.
The purpose of this is to test production applictions' reactions to
CPU stalls, and with minimal additional overhead.  Or you can omit the
stall-warning tests as well and get a heavy no-op, your choice!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt          |  9 +++++++++
 kernel/rcu/rcutorture.c                        | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b942149720c9bf..40d2831add4a21 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6211,6 +6211,15 @@ Kernel parameters
 			and stall_gp_kthread are specified, the
 			kthread is starved first, then the CPU.
 
+	rcutorture.stall_only= [KNL]
+			Shut off all rcutorture kthreads other than the
+			RCU CPU stall-warning test kthreads.  The purpose
+			of this is to test production applictions'
+			reactions to CPU stalls, and with minimal
+			additional overhead.  Or you can omit the
+			stall-warning tests as well and get a heavy
+			no-op, your choice!
+
 	rcutorture.stat_interval= [KNL]
 			Time (s) between statistics printk()s.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a6a8b9ba342d02..a0d27756141846 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -140,6 +140,7 @@ torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stall_cpu_repeat, 0, "Number of additional stalls after the first one.");
 torture_param(int, stall_gp_kthread, 0, "Grace-period kthread stall duration (s).");
+torture_param(bool, stall_only, 0, "Suppress all non-CPU-stall kthreads.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
@@ -4649,6 +4650,23 @@ rcu_torture_init(void)
 		cur_ops = NULL;
 		goto unwind;
 	}
+	if (stall_only) {
+		pr_alert("rcu-torture: stall_only specified, suppressing all else.\n");
+		fqs_stutter = 0;
+		fwd_progress = 0;
+		n_barrier_cbs = 0;
+		nfakewriters = 0;
+		nocbs_nthreads = 0;
+		nreaders = 0;
+		n_up_down = 0;
+		nwriters = 0;
+		onoff_interval = 0;
+		preempt_duration = 0;
+		read_exit_burst = 0;
+		shuffle_interval = 0;
+		stutter = 0;
+		test_boost = 0;
+	}
 	if (cur_ops->fqs == NULL && fqs_duration != 0) {
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
-- 
2.40.1

