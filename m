Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCD30ACE6;
	Sat, 13 Jun 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333650; cv=none; b=m8Q90M9l3NIq6cuwid9/dOJXFD0xKU3/QaDpWFA6U1i2W7JWXwAHb8PlkVU+pAtmabNly+QlBMAR6uVwtRGT+674RyobnxVC30ERLRhZ0F3cblwrYVcDNEgrEgy+Fy4vlTU8bzUBqUgFbIiWgDCXauD268KezxvXSjul+GY+x0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333650; c=relaxed/simple;
	bh=PyYKoa7RbFmyiDLg4OaMojEZF74GQzeJ+XLekAzno/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1dbXDbbgi8iz21I+F067GDh001mkejVOa4bSNIdU1UrExVkkZ1xihQyYuNziQjfVZSxdrDrOHAVilBTsIs9BWC6vv4LcpBBF5l+L4akyivSwJlnuUdiMzbuPuHappPCNmKGyMI8V5k5hyBmhNGeqhDWMajTjEDNaAZAzrBzoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=c+KfjTau; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="c+KfjTau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781333644; x=1781592844;
	bh=9A2yYgZS+uCTQ/JEfTEMSAcYH9qp17es7xIZDg8yPyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c+KfjTauniivPFVQ0kcwdFGMUCxzP3SvsgZ03/NsU0ewciFkQbk9yth0KVLwmof+E
	 igOIO1WSat7QO2nRxqf4XUoMVN7VaHEGXDq6qlpaOKU6ol7uNaU5hNBPQ+VXzhc2Ke
	 wCD8PlVRpVphRv2SCRkZwWRFJ3SmblbFpsUgqcxWL7tl4Kx/fSu9iuvNLmGENtr1uP
	 3E52pd07tCCKcBRZJFGeatp9f55pXLmehSBINAoTX7GhzzCBqgqwlwof+UXM8WI2ps
	 rSqDaNDi0RWdnckBwI+x8JumX3FVXFzd4U+q9mUTGACkKBEzhBcTe4TQMlT3bnblOO
	 1DRfj+lvKODYA==
X-Pm-Submission-Id: 4gcnD81RC1z1DF7c
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
Subject: [PATCH v10 2/5] rust: helpers: add SRCU helpers
Date: Sat, 13 Jun 2026 09:40:08 +0300
Message-ID: <20260613065348.96750-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>
References: <20260613065348.96750-1-work@onurozkan.dev>
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
 rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
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
index 000000000000..225b3bf9334a
--- /dev/null
+++ b/rust/helpers/srcu.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/srcu.h>
+
+__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
+							const char *name,
+							struct lock_class_key *key)
+{
+	return __init_srcu_struct(ssp, name, key);
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

