Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750873A1D0F;
	Fri, 22 May 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428572; cv=none; b=J8E2CqBKwkt5D6Vb9UG+yX9aNPV07qQoroMqkJdlaFxoYNqWxVyU2DgaJIO8+6y/KcfPAXTKPI8/sBnLnz2tD6yYDBQxrW8pgUNG3ztLMj/tEM+J3SgBlr2AUXOcF5Uyu8yQ5vTs07PoIXHQ+x8lxn1RIjdIuh4ktE5e3wZc3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428572; c=relaxed/simple;
	bh=VyHDPfzgboSDBdYwyL4hLr0QEZzsMvqg/MkfKOxxuCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxseWxx/xvAURV4hghgAuIOirWOVPH4fCkXnuVYk2exn6bJdYGmoPqD2OTbmjboLAolq19Nl0bxMtK/ruKpIIMDTjh4WPdAW69zzwgg1UVaT/mMzNLV5rU0wpf/2Boc6KuiBKyyEdXhn24J4Vzb35RKB4x8x3pB31OOuLmShnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=b5MJ5oCJ; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="b5MJ5oCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779428562; x=1779687762;
	bh=ZWcrCB8OMxpIpkGp621JdmItw4PzNVKkExpa+RY8gJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b5MJ5oCJZo1XfbiN0VAsqAyL9WDAh9pP1PZR3KnvZH2OUq002eB1lKQjHXoG2yTD0
	 k8oj4XUIJAQVycSMARSD3yGFhN/nhTnZeuG2aUC7lVfNGOrv3amx1P/Pd8VsteCGEx
	 NZAZGHCnSDgyQxKIX9o5WIsSwYFcjiE3ZvG1xoh6kYLnzDyer1EOO4PenATEPLq551
	 nN88zWqYfdPoBSlffvSr0K9UAf4CFIcd4yu4bbIaQoun9ASItu5v2pIURmg/GJ3T5k
	 +wtaxJJK1dpx1rhSFW8wXZMFMY3CQxiiNk2aYwlO9iun78moce57/sUrMYLr3yCCO6
	 BkgMkNnzgHW9Q==
X-Pm-Submission-Id: 4gMDgx1m6nz2ScPK
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
Subject: [PATCH v3 2/3] rust: sync: add SRCU abstraction
Date: Fri, 22 May 2026 08:41:51 +0300
Message-ID: <20260522054228.114814-3-work@onurozkan.dev>
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
 rust/kernel/sync/srcu.rs | 156 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
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
index 000000000000..c8fd370e8528
--- /dev/null
+++ b/rust/kernel/sync/srcu.rs
@@ -0,0 +1,156 @@
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

