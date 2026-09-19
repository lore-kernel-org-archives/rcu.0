Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C141F94F;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776060; cv=none; b=LIoaObm5RoiQnze/Aw3NyJMRT8ZCIEVX3TSviXizHNkazftk3CV73LVOzBQZl13eV4CLB73OTnoLM+JOWYDxDJNyHYUfBEBjrWlYS1hQzZF1MzXb7aHlrQgmvEiZZlOYdX7rwnMx3MM1W2RTaCccbr8QHUNSwkL59sYPUsmjiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776060; c=relaxed/simple;
	bh=HVppPl4yH5zqxgIxTG0ed2cmOVeZGpp0AAgI8fUcywU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3M+UtB0+pF6oVfUZ+JwGEmUs4jbdNR1Jm49ZXsTw/3fmxthnakfP/fYKifsAyzE86DSNnW+8b6GBrJfVmK0G/eyfOo6BglQMfm9zXKub7GqsChf9lQ+Qdpfbd0mfXq4TgGdUjIETTTVvVdm+Va/5Aq1yefveQO2MPUtSBnUYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVvTWbPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVvTWbPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B85E1F000FF;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=0PVTlgZSVjQDst1HaijZhgACDm9/VK4lBirkalpeSN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVvTWbPUOQEkO1ATP9afipLEQls9wAvVT1Wvh+u1dQFNfT0gzqOjvxpLXvnTjjB44
	 yFZKMkrK6YNWOHYRMqcFvVYazkMgqu2D1rnMaN1IQinU9KrBsEEd65h7xvoPR0mPqL
	 TxV/TiHQx+wtBYrED8MCLjo6WH8JNaZhMwwWBACdbMSOIHw1QIUY5KFmJpdj55YjIC
	 5w2y5pify5MmMmZUpuL7Ir22WI0Kt4UfFrTmFYkDPPmoPW6l+KbiY2wTe2jiek9ZvU
	 2W+PoyDKBj5kcsxo+kqgdgAiWmzQld5DJ65zKZCQTcE1Hin1ymaCkp+Ljerxwot7VX
	 ZCPgYhbkh7Ekw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4DE4ACE09DD; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 02/28] hazptr: Add refscale test
Date: Fri, 18 Sep 2026 17:00:30 -0700
Message-Id: <20260919000056.3132131-2-paulmck@kernel.org>
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Add the refscale test for hazptr to measure the reader side
performance.

Co-developed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/refscale.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index a2d9d75d88a1..2320b3fedec7 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -29,6 +29,7 @@
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/seq_buf.h>
+#include <linux/hazptr.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
@@ -1200,6 +1201,47 @@ static const struct ref_scale_ops typesafe_seqlock_ops = {
 	.name		= "typesafe_seqlock"
 };
 
+static void ref_hazptr_read_section(const int nloops)
+{
+	static void *ref_hazptr_read_section_ptr = ref_hazptr_read_section;
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		struct hazptr_ctx ctx;
+		void *addr;
+
+		addr = hazptr_acquire(&ctx, &ref_hazptr_read_section_ptr);
+		hazptr_release(&ctx, addr);
+	}
+}
+
+static void ref_hazptr_delay_section(const int nloops, const int udl, const int ndl)
+{
+	static void *ref_hazptr_delay_section_ptr = ref_hazptr_delay_section;
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		struct hazptr_ctx ctx;
+		void *addr;
+
+		addr = hazptr_acquire(&ctx, &ref_hazptr_delay_section_ptr);
+		un_delay(udl, ndl);
+		hazptr_release(&ctx, addr);
+	}
+}
+
+static bool ref_hazptr_init(void)
+{
+	return true;
+}
+
+static const struct ref_scale_ops hazptr_ops = {
+	.init		= ref_hazptr_init,
+	.readsection	= ref_hazptr_read_section,
+	.delaysection	= ref_hazptr_delay_section,
+	.name		= "hazptr"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -1504,6 +1546,7 @@ ref_scale_init(void)
 		&sched_clock_ops, &clock_ops, &jiffies_ops,
 		&preempt_ops, &bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&hazptr_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.40.1

