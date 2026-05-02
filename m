Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE3383C64;
	Sat,  2 May 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739339; cv=none; b=j9PF5Jsi8zs0c+YQ+3QpwqsPqr/eEBoTgxeDvWuZG/cX3Bl+ODIYS0mvbvjKrwJ8APOyqeaEPOE66EYp3KYm0W1Im3gTl087Op828lSYKPmwx7i3twHDfM11AdvhvKBEQ7PD9zKRD4COsNdXJttgDpGLlgb4b0M0jYrnav5sv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739339; c=relaxed/simple;
	bh=2ZgYvDSPJC+i1zG2ACG+VN/NVGRDLYmTk04Rpy4wn6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucHSeYhrGWe20//eHHHS2agJe7DPiO7/+O1fttMZDA/O1pG8IkDHj76JP4vbgDBNTPD/88UXsMiD5KzbJCCLOlLHfNBb8NV8AKs4OtpenhbS80EAF3BVMBbcVOeKDmy/kmUXcWMdNz5spgaYD1q8EEuOsmOMrNL7zsYFTLZaBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=krMQjbvz; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="krMQjbvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777739329; x=1777998529;
	bh=jpot5JK7c/aNwlhCNznatLfANEH4PZAz9UthTyHeKFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=krMQjbvzH0Az+4PHZunGTHP92DQxCBZgB1uYES5AqyDhPTpLvsKxtMX6aBKty8wKV
	 3BdGC6MVA3N80zhjCk5oNqpmqRIclauIOD4RAow22TAyBJ+zgECY2T5E3wELzWhklk
	 xsGtAYEuQj0Rc+huZK87f8oqx5hlog3hkI+BSHJOGumTLDm4QNFS11xEN7WILuGSX5
	 cD3+y67O9oimy9FKPI3KRDtuDV9gVBQW/k87bSrnN35ymWcfn8tpyD9xyrw1OS1KL1
	 Yvfr8RT64gnCNubaBMnE5o5w8WI5gzztgMAPShvR8jHc2cMc7IsD+BMV8H6yVHQ+Dk
	 IX5/Ig+HQpBrg==
X-Pm-Submission-Id: 4g7Cyj66Yyz1DFFt
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
Subject: [PATCH v2 2/3] rust: sync: add SRCU abstraction
Date: Sat,  2 May 2026 19:27:38 +0300
Message-ID: <20260502162833.34334-3-work@onurozkan.dev>
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

Add a Rust abstraction for sleepable RCU.

Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
Provide FFI helpers and a safe wrapper with a guard-based API for read-side
critical sections.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 152 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
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
index 000000000000..7bd713e96375
--- /dev/null
+++ b/rust/kernel/sync/srcu.rs
@@ -0,0 +1,152 @@
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
+/// The destructor may sleep.
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
+    /// # Safety
+    ///
+    /// The returned [`Guard`] must not be leaked. Leaking it with [`core::mem::forget`]
+    /// leaves the SRCU read-side critical section active.
+    #[inline]
+    pub unsafe fn read_lock(&self) -> Guard<'_> {
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
+    /// Runs `f` in an SRCU read-side critical section.
+    #[inline]
+    pub fn with_read_lock<T>(&self, f: impl FnOnce(&Guard<'_>) -> T) -> T {
+        // SAFETY: The guard is owned within this function and is not leaked.
+        let guard = unsafe { self.read_lock() };
+
+        f(&guard)
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
+        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
+        unsafe { bindings::srcu_barrier(ptr) };
+        // SAFETY: Same as above.
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
+/// critical section active.
+///
+/// # Invariants
+///
+/// `idx` is the index returned by `srcu_read_lock()` for `srcu`.
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

