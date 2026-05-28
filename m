Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D73314D2;
	Thu, 28 May 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949712; cv=none; b=nWVNy7M7zeZ97EMdlmMlhurYo62i3WKIo6bjXnYwAhAg17eqruIDTGEvdqGO9vJqVn6MyjTvpQzK3NPS5VCrBofsbd+B9LLVY5SbmR2cbqurU03mO7h1LIfgyHK6Z1AEPhoH3qWfEKDmyiLUcbItXj6kXMPHZCpnMwzQbO0KpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949712; c=relaxed/simple;
	bh=nwto9TSN5DwcrkY38NX1+Y3ppUDOvXkhEPgbZdMEZeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0n/nd7Oqp4+aF0LggrgsvM+mRMva63zT5WJCmj3kIuyUGGl9JonGFYzso/a8+XqODkb7tExJ2lHZdv8Mt/iapxs8cmVwxajixuClyfdQ/BKKV9Bbk0P7/0nW+aR9COuYAY0XYAy8bnd39fMx5emyjaBNH6dTu8ZUJDB+ZXmjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Aq2UTG7Q; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Aq2UTG7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779949704; x=1780208904;
	bh=hucoFCxR6ZRmPQZBC0IZgPLRY3PhP3652ZNo3G0VcFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Aq2UTG7Q5Im+0tV8KLLx2G9sIjMGk/Ud9vgA0x86Yc27KmeQSNv3Qc0j78tfEp74P
	 iGcIXxPKZlTGwTOASQlxdX7D+7cw8vDTkUzOU7+nmus883ZGVqBGmRXtFTsWiuMz5y
	 tXUx4N2yzYVRFqO7wy3iO4BqPklSolYIGfgBdo8Ygd1EGBAip1mPdcc1+zLKgyyMLY
	 1SlIVoZ+vO0slgYh2VDQPRYcJ5q9i3A1+6p8Esu+nvDiVUQvVZkTznA25OxtAnnb1N
	 UCngCoYhB+ysDviGP1TahbU29qpevwfKRueoChj7bTf/QGhxbDHKl8h8AqqWcgLc0A
	 +ZuUTafAGQJUQ==
X-Pm-Submission-Id: 4gQxPx6lBqz2ScXC
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
Subject: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Thu, 28 May 2026 09:27:35 +0300
Message-ID: <20260528062810.256212-4-work@onurozkan.dev>
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

