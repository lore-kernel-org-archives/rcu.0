Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462F2BDC0E;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161706; cv=none; b=mdsm1m2MAafOvigbxBrO5EHyikjBHfKVu+Bls1iSz9FiEwsj1oMkV9GL5rraLN2gVMiKZ0Vzm6VeQdsd5sgoslSKOWW1rnyUlnVKRowLbSj0+ZZ9JmyR1fzuS0ZRutkpnWQytGIzt6VcYp9/2tdc6HWXwnA6ymb/BsOOtmlwub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161706; c=relaxed/simple;
	bh=+HYh5TWo+jZqzQyJt7hUZ8rs2CoiXqjr6mKGvkYHPIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7BzI3tKyrCeqXS153VWhm1NPKG08tpP58Rwpyr2+/YzPbLrqiMQLq6vLu/83XvzouGNl6gw/MTbJVipVbsvUurZtMRjYg98O3jfJ9utpcq+vNyIihosMtSKbLYHfUzLjnEPbSnfUFBqTTyxB5ZhgiN1s0TMw4UX0mGkUziN6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuHWoaWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuHWoaWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D921F00A3A;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161705;
	bh=0G/9lixuEcp8q2iCYDzp4XsrGAmvKvdV//8mCb/bJqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuHWoaWLQu27woEyUzKnS6HxUYTPAnbQXGY3emFC7Oz6lKMCe3vLD2KWWxmiDEvDc
	 xa0Bl2XuFEeYP2u5h9MKf8KFkJ1cmZ0C6OPufaj0Oce5wiRw8OLwMeWgnzm0+SQKAH
	 ZSwCoAuig27MVpjg6mygeOYVqyMmDhNIZKXIe3+0ZF2bjC7MGE/80+U0E6I3nbbxFZ
	 E4X4UqcRGBtVYBuS/zCsWk7oPGi/9SpeSq+GeP1MWfTvngK5TZ5T0jVnB38WTPKKiK
	 rvKCC+vjupQi+v+GKrZH3s2iooQnmOwtZ4tkqECI3gtjX4TpDbU0uOSVi922khxIb8
	 fVeNwhGttmhBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E2284CE0B87; Wed, 15 Jul 2026 17:28:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/6] rust: helpers: add SRCU helpers
Date: Wed, 15 Jul 2026 17:28:19 -0700
Message-Id: <20260716002823.12176-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
References: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Onur Özkan <work@onurozkan.dev>

Add helper wrappers for SRCU functions that are exposed to Rust
through generated bindings.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 rust/helpers/srcu.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e6601..35954f38ff6a4e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -91,6 +91,7 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "string.c"
+#include "srcu.c"
 #include "sync.c"
 #include "task.c"
 #include "time.c"
diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
new file mode 100644
index 00000000000000..225b3bf9334a8f
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
2.40.1

