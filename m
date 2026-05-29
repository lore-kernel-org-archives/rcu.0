Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313B3BCD34;
	Fri, 29 May 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055105; cv=none; b=KDEXNxGaJuedj8tAMGOkCcmrybkv8YZQ0G4SCgA7/qfxzcY3QsJI522il8VVN21KdSfOSvlSK3IoPB/qo6OYIYcsFL4GSd0OMHb+4p3PXW7e+E59iVV4sg2iqPCg7aJz7qHwDc8iRcXjjzR5Bk056hnRUXji+djClsTHyXNwrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055105; c=relaxed/simple;
	bh=r2V3NNmJ1FMNs2qXlSBmdvHpo127A6yMdpacTbf8yWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onk0wHGrH9GX0dCaFpKhqM15bD8pXJ8yFM/btqtWn4E0IFxX4JI/gyL9jBPmKIG5k50jCg2JCs2MItC2ltB8Z0r8lI8dVCCtQrlPoitRa8OKmKGeWLJx5x0Yl7NhQwYOoFJY8A5+w+O9lpWuo3xJPqo0bAwDvPfpTzlvjbCfH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=dpe213dl; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dpe213dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780055099; x=1780314299;
	bh=r/4/lCxneay9Wm1Is0SI8vp62o6LmcLfnaBDeJWkaUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dpe213dlMyiaUNkfsvA0AEoEWws2Scuk1SHxjaYNIV1VYWC3pecvnoIIU+7V3w67e
	 N40GBPRaBX6algC6NL2wcxKgZ+MvfSggPKU2qDr6ooMGxco5LC41yQ93KqLALuu+eN
	 t/tP9gNqPqbWSBVcBk3no8l+ph1yd9VPzKezwt+3b2S1Qo3yf/X9adtgzhlGZ4+ecj
	 8NKEkz70g6Kjfi8w3IaIgZKoTBXRiv0ZeYBM8mECOgRe2SgUwUdGj/hfT40gCqpQ5A
	 M6t3egmnLNJsRsJbWvWJ4QZdwCORczngm6DP3rtuY/eGMLF4mbzMXehJmxjoGHc4KE
	 7lHpGoSA277Cw==
X-Pm-Submission-Id: 4gRhNn1K5rz1DDLg
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
Subject: [PATCH v8 1/4] rust: helpers: add SRCU helpers
Date: Fri, 29 May 2026 14:43:50 +0300
Message-ID: <20260529114449.112066-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260529114449.112066-1-work@onurozkan.dev>
References: <20260529114449.112066-1-work@onurozkan.dev>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

