Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308232F3C07;
	Sat, 19 Sep 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776063; cv=none; b=L2U0CjJn+ZPVBFWPSSwRkXgjZKC2yTximbN2CrTaoQNT0QXshE/+fcK6mLggQFXXmtrZWrTh5CfHtGZceIHHqPIYJYCbwryZij0iMVrW7JLEScC39hERuN1yp7AapcoyFUcKHXbh0tqt9xLYHeeRd0XCMPX3b9uMM1QGm8Se7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776063; c=relaxed/simple;
	bh=BG/eIdCROidSSovw95vUlJ5Pw6+HBJ8lc7YJNiCSuag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy0anO/fGRCwX4xvwxSOJGy/riviTEpBL+sIIIbq0NJZdL4fSh9saVey6PJzKJrI/softTzuTR0lEoHYAFmcSTaTw0v/bBHeRKH9RFhAdJ8ynDoTOmSq3jOkeGf+0H+3J2ur8giqXtuHdwpoAreVh4t4cBCJ4dKWsRBe9JudIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewe9Wqed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewe9Wqed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB52C1F008A1;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=f+uBQRZf1YNiOTbEfxFPeHZLB0uvmpwyoRT+Sxtsv/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ewe9Wqed6IXx0gFj4+hwxnlCAx6hiIa+IVAhoo88vl6w3aGdRJn5sF2F2ka7rxvVO
	 MQunNLyhUsHIttQNusB7ahAMDkbNzVg+meW2qi9PrEAASuIeQ3bfbl2E8d+DbRm2Lp
	 NRJY3tEGcfK1Wmxnq110nvf1G5n7KJhpATuO094y+V/WX20UA3Cky1ifNN+sMQODvh
	 KHQzdCHIG/V/J2UnSUIyH1Af1Fuipv4LG2MNqV4jDVzf0DZPtNTXQBKhSpMsPOo0XM
	 33J054ZnB6UfvQzZF8g8sJ77o5+kradOTiSIcjPf0cJQAXMN8EF3gKP5MnGV2ZOvPj
	 sVQc2dhrit1Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63054CE0ADA; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 09/28] hazptrtorture: Split hazptr_torture_reader_tail() from hazptr_torture_reader()
Date: Fri, 18 Sep 2026 17:00:37 -0700
Message-Id: <20260919000056.3132131-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit splits a new hazptr_torture_reader_tail() function out
of hazptr_torture_reader().  This will allow hazptr_torture_reader()
to pass hazard pointers off to other tasks and to various types of
handlers, and those hazard pointers can in turn be passed to this new
hazptr_torture_reader_tail() function to complete processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 42 +++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index c0ebabdcc72e..8672169f7868 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -351,6 +351,31 @@ hazptr_torture_writer(void *arg)
 	return 0;
 }
 
+/*
+ * Do the delay, the accounting, and the release.  This in intended to
+ * be invoked from hazptr_torture_reader, but also for hazard pointers
+ * sent off to interrupt handlers and the like.
+ */
+static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_torture *htp,
+				       struct torture_random_state *trsp)
+{
+	int pipe_count;
+
+	cur_ops->read_delay(trsp);
+	preempt_disable();
+	pipe_count = READ_ONCE(htp->htort_pipe_count);
+	if (pipe_count > HAZPTR_TORTURE_PIPE_LEN) {
+		// Should not happen in a correct hazptr implementation,
+		// happens quite often for TBD torture_type=busted.
+		pipe_count = HAZPTR_TORTURE_PIPE_LEN;
+	}
+	if (pipe_count > 1)
+		rcu_ftrace_dump(DUMP_ALL);
+	__this_cpu_inc(hazptr_torture_count[pipe_count]);
+	preempt_enable();
+	cur_ops->readunlock(hcp, htp);
+}
+
 /*
  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
  * hazptr_torture_current, incrementing the corresponding element of the
@@ -365,7 +390,6 @@ static int hazptr_torture_reader(void *arg)
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid % nr_cpu_ids;
-	int pipe_count;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("hazptr_torture_reader task started");
@@ -373,6 +397,8 @@ static int hazptr_torture_reader(void *arg)
 	do {
 		htp = cur_ops->readlock(&hcp);
 		if (!htp) {
+			// Still starting up or allocation failure,
+			// so get out of the way.
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
@@ -380,19 +406,7 @@ static int hazptr_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		cur_ops->read_delay(&rand);
-		preempt_disable();
-		pipe_count = READ_ONCE(htp->htort_pipe_count);
-		if (pipe_count > HAZPTR_TORTURE_PIPE_LEN) {
-			// Should not happen in a correct RCU implementation,
-			// happens quite often for torture_type=busted.
-			pipe_count = HAZPTR_TORTURE_PIPE_LEN;
-		}
-		if (pipe_count > 1)
-			rcu_ftrace_dump(DUMP_ALL);
-		__this_cpu_inc(hazptr_torture_count[pipe_count]);
-		preempt_enable();
-		cur_ops->readunlock(hcp, htp);
+		hazptr_torture_reader_tail(hcp, htp, &rand);
 		while (!torture_must_stop() &&
 		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
 			schedule_timeout_interruptible(HZ / 5);
-- 
2.40.1

