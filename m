Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E12C2374;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161706; cv=none; b=tI40DpEYBdU1gPEFWhxmJjqdvxIbZEsv1UWHTbVbOm2r1Apew4lN6+uyhjAeJUGam0uOo1sLUOnLTRTgSoOhMqLZY8zDuVyzasEP7snnI4yGssKmJpNc/r1jGptx6/HwCm5HGR9mMkOkWcZiYjwPBUuUQoifHvg5O5Fto+ymgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161706; c=relaxed/simple;
	bh=gM5/MbENEbPAhb2e7y6j6iUd8I63P4tzQhAe4VLAljI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9ATlTrYWZV0iYn8X9pPxUUIpM72fKw/RltdTKqYRMZhQU+mTi+no3aEslTREXRFoTqgBUwJ7qNj72Rn9LoRc45zqEz72gBAk67ac14GYj73DRmetW8pwipz6POL/z4ka1U3jcsGBNkvhPQ6F3JFtD9RMAwQseAGvploaqDjz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtSRxN9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtSRxN9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9F41F00AC4;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161705;
	bh=HUVQixphC9JGVDQM6tFRacUMj/muhYJGp39Yy1ENlE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtSRxN9sHt/hI5Nylsb5vsKXX0Q1joWE8bvtH4IXWHnsr5DXIoi2rIwGzTXsDkJp6
	 2xza4v3eLlBAuUuCklVVv7jjJwbswVM4KPwIVJHYgiim6n8I5jG1SlcR+yLgtuqlcG
	 YHxTVUE8sYs1onWsyeg7G3U3ILbj7DBcCaA34mO2IiRcvt3X5lR2Gn3aVPMU9eZSe2
	 LfPh7dp52xZHMHYUIHgFJY1ZA5ecTyIC8xyQJULauW2UZEM45JE0u26PJgT5iBddyN
	 nD1TMDPejtm1nj1fHFCKiAoUjF+zKP3taBrgCjgVMFa4aFUtdaLGI80mmg142k9ROI
	 SwusseoEoUUUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E8019CE0C44; Wed, 15 Jul 2026 17:28:24 -0700 (PDT)
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
Subject: [PATCH 4/6] rust: sync: add SRCU abstraction
Date: Wed, 15 Jul 2026 17:28:21 -0700
Message-Id: <20260716002823.12176-4-paulmck@kernel.org>
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

Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
Provide FFI helpers and a safe wrapper with a guard-based API for read-side
critical sections.

Cleanup is handled via `PinnedDrop`. It first checks for active read-side
sections and emits a warning if any guards were leaked. In that case, it
waits in `synchronize_srcu()` rather than risking a UAF by freeing the
`srcu_struct` that is still reachable from the C side. It then uses
`srcu_barrier()` to drain pending callbacks before finally calling
`cleanup_srcu_struct()`.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 171 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 rust/kernel/sync/srcu.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 993dbf2caa0e3b..0d6a5f1300c3b2 100644
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
index 00000000000000..723e5e277fd641
--- /dev/null
+++ b/rust/kernel/sync/srcu.rs
@@ -0,0 +1,171 @@
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
+        if crate::warn_on!(
+            // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
+            // and `srcu_readers_active()` only checks the active reader count.
+            unsafe { bindings::srcu_readers_active(ptr) }
+        ) {
+            // `cleanup_srcu_struct()` may return early if there are still active readers.
+            // This should only happen if a guard was leaked with `mem::forget`, which is
+            // "WRONG" code and may cause a UAF because Rust will free the `srcu_struct`
+            // while it is still referenced from the C side (e.g. by `call_srcu()` callbacks).
+            //
+            // Another consequence of leaking guards is that `call_srcu()` callbacks will
+            // never run because the grace period can never complete due to permanently
+            // active readers (i.e. leaked guards).
+            //
+            // If this ever happens, that means the guard was leaked by mistake and the
+            // caller must fix the bug. Sleeping here is intentional and less harmful
+            // than risking a UAF.
+            //
+            // SAFETY: By the type invariants, `self` contains a valid and pinned
+            // `struct srcu_struct`.
+            unsafe { bindings::synchronize_srcu(ptr) };
+        }
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
2.40.1

