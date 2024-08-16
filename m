Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0113A256;
	Fri, 16 Aug 2024 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791857; cv=none; b=A9CbfHBtr4aPp1urUmaeOA0y0oxvL6ZXoBzQ+YGLfzipuOLSQT984IG2SjljB4e0tNfC40NPTtdd0Ttl/6OT6V5GwS+TfwJJrgpJJWFXoGljaaMGD/v39afhhydecJ7nMa8Vk6sZ0+X/0c1ja/gd3NeeedSoqNc61HrHfgQNU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791857; c=relaxed/simple;
	bh=vtELkXCUFMg5oRqM2b92OFdwmNazPUkHQIvr96CsLRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYgxMTNCzcil2jHvkaOWibrv6+8LjPlMi+sZ6oxY2H0FbhTCnU9+sdDCgyClURwJnOTNZsAeNgvibycrlOVjTm8tqC4t+lyqObz+HBtfBs5Sgeoj6Hn13ug2J7dwm3lb3qEE0XHO71UqlnKrpYFUglXwHU3TrDKcFwpxIMrlU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3RtWp/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3RtWp/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8441FC4AF13;
	Fri, 16 Aug 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791856;
	bh=vtELkXCUFMg5oRqM2b92OFdwmNazPUkHQIvr96CsLRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3RtWp/h57Ally7NN/Jk6EZGMseop72P0G6LKxEWPJbjtEC7pxtLnccf59tfmZJ9d
	 a7+GVSIV8BiHOW2hUKDIVmPeXja6kS4EjuXrYGyHwlsnKwUBjtNQzCAxh6jhSJd+G7
	 0XuHQk6GqiZ48sRZTXXaQhDAI7h8YI+54h3Dmfx2W90streaJ4aSoPjtwITa+mbdJB
	 ltPd5KuDTzT09UvdFnzHmhEjs8ZHdSKnCpcu2WVgwQ7rIWfEnIVUGKZdqzfPI9KEkh
	 ESJL+69ZFXqHO/QKIvWcCqLhCP5G6MeN8JhxVufLGy+vrM/0fkLnTj0oFJAyuEId4F
	 MATMb47OazoAA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 04/14] rcuscale: Dump stacks of stalled rcu_scale_writer() instances
Date: Fri, 16 Aug 2024 12:32:46 +0530
Message-Id: <20240816070256.60993-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit improves debuggability by dumping the stacks of
rcu_scale_writer() instances that have not completed in a reasonable
timeframe.  These stacks are dumped remotely, but they will be accurate
in the thus-far common case where the stalled rcu_scale_writer() instances
are blocked.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3269dd9c639f..5087ca7062d9 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -39,6 +39,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/sched/debug.h>
 
 #include "rcu.h"
 
@@ -111,6 +112,7 @@ static struct task_struct **reader_tasks;
 static struct task_struct *shutdown_task;
 
 static u64 **writer_durations;
+static bool *writer_done;
 static int *writer_n_durations;
 static atomic_t n_rcu_scale_reader_started;
 static atomic_t n_rcu_scale_writer_started;
@@ -524,6 +526,7 @@ rcu_scale_writer(void *arg)
 			started = true;
 		if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
 			done = true;
+			WRITE_ONCE(writer_done[me], true);
 			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
 				 scale_type, SCALE_FLAG, me, MIN_MEAS);
@@ -549,6 +552,19 @@ rcu_scale_writer(void *arg)
 		if (done && !alldone &&
 		    atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters)
 			alldone = true;
+		if (done && !alldone && time_after(jiffies, jdone + HZ * 60)) {
+			static atomic_t dumped;
+			int i;
+
+			if (!atomic_xchg(&dumped, 1)) {
+				for (i = 0; i < nrealwriters; i++) {
+					if (writer_done[i])
+						continue;
+					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
+					sched_show_task(writer_tasks[i]);
+				}
+			}
+		}
 		if (started && !alldone && i < MAX_MEAS - 1)
 			i++;
 		rcu_scale_wait_shutdown();
@@ -921,6 +937,8 @@ rcu_scale_cleanup(void)
 		kfree(writer_tasks);
 		kfree(writer_durations);
 		kfree(writer_n_durations);
+		kfree(writer_done);
+		writer_done = NULL;
 	}
 
 	/* Do torture-type-specific cleanup operations.  */
@@ -1015,10 +1033,11 @@ rcu_scale_init(void)
 	}
 	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
 		schedule_timeout_uninterruptible(1);
-	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]), GFP_KERNEL);
+	writer_tasks = kcalloc(nrealwriters, sizeof(writer_tasks[0]), GFP_KERNEL);
 	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
 	writer_n_durations = kcalloc(nrealwriters, sizeof(*writer_n_durations), GFP_KERNEL);
-	if (!writer_tasks || !writer_durations || !writer_n_durations) {
+	writer_done = kcalloc(nrealwriters, sizeof(writer_done[0]), GFP_KERNEL);
+	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done) {
 		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
-- 
2.40.1

