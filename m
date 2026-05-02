Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6116383C94
	for <rcu@vger.kernel.org>; Sat,  2 May 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739338; cv=none; b=Tzxiptmm5MrEBQ+mrqetJOWm2+oiy0WamAJt/m+zFyl2dSrgG3xc54ult3W3/FV+OQ/n+/k+MOC6Vksgb7oYKtDjj5vxUilJy+I6ERWT5mrhcWTp+qHbsR1jzBOFE/0L5vRxENFDqyo+1wzS4+ZgEBQgB+yMS99iqQOFxgBWMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739338; c=relaxed/simple;
	bh=sFsnPP/TjA49FCwCuJLd6D0kqm266fCKXuwd3Kh4q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8XwcS/MWfpe/BCZGbtjpT0e3EJ8+vS8VK5oJEgYCyWZW7KHoN9JPGvndr2h3czQW3ETst3HE6xjQNVm/0E+Qkt9rbNWnthoqZFCK3XCmg2fXWEUfNXlxXe+MhdCVmlEEIxyOfRjrG57OjLU1TVN1bFN1lbc2uwHqLC0b11WyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=BYCAQERV; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="BYCAQERV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777739325; x=1777998525;
	bh=7Jzgvk8C4Ksf1LMZ0sj5siyM620cpHaF4e21fQG7iio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BYCAQERVOWRDUT96XjVWH20mL0cor4WCsUWyZZ11Sh9AgNKYIIHklxxXmuz+kAtOG
	 zLM7QDut8JFQDQR8KQ5dW3riF37lrkI8D7PsJUA55H1nkiBAQXy9XZWmpkIatsfVv7
	 8HYhLbzxiY9D6vzwRB9Mf8M1NorduX24+QK4LfEi67uKEIXyTlaQ9WIKnBLkGyQ0qg
	 qkQlZGPjiPo9tvRhuANWsd+ZpDAAPIpCQHtSFMBbZXMHgG4g2IraFM2RtSsmEZHopM
	 6VTwYPAsGAdPe5GTHRP4fOpN12Kg9mp/gmC0WDQlgyHY7XBwDltCTaPzdBL/2hqsv6
	 NYGjW/l3IZTVA==
X-Pm-Submission-Id: 4g7Cyg4srRz1DFFp
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
Subject: [PATCH v2 1/3] rust: helpers: add SRCU helpers
Date: Sat,  2 May 2026 19:27:37 +0300
Message-ID: <20260502162833.34334-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260502162833.34334-1-work@onurozkan.dev>
References: <20260502162833.34334-1-work@onurozkan.dev>
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
 rust/helpers/srcu.c    | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 rust/helpers/srcu.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 875a9788ad40..052fef89d5f0 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -60,6 +60,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "srcu.c"
 #include "sync.c"
 #include "task.c"
 #include "time.c"
diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
new file mode 100644
index 000000000000..e9f723d7f8c9
--- /dev/null
+++ b/rust/helpers/srcu.c
@@ -0,0 +1,24 @@
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
-- 
2.51.2

