Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA9378D70;
	Mon, 23 Feb 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879473; cv=none; b=gBtWM9HEVVHGYCy2K/DH60qnEWTmOBzz8jjepoSdganMnboUQTd0v/VTzfJua3+8s0WFoCPrPKNlf5Lv+9B1aQsa74RSxdVMb7j8/OZb/XsAMR6+eS/3dP7DYlHyos6VMIoUpqCHZzkB+0PMHbEoiE1OHLbrtoMua3xKp0MYW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879473; c=relaxed/simple;
	bh=KRLeC9uIYhTend5uWbzrq9B2XZ0mtJpwAALcypC0Bbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmgHUpQGT27h5L4R+wB2JOjSeJYqJEfTMw52u4xT9WsjGXprrEjK+o+eUSTrdWIoAj/Vlqt8GxjqtAWgJj27u07TufHZ/UoM7BtYyZtFMNVgmjqjfkiNWKPD0J40QnrFu6wZD3OWtAJ3oJchhROKkParHT1ANXrQ0mkmyC1flb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aoGj60zs; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aoGj60zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1771879461;
	bh=KyTEEaoXAAyCQz7ZsgcVYW88Dh1Bs2/KiZ/NYa4dnJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoGj60zs4KFIYxAUrRWU6lEvNVCe3z+VyrASWTHF+XgH58FbnH/OrB8z+3vOzmvP8
	 JMsxujoo9dt8RcFHa5fxdRwn80Lc9s9Y93bCTENVz/WqCwliCOiQDS0bXovc2us1FV
	 ncGIF3lsVuR2iLlwm2pya7s+JXnESfpkoeQo3DIoWcyQgHF+ZKJUM0DUae8Qz8Xxm1
	 XH2sQ0IA4rSLNY4uksDZ/2lh2aUOL4orhYx8pXWyy/rEfJBkZ5vequihw1xAFNy3WK
	 7RKqWoXx8Z4GXP6xaS36EzKG2f4eVdTVa3RmO8LNcOl69uV07hUyUEoEOTS6e05rDo
	 +XtYiSzPTdszw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fKXs12rh7zHyx;
	Mon, 23 Feb 2026 15:44:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v5 2/2] hazptr: Add refscale test
Date: Mon, 23 Feb 2026 15:44:18 -0500
Message-Id: <20260223204418.1429025-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260223204418.1429025-1-mathieu.desnoyers@efficios.com>
References: <20260223204418.1429025-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the refscale test for hazptr to measure the reader side
performance.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun@kernel.org>
---
 kernel/rcu/refscale.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index c158b6a947cd..7d64dfe78327 100644
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
@@ -1210,6 +1211,47 @@ static const struct ref_scale_ops typesafe_seqlock_ops = {
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
@@ -1524,6 +1566,7 @@ ref_scale_init(void)
 		&sched_clock_ops, &clock_ops, &jiffies_ops,
 		&preempt_ops, &bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&hazptr_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.39.5

