Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6819C556;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161092; cv=none; b=qrj7ZpVkUDWPog+keXrTiORhj9+DztAXAeuSUJLGdT3AxH7bLyDFsi7E+nyJWp/h9qF09VmnAQwfCKhn4jCoY2pWZfdic6AOsDd9z3hCZUM2KPcyLDR5QDK1PHpBdScaZI6NPLshokIdfwR27MSy7+BJAYDtN9iruZnPRcHWsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161092; c=relaxed/simple;
	bh=5CQy2SixWdszyZBFvsnR1ERCtjWgrC0RnKvY/mF+7wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZmPDypFYsufwhmR52l0rfDS+BD0wwJOtlomVyZKI3rRiHAgBOutkQ7nzKQw/0UMqXYSohmWAJqlBlrttXOqmxV0RZAFekdudfgXBdYCtglqaqBSFwllc2OxrDNR/WeT6uuVz0+0xSfNvA0/Gt3EU55RDfKXzH7GXktBAX1oAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQVQALlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQVQALlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6A1F00A3A;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=hKV57X1DTBu0Cfp4aIMAmc3dhW9PqHag1BVOJPYPt6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQVQALlMKzkVNZDp0tUiKlTFJlzW7PNfLfZZa71OTwrJktCxeNXT6I2yXIJKtZV9/
	 XcK0VhLCMqa4lveym9swW5gzozxiDw/mnHJ2cNEFq9EM5/ADcmtKE0QYrrUGVCKBHh
	 3JHf6zQ77TKGIz5Ge53hgAsaero4GCA8vofFQrbXmKtbppQq7Y01KS+Jp50//WA3YR
	 blbugshSUZm80HIrUDDqVlUX82qaaXWWsNFGT0yvwTZn/ZyuYY4rYA4P6dmzzmljUO
	 yms6J2vLS5dOlgqSaWW1IWjnNyUn9SpZhxl6ajKm91AZCp+v/dXe/rR4rrRm3vfY9K
	 2/oxUtbsSZjYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 280A8CE0B87; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 02/24] hazptr: Add refscale test
Date: Wed, 15 Jul 2026 17:17:47 -0700
Message-Id: <20260716001809.11084-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index a2d9d75d88a10d..2320b3fedec736 100644
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

