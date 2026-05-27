Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B623C1985
	for <rcu@vger.kernel.org>; Wed, 27 May 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914197; cv=none; b=DVJ+qvuZ19r8LAuwXWcyvWlMtWfKezPoRV/uRpkmj7eS4w8r1U3Xd4SkuDnR9R+55D6ZqNUKNLmOO6zmY5AynwVx5ls/ygD/yQrAihn+I5UsiTo7BDXG1VlOkys94IST2/Tzscowsdz6rexxu0gL4vK2K64DDRQz1tXgVXU+HPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914197; c=relaxed/simple;
	bh=I2i3uzJwOMoBCVBbB1VcYmfDP4IyfkcCqKPPG2CKhu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI2cRJBliMyARVRmbOYklhgBIFsrZbpwxuLVczNK1h90hsL36Qc8irnr+DA8IV5czw2Ez4qwKd8CRzuZow3rYmbCRAwfAFMqA+SCcYfAtul/ivOJ3gmXI0NJQ0cwBpKF4CEsWVo7/EyxewQZ9qB+JS9RlBkK2Cj/1LkL4fehQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=sXKaX1lp; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="sXKaX1lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779914184; x=1780173384;
	bh=SyYfA8fMKv0cZigbZYxNO7h2rJuUY7s0jyURAudjKKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sXKaX1lpSVe6mL42/SOiMyTUxbpKm8tCUh8gFIlXwInB47x3SL8GduT21KkKFPY5c
	 JcblPo5dkn+sixL1EJuRQ3nzci7haXTQLm0xWbxkLDvujnY2PPwzJDxO0skht8oKto
	 JRCSHhGrRrnpZgz641t+C3fEnDqolW0NnbQQGS1otysjtzBG29g68WwrENBA9wMI6c
	 xf71B3yRUBmtIqmzyo0/XTtQj1CDJT2IIaAWQm2yWDEgm00dUZOqp0rRWj9tLUgzJ1
	 QXysg7w60NJC/N/iA6nucdOVt/SVelqUNGyJlxTrvxk0RFpQPwdBi+a+Lo1OFdnnhU
	 oI2yfQCjecueg==
X-Pm-Submission-Id: 4gQhGt2c6mz2Scq4
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v6 1/4] rust: helpers: add SRCU helpers
Date: Wed, 27 May 2026 23:35:32 +0300
Message-ID: <20260527203615.163688-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527203615.163688-1-work@onurozkan.dev>
References: <20260527203615.163688-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add helper wrappers for SRCU functions that are exposed to Rust
through generated bindings.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/srcu.c    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 rust/helpers/srcu.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..f3562d3b3888 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -88,6 +88,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "srcu.c"
 #include "sync.c"
 #include "task.c"
 #include "time.c"
diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
new file mode 100644
index 000000000000..79dd24a104ef
--- /dev/null
+++ b/rust/helpers/srcu.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/srcu.h>
+
+__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
+							const char *name,
+							struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	return __init_srcu_struct(ssp, name, key);
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+	return init_srcu_struct(ssp);
+#endif /* CONFIG_DEBUG_LOCK_ALLOC */
+}
+
+__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
+{
+	return srcu_read_lock(ssp);
+}
+
+__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp, int idx)
+{
+	srcu_read_unlock(ssp, idx);
+}
+
+__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)
+{
+	srcu_barrier(ssp);
+}
+
+__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_struct *ssp)
+{
+	synchronize_srcu_expedited(ssp);
+}
-- 
2.51.2

