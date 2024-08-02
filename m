Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A115AC4;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=TosHeh1zYrFHNRcjPh7zexxL6XazbqIX6zNLifKHRsibTfNg/KD9JgdUDbIYL6ilTRvUf7uNEmIhr59E3jNIQ+t/VpcPlLD0oQcr+B2rWMXsqvPF4BnW40s0sTytQ9mMpPAILBkYtx/mcJFBY3+hRmRAG6H5CSli01ZUteW90Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=DqMDZ/+cWkW/MQt6snJKfAxQMZLfZafULDqWCEsrGjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZBLW4YcddZasecWxjjk5b7nL1rjK2ljd1YLdZ/7/jlDoWZTsQWTaR4hP1aMHIepQj/jt/cS2BZaej1VQtkkbY/23e0K9D9W9V7Eyjl5vxI1jae7Q0K/55n5UTiNe6phccRjXQF45Be2k64rNdj9lsSTk+ZAj6ROcc35djh+2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcZ0cvtm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcZ0cvtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206DFC4AF0C;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=DqMDZ/+cWkW/MQt6snJKfAxQMZLfZafULDqWCEsrGjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcZ0cvtm3iviePhBC2csX/OmEVvnkyUSux2AdC6qQ718KGrvLQcH9FHvMuQgNBFf6
	 yYqaas4G5VStUTero6h+1r2+8hYJXrXWxfR0bgdEoCDNMNGyCsmKKIneyG/I3iSpg1
	 xyz3yUKRq0ZzcLdHvAHBEZkauWp9rlO4QE71fo7aUYiPcs5Dy5t4odImG7j74lu1Gx
	 oS0MaAJ8t6WwR87ugKnrtuv6JkUCNZmLIOWC6lcshCsLucu76IAqwY7j6ze8KY39YN
	 sV+JtQ2LJVpTc7hOR/a4qcsJBU9Mv1r4Np/LCADGXAwO/142oTv6bPcpc+tsCDaJc5
	 kWu3+qhpFj+tQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF25FCE0A01; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/11] rcuscale: Dump stacks of stalled rcu_scale_writer() instances
Date: Thu,  1 Aug 2024 17:42:59 -0700
Message-Id: <20240802004308.4134731-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit improves debuggability by dumping the stacks of
rcu_scale_writer() instances that have not completed in a reasonable
timeframe.  These stacks are dumped remotely, but they will be accurate
in the thus-far common case where the stalled rcu_scale_writer() instances
are blocked.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3269dd9c639f7..c34a8e64edc30 100644
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
@@ -1015,10 +1031,11 @@ rcu_scale_init(void)
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

