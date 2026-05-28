Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74F3321DC
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949705; cv=none; b=dWZxOa5JIPvlQRQ1Dv7W1IAdnr1ERRlkv9syBQ+TH2qfqYXGv6H22pPNUhSw+W3ctttk+U7MlTr8l+XTkwHHPq3i/GUDOetq+0ESpbcjvOnZrYe4labkdMsoeoBTIQgfEquVcUAWPq8Fujp+PVI8G8wCYrP1qhT/hbvxBgZgl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949705; c=relaxed/simple;
	bh=BJGCuTwKXnb7xtObAQRjjs/n0+cYOdiYTtYroZHcwEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzpn02Tke38FZgxXoBYy9DNOS80ZDUsbatXt0ZUuhxQ4NfFiWJ8rv1Kq9SeYt/H0lpfsSUYoEa+jWlCVuk2S6/GaR1wmNQBtw7HNHdkdhXCMIhXX+84cVQ0M9FGyiJaf3+C8etqL+w29Ty0EdWoze2msWYuL+erobnPvxYZSl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=nes94oZI; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="nes94oZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779949698; x=1780208898;
	bh=JFj8bpASKdO/Q6l1EDIhoBmA4UrdA23CFVdITf9usiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nes94oZIHmE0wxBXW7AyOlmGRw3fEL2uX5ZUZ0KVorStmhwZ1E7G7mDBV2/1LPt8S
	 vpCa29hNy7ABaZCo9b6IZZ1wK9vXvPEAU18yeYKUG6NKqyq7eOuFI4NsgNNqKnGaBO
	 iIZK/3gbgB2xlbqzuotdIyYhdjJeAchii5hOc3LITCRdki4CcG//2aKXFH8GdLzRxs
	 cYcc8Z9pyfmkwS/oqFVRAH37bbhxPSJ0BmBxHptsxbeE1INpaIrCshtM2GH5bwtbcQ
	 XzasH74zAqqEgLk6/ARAB4rakVb+8jZkZRfPmXKWi1WaPpk/+Hpb5HXsOQ52SlEmNB
	 D8miATct38AFw==
X-Pm-Submission-Id: 4gQxPq0Sf1z2ScXC
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
Subject: [PATCH v7 1/4] rust: helpers: add SRCU helpers
Date: Thu, 28 May 2026 09:27:33 +0300
Message-ID: <20260528062810.256212-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260528062810.256212-1-work@onurozkan.dev>
References: <20260528062810.256212-1-work@onurozkan.dev>
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
 include/linux/srcu.h   |  5 +++++
 rust/helpers/helpers.c |  1 +
 rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 rust/helpers/srcu.c

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5..790a4ef713c0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
+static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
+				     struct lock_class_key *key)
+{
+	return init_srcu_struct(ssp);
+}
 #ifndef CONFIG_TINY_SRCU
 int init_srcu_struct_fast(struct srcu_struct *ssp);
 int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
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

