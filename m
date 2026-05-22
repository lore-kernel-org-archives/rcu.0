Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B43A1A3F
	for <rcu@vger.kernel.org>; Fri, 22 May 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428569; cv=none; b=jqS3IgMyiml04xgeVmpo7taMoskMktqhZsay6QQqdvFMh3+gQ5T+KTKeAKMV3feb+aPs9vODxqRB5NshEXhbbNQhfsNwgtvgaHmk+GI/GtpufqleZ1zOZk8Xapywc8n9g4ebAi+KvLhlGkbkg8aANTHnnKFqqi40x29j6ce5eLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428569; c=relaxed/simple;
	bh=AiYYHhQnDBXRUI9uA1z+yKZgFykrG5PGIkYYq/LUh38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OI5YcPh1syBOgh9NIy1PXXe995IblGBVslN1LTTBzZu6Zz+SeX+O2L88vGQYRCcnLEXPA7m+CeqcfV7Kj5IuU4f7TwEBDYvhMo/49X/9fYltroO7GoOyiwvHZr+NBDUHpd1QXj0cI6JnR71URZmyh00PEf9iu03/QAVL9O/5vZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=sA3NBIpC; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="sA3NBIpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779428558; x=1779687758;
	bh=iFA0pc/4fnxZD3BhBLp52E7zERRWsWbpT/pe9uVu+0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sA3NBIpCnDDvF+agL24aTcvnSdPqUZ1WCmEmRGYzu0IvVn+jTsYls8ox3SwvG/4X3
	 zHiLcZ20KFW7e37rjQN7yUhaaYlkpq0x+P2wQv88ghU4NVyHTKHqCspZVKhPF19JNy
	 ro/TWVqAgMqke08AZId+ys3h8pwlewqcgaVHG7SfFM/U/N4Il9Y6M9SZ7z8DdoEXN0
	 M91V4IQRdgCs+e6h/n4nBRtrrW7m8oGlTaPSzVw1qhAsZhK76WochIHdlehvmESVQS
	 7/7XSboTW33QM4z318RVx2fOOLeJ4tTLK57OsQcvpCxGWi+g9G7v4YYwrajFUO95ou
	 je3f2N59jAsQw==
X-Pm-Submission-Id: 4gMDgv06L5z2ScPH
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
Subject: [PATCH v3 1/3] rust: helpers: add SRCU helpers
Date: Fri, 22 May 2026 08:41:50 +0300
Message-ID: <20260522054228.114814-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260522054228.114814-1-work@onurozkan.dev>
References: <20260522054228.114814-1-work@onurozkan.dev>
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

