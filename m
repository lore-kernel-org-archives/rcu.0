Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C2382F0C;
	Mon, 25 May 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731852; cv=none; b=CbPcr5k4buqe36mXMj12lfSvJWu1yBLWBtgSmUYyh573UslfetfLYEo6mMTcMod/+o6wXpht8e3ZX4955auFqEq+0+rID5Sp1Ms2bdP8TN4uE2rnrHYbJ4SEq7uX0MyZU+5V58BBw4QL7wi13v4dATGeFIZtluSyai5MUmDFb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731852; c=relaxed/simple;
	bh=AiYYHhQnDBXRUI9uA1z+yKZgFykrG5PGIkYYq/LUh38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNAzxXjsSQcNZ25qVl8q6jwslzYooDx0HXoQ5ZVWvro6JkmMetEUY2Lqe50i/rUQBn462WMbG/u4VUTtkGKL3XxR4EG1p33p/xW/E8JP4unfhHKnK2Zobh8ez3hJ2fhDEOkvGpDvEEfG1KvkOa1YS6KeDmnsreBgt48PZOscXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=FjXDrjOi; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="FjXDrjOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779731838; x=1779991038;
	bh=iFA0pc/4fnxZD3BhBLp52E7zERRWsWbpT/pe9uVu+0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FjXDrjOisNcvQygkAyj4Pg3YGyLy0r0xMUb5hmcN0utnSPm5wCFjfniTmATwBRiT8
	 D7nSV5c+0dr4mJYlnwBMJp1a9Y2wYjKPfAyPsvsDOiP/K5oQ3iCEQ3enYfxhMxjVRI
	 id25Wo41wzcGdnbMTN7yBrPWtgk50CRccLweuMgNmmu0nJTBsAFrt6LRrPQA5Hz2jJ
	 jOuNpkr+zsj5bwlG8MSjYIbTraNVBhm8EXtoqsJD2VAOHEIjwuxerukx0t5hNiLAKL
	 ND87je88mMNkmVt6I3zmXEIY9BYqUcAE272XYXaR1sfuwXDC9lEZsA39HOwfKtWUse
	 Rh4CiA4JfZnZA==
X-Pm-Submission-Id: 4gPNr84pjGz1DH2n
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
Subject: [PATCH v4 1/3] rust: helpers: add SRCU helpers
Date: Mon, 25 May 2026 20:55:49 +0300
Message-ID: <20260525175706.124910-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260525175706.124910-1-work@onurozkan.dev>
References: <20260525175706.124910-1-work@onurozkan.dev>
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

