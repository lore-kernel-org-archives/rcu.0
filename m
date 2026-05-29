Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E13DBD44;
	Fri, 29 May 2026 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055109; cv=none; b=R5vA8M3yB+Iosc7vHBqhx2Ay4gCTBCDiJ8Fg1XdcStc8RHdYT6oBnmW7cQQW51SzWnVnpSKkUukNnJlgLX6hQOF51zvLtzU/z7739E9IUQyYFoO2gqR4MKgqm3ecHwsvyLnO0DRTa6HuyFWZrF8CPHZVUkBAfuKUzUiI8hRBNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055109; c=relaxed/simple;
	bh=NSwV8H1x8cgnfXsyY2zJabPFaF5PVfJ3jmeU8N7JuUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVCtZaWIMlA0dmJDODaae2SkytkuLz6DIlFNSVIGzAmcRw+bSpho65K/uaGNvOFocHtCTsb+sFUnFR9sN1tvqOKlIaCaGFJeOWvzwOOrbA8jqD4gDvM7NY4WDYPLVTw2GmKroO8iEP47BTQ769o+26cTBKShu5ep61cUI8nEtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=txIii4K3; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="txIii4K3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780055103; x=1780314303;
	bh=HXee2wHQUfGBSPdjGkmcCWgVutpUg+hRBWS0MJgFMPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=txIii4K3ppYiHJKAy2/pPllksUoNngdYt6MkYOWfsPHnuulgILNJ9BJtnL+20SuvH
	 4cqs35ehlY298L0lWB72wo45maBEjUwCkPbX07hA9S/z+pWQYNonr2SZJIfZ61EmUa
	 e5fF0NGNiLJ4Lcpe8YjSF73sf8eHxnDNjDIb1WVQ4l4WKzuIgt6vPEb354ppRKJggO
	 WOcPKieZJqLOH3y9aD0UlEXFx4Yl4jHC0ZBFVyV613qsys3oxwNdTqQWhzknMcUzTh
	 3aeHukiBUloXy8HpslcL3szyZFDfRIAkBNxi0JA95Pj0dkgRsFXRwrqSri9Pr7Mq3r
	 qVvb47ktj5bog==
X-Pm-Submission-Id: 4gRhNs0DzVz1DDLg
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
Subject: [PATCH v8 3/4] rust: sync: add SRCU abstraction
Date: Fri, 29 May 2026 14:43:52 +0300
Message-ID: <20260529114449.112066-4-work@onurozkan.dev>
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
---
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 173 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
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
index 000000000000..75d4029dae43
--- /dev/null
+++ b/rust/kernel/sync/srcu.rs
@@ -0,0 +1,173 @@
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
+
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
2.51.2

