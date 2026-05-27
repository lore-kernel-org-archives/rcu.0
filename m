Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4744E040;
	Wed, 27 May 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903704; cv=none; b=hOSjjFq143HKhQL3K484ufA24tvEqP37IrJ88KWLJQE72bqixAkkUwWOnycyv5qXJeToQWlEMjiqWRUZGxY+mIodGp3aK11O1ih8eG8XBfXCDv+36jXd1fdTAXGPggqPCO71i4/G9CfBqqi6YK985jdyVDb/gKtl/kJVnU7dRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903704; c=relaxed/simple;
	bh=nwto9TSN5DwcrkY38NX1+Y3ppUDOvXkhEPgbZdMEZeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1ZINeSc2VU0JhlE00OU543j5Gs/tIddaP01WQjfmgN1yqu+SEI/WmmO05ftgfsvuKGIcq0T/fftyG1SVwKkOsVlueTdpJXivP6QPPtXHQrKeQ/FeWavFx8s5qQRl3ZD7Kn83ocCJGbWCXkVylDTgKMzRUH9GCznZu4NjzgfWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=UMiK4Qh5; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="UMiK4Qh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779903693; x=1780162893;
	bh=hucoFCxR6ZRmPQZBC0IZgPLRY3PhP3652ZNo3G0VcFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UMiK4Qh5DsqNBP7iR9ypjBgaheHW3VNAKr88LS/BgVEmxoWhPoC8RNa90no5k+FOu
	 MkHGz8TPLdRvI4AlET6s3V5f2/RxGbnkJiFYMz/xtEWtaPGXQI00yHusHTYH2XuF5Q
	 hj1yWBykHsSlnASfYtxIhAHB6Bp6vJ0g30YvWk9FJPNjjZ+0UA4OGJ7yp0yi4V9AX6
	 XoKefl2ys+xsFQniHQuHwcixFhsJE1gXoXBObUy1LSoOT/D0Q8XsqD2NHsvABaeDfd
	 g32G1VUwmS9G652/JrQa43kEgiaNzk/TTA8JRJxBEi2vyYaYaMo757QbxgHN6LiNrj
	 VoZxuUYZnUNnQ==
X-Pm-Submission-Id: 4gQcP60Scmz1DF6t
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
Subject: [PATCH v5 3/4] rust: sync: add SRCU abstraction
Date: Wed, 27 May 2026 20:40:44 +0300
Message-ID: <20260527174120.510447-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527174120.510447-1-work@onurozkan.dev>
References: <20260527174120.510447-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
Provide FFI helpers and a safe wrapper with a guard-based API for read-side
critical sections.

Cleanup is handled via `PinnedDrop`, which explicitly drains pending grace
periods and callbacks via `synchronize_srcu` and `srcu_barrier` before
executing `cleanup_srcu_struct` to guarantee memory safety e.g. when there
are leaked guards (via `mem::forget($guard)`).

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 rust/kernel/sync/srcu.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 993dbf2caa0e..0d6a5f1300c3 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -21,6 +21,7 @@
 pub mod rcu;
 mod refcount;
 mod set_once;
+pub mod srcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
@@ -31,6 +32,7 @@
 pub use locked_by::LockedBy;
 pub use refcount::Refcount;
 pub use set_once::SetOnce;
+pub use srcu::Srcu;
 
 /// Represents a lockdep class.
 ///
diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
new file mode 100644
index 000000000000..343f00d070c7
--- /dev/null
+++ b/rust/kernel/sync/srcu.rs
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Sleepable read-copy update (SRCU) support.
+//!
+//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
+
+use crate::{
+    bindings,
+    error::to_result,
+    prelude::*,
+    sync::LockClassKey,
+    types::{
+        NotThreadSafe,
+        Opaque, //
+    },
+};
+
+use pin_init::pin_data;
+
+/// Creates an [`Srcu`] initialiser with the given name and a newly-created lock class.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! new_srcu {
+    ($($name:literal)?) => {
+        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+pub use new_srcu;
+
+/// Sleepable read-copy update primitive.
+///
+/// SRCU readers may sleep while holding the read-side guard.
+///
+/// The destructor waits for active readers and callbacks, so it may sleep.
+/// If a read-side guard has been leaked, dropping an [`Srcu`] may never return.
+///
+/// # Invariants
+///
+/// This represents a valid `struct srcu_struct` initialized by the C SRCU API
+/// and it remains pinned and valid until the pinned destructor runs.
+#[repr(transparent)]
+#[pin_data(PinnedDrop)]
+pub struct Srcu {
+    #[pin]
+    inner: Opaque<bindings::srcu_struct>,
+}
+
+impl Srcu {
+    /// Creates a new SRCU instance.
+    #[inline]
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            // INVARIANT: On success, the C initializer creates a valid `srcu_struct` and
+            // it remains pinned until `PinnedDrop` runs.
+            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_struct| {
+                // SAFETY: `ptr` points to valid uninitialised memory for a `srcu_struct`.
+                to_result(unsafe {
+                    bindings::init_srcu_struct_with_key(ptr, name.as_char_ptr(), key.as_ptr())
+                })
+            }),
+        })
+    }
+
+    /// Enters an SRCU read-side critical section.
+    ///
+    /// Leaking the returned [`Guard`] leaves the SRCU read-side critical
+    /// section active and makes `drop` sleep forever.
+    #[inline]
+    pub fn read_lock(&self) -> Guard<'_> {
+        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
+        let idx = unsafe { bindings::srcu_read_lock(self.inner.get()) };
+
+        // INVARIANT: `idx` was returned by `srcu_read_lock()` for this `Srcu`.
+        Guard {
+            srcu: self,
+            idx,
+            _not_send: NotThreadSafe,
+        }
+    }
+
+    /// Waits until all pre-existing SRCU readers have completed.
+    #[inline]
+    pub fn synchronize(&self) {
+        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
+        unsafe { bindings::synchronize_srcu(self.inner.get()) };
+    }
+
+    /// Waits until all pre-existing SRCU readers have completed, expedited.
+    ///
+    /// This requests a lower-latency grace period than [`Srcu::synchronize`] typically
+    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synchronize`] by default
+    /// and use this variant only when reducing reset or teardown latency is more important
+    /// than the extra cost.
+    #[inline]
+    pub fn synchronize_expedited(&self) {
+        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
+        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) };
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for Srcu {
+    fn drop(self: Pin<&mut Self>) {
+        let ptr = self.inner.get();
+
+        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
+        // and `srcu_readers_active()` only checks the active reader count.
+        if unsafe { bindings::srcu_readers_active(ptr) } {
+            crate::pr_warn!(
+                "Leaked `Guard` detected while dropping SRCU; drop will block forever.\n"
+            );
+        }
+
+        // `cleanup_srcu_struct()` may return early if readers are still active. Because `Srcu`
+        // owns the embedded `srcu_struct`, returning from `drop` in that state could free memory
+        // that is still referenced by the C side.
+        //
+        // Wait for all readers to complete first. If any `Guard` was leaked, `synchronize_srcu()`
+        // will sleep forever.
+        //
+        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
+        unsafe { bindings::synchronize_srcu(ptr) };
+
+        // Ensure all SRCU callbacks have been finished before freeing.
+        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
+        unsafe { bindings::srcu_barrier(ptr) };
+
+        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
+        unsafe { bindings::cleanup_srcu_struct(ptr) };
+    }
+}
+
+// SAFETY: `srcu_struct` may be shared and used across threads.
+unsafe impl Send for Srcu {}
+// SAFETY: `srcu_struct` may be shared and used concurrently.
+unsafe impl Sync for Srcu {}
+
+/// Guard for an active SRCU read-side critical section on a particular [`Srcu`].
+///
+/// Leaking this guard with [`core::mem::forget`] leaves the SRCU read-side
+/// critical section active and makes dropping the associated [`Srcu`] sleep forever.
+///
+/// # Invariants
+///
+/// `idx` is the index returned by `srcu_read_lock()` for `srcu`.
+#[must_use = "if unused, the lock will be immediately unlocked"]
+pub struct Guard<'a> {
+    srcu: &'a Srcu,
+    idx: i32,
+    _not_send: NotThreadSafe,
+}
+
+impl Guard<'_> {
+    /// Explicitly releases the SRCU read-side critical section.
+    #[inline]
+    pub fn unlock(self) {}
+}
+
+impl Drop for Guard<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `Guard` is only constructible through `Srcu::read_lock()`,
+        // which returns a valid index for the SRCU instance.
+        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), self.idx) };
+    }
+}
-- 
2.51.2

