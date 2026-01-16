Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF5284890
	for <rcu@vger.kernel.org>; Fri, 16 Jan 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578412; cv=none; b=DeCwui3prdd2Xu1q5iqfXsZbcFRPPNn56niDvDwAKuWJqBAHWP+Ytln6KoBXSxfFC8IHSqJ5tXg6lgXigTklVc2JgLGbgWlm6Li0CoROMo5ww+nmuXghbpOx49I0tlXDo3juSw927wq9yJLfIEcUMN7S5x9UXX5x0UPiI9PSX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578412; c=relaxed/simple;
	bh=qrwQQ5xsRj1H/N0Lbw6W36heDLQuKhlXvlReIJHGg14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D30oHDCS6r3zIA0iqf+TMz+gCYqAVIeQZBgI/I34fDs9ZgWEMYc1sRcqhKBEaxnbXL8GFz66IucW1liftYT+VVR4j16MC+RAMBT2wfrvrftm4ufwmQrrqIkiLM8/82Uyc2Nm+sSbh12TmSTskIRaSc537HqSg+uX2AqWtPWIYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OushxbYy; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OushxbYy"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso16599925e9.3
        for <rcu@vger.kernel.org>; Fri, 16 Jan 2026 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768578408; x=1769183208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIlza/EGnIT3hgfaEJFw0khZWhczs5SOkfu9nbXLDHk=;
        b=OushxbYyg+t/oqSTKfcnQyt4+mpO8qO3ZOJVljHF3rDHq/OLFz3qSB4iRebggbRoty
         2ZxTcSvU8oJAye54W6bD+mo7nTDZEM8hCQyEvViXDERLwHus2t7aQezfPKuyb7C2nMy8
         EjkHkooYaGwdC9ksAHjRr7wVczZgb8xw72TOyq7JEJuqEa8m8YBdpKgSm6k3y6YEsvLn
         JA3bw6/wtn4IJny8SqvIkZnC9KOIHH+LXg6VTo2PixDzkcwutWp34pNur/Czx46l3OuI
         cEqkmCJRfDFI36mTH3qLm+ng6K44vhKfTQcOwcJygERmd4uc3/bBW3u8rYL2ds4e2jto
         XrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578408; x=1769183208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIlza/EGnIT3hgfaEJFw0khZWhczs5SOkfu9nbXLDHk=;
        b=R0dECpjuEX91NOE+IMpr74giX3ZTfRceHPThfVsbJI/p3x4ZitjpclYd4lFL227o2q
         XOIHPxipWLGXtWaFwUD52jLKovxh8+aOLpJGD0pEuavxP8KjxFBFJmDPZKS7MfxcRu3y
         yPt+SH9iB9pQysVeCauqrCADXGYAkzPbaNFAP/1GQ+BXfUBSnrqcWcCZ945uC77/F3MS
         GpX64jUByvxCkR1Qp+N+CnerWDGIOx6MXc0xelS9nt9KdrclVbWrOJmqaEg6d5ih99KT
         tzrJCArRrp2IUlm+ray0It2a+1oGyMIcax6tlRm6GwiHvglm35KIJPgqVbCqfl8MDkhD
         RxHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnKtHVzcUZFb6WPhWNmsyX47GKMGYGmlbTJSJRqSB0eB+5bUse4Co0LZnmv2mZOn4X7FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFq1KXKKmk52A+KR9oCAsTYWvNh4VKNU2RWYCOD7jw0SH0vQRK
	VB0PxXmnNt8l0Qqw86F2J5thbWmezJycW6dBRvOMl7hnfpFXbvAB8dLsgxfcZLiyyO6dh4SQq9m
	jCVYcQBcoFYdarjns0g==
X-Received: from wmpy3.prod.google.com ([2002:a05:600c:3403:b0:475:d804:bfd2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b56:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-4801e34307emr47609855e9.17.1768578408586;
 Fri, 16 Jan 2026 07:46:48 -0800 (PST)
Date: Fri, 16 Jan 2026 15:46:36 +0000
In-Reply-To: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8262; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qrwQQ5xsRj1H/N0Lbw6W36heDLQuKhlXvlReIJHGg14=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpal1mDrDeKeyvaU29qIbnCvyLx3rDZRhNGy+hR
 OG3G3eqsleJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWpdZgAKCRAEWL7uWMY5
 Rm8+D/9n64VsnGt3hO31FzuNqa+W36tkyfYCTyC6MMFPCvX+o5hhbogdCWENrBQnnikEDar72kY
 BMtRrpL6uZZl9vBs1IKaoZZHlST/s4YZ/8V7G69kMwpC8+t2jel+1DbyxM72TQtHzbU1RKfBJzm
 WLtAbM90kXzh2Znzx0FUTbpJmiBPEHT42eG1waXGomyXKzLHv+BmiHZ8oJi/+PBtZgtUSWuZXEu
 s6rB0zy6e856mNjXaxtZyrt/P73f5gTTv2bf7Amh6W1DimBQUCf64rlD7pNSnQVFxu6MDTOeRYB
 HZjXZMeESXjfHN5Xi0Fb7ZSL7PIfGfbuYxDe90xome9wKcVmFtQxBbJUeh3JU+8jc+GPK1VSRqP
 EWQJkAZkePabVCxmu9YQ2VdgzkQHPHhc7NL/gS/H65CPow+piI7sL4u6nBD07A517WJmP+RZ28I
 qryZA/ge8Kfmr4w4EzrvLQsYvWezu9C8yWROxA1khFfolzpI4U3LZFUPKyGsINOU6dUC6NdsNYH
 ceCn6b1HN7Omu9q9k/QV3kmCBNsba35VPBLcrOzgdS3zDx+nv7fBbvQXt5vbsbt42XigNR4HlkK
 //MALI3yvqVBJ9y3oy4UUHgToasWCPUQvdsaw63w1pUo3uk11/y3tubvt9Lcl+5gdMt8EFUFMKD HQFt5FCcA2hhXXg==
X-Mailer: b4 0.14.2
Message-ID: <20260116-rcu-box-v1-1-38ebfbcd53f0@google.com>
Subject: [PATCH RFC 1/2] rust: rcu: add RcuBox type
From: Alice Ryhl <aliceryhl@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds an RcuBox container, which is like KBox except that the value
is freed with kfree_rcu.

To allow containers to rely on the rcu properties of RcuBox, an
extension of ForeignOwnable is added.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync/rcu.rs         |  31 ++++++++-
 rust/kernel/sync/rcu/rcu_box.rs | 145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a067038b4b422b4256f4a2b75fe644d47e6e82c8..8d4b90383cd8d8ca7692586d13189b71c6dbab3e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -75,6 +75,7 @@
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b0eebdb93f2636cf10e177036a6a9..7234fe3e79ee920172c5094d2b0e46147e1d8313 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,16 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::{
+    bindings,
+    types::{
+        ForeignOwnable,
+        NotThreadSafe, //
+    }, //
+};
+
+mod rcu_box;
+pub use self::rcu_box::RcuBox;
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -50,3 +59,23 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Declares that a pointer type is rcu safe.
+pub trait ForeignOwnableRcu: ForeignOwnable {
+    /// Type used to immutably borrow an rcu-safe value that is currently foreign-owned.
+    type RcuBorrowed<'a>;
+
+    /// Borrows a foreign-owned object immutably for an rcu grace period.
+    ///
+    /// This method provides a way to access a foreign-owned rcu-safe value from Rust immutably.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must have been returned by a previous call to [`into_foreign`].
+    /// * If [`from_foreign`] is called, then `'a` must not end after the call to `from_foreign`
+    ///   plus one rcu grace period.
+    ///
+    /// [`into_foreign`]: ForeignOwnable::into_foreign
+    /// [`from_foreign`]: ForeignOwnable::from_foreign
+    unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed<'a>;
+}
diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_box.rs
new file mode 100644
index 0000000000000000000000000000000000000000..2508fdb609ecc12a85a1830a84f58ddaf962d1ec
--- /dev/null
+++ b/rust/kernel/sync/rcu/rcu_box.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Google LLC.
+
+//! Provides the `RcuBox` type for Rust allocations that live for a grace period.
+
+use core::{ops::Deref, ptr::NonNull};
+
+use kernel::{
+    alloc::{self, AllocError},
+    bindings,
+    ffi::c_void,
+    prelude::*,
+    sync::rcu::{ForeignOwnableRcu, Guard},
+    types::ForeignOwnable,
+};
+
+/// A box that is freed with rcu.
+///
+/// The value must be `Send`, as rcu may drop it on another thread.
+///
+/// # Invariants
+///
+/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allocated with `kmalloc`.
+/// * This `RcuBox` holds exclusive permissions to rcu free the allocation.
+pub struct RcuBox<T: Send>(NonNull<RcuBoxInner<T>>);
+
+struct RcuBoxInner<T> {
+    value: T,
+    rcu_head: bindings::callback_head,
+}
+
+// Note that `T: Sync` is required since when moving an `RcuBox<T>`, the previous owner may still
+// access `&T` for one grace period.
+//
+// SAFETY: Ownership of the `RcuBox<T>` allows for `&T` and dropping the `T`, so `T: Send + Sync`
+// implies `RcuBox<T>: Send`.
+unsafe impl<T: Send + Sync> Send for RcuBox<T> {}
+
+// SAFETY: `&RcuBox<T>` allows for no operations other than those permitted by `&T`, so `T: Sync`
+// implies `RcuBox<T>: Sync`.
+unsafe impl<T: Send + Sync> Sync for RcuBox<T> {}
+
+impl<T: Send> RcuBox<T> {
+    /// Create a new `RcuBox`.
+    pub fn new(x: T, flags: alloc::Flags) -> Result<Self, AllocError> {
+        let b = KBox::new(
+            RcuBoxInner {
+                value: x,
+                rcu_head: Default::default(),
+            },
+            flags,
+        )?;
+
+        // INVARIANT:
+        // * The pointer contains a valid `RcuBoxInner` allocated with `kmalloc`.
+        // * We just allocated it, so we own free permissions.
+        Ok(RcuBox(NonNull::from(KBox::leak(b))))
+    }
+
+    /// Access the value for a grace period.
+    pub fn with_rcu<'rcu>(&self, _read_guard: &'rcu Guard) -> &'rcu T {
+        // SAFETY: The `RcuBox` has not been dropped yet, so the value is valid for at least one
+        // grace period.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+impl<T: Send> Deref for RcuBox<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        // SAFETY: While the `RcuBox<T>` exists, the value remains valid.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+// SAFETY:
+// * The `RcuBoxInner<T>` was allocated with `kmalloc`.
+// * `NonNull::as_ptr` returns a non-null pointer.
+unsafe impl<T: Send + 'static> ForeignOwnable for RcuBox<T> {
+    const FOREIGN_ALIGN: usize = <KBox<RcuBoxInner<T>> as ForeignOwnable>::FOREIGN_ALIGN;
+
+    type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a T;
+
+    fn into_foreign(self) -> *mut c_void {
+        self.0.as_ptr().cast()
+    }
+
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
+        // INVARIANT: Pointer returned by `into_foreign` carries same invariants as `RcuBox<T>`.
+        // SAFETY: `into_foreign` never returns a null pointer.
+        Self(unsafe { NonNull::new_unchecked(ptr.cast()) })
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: Caller ensures that `'a` is short enough.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: `borrow_mut` has strictly stronger preconditions than `borrow`.
+        unsafe { Self::borrow(ptr) }
+    }
+}
+
+impl<T: Send + 'static> ForeignOwnableRcu for RcuBox<T> {
+    type RcuBorrowed<'a> = &'a T;
+
+    unsafe fn rcu_borrow<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: `RcuBox::drop` can only run after `from_foreign` is called, and the value is
+        // valid until `RcuBox::drop` plus one grace period.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+}
+
+impl<T: Send> Drop for RcuBox<T> {
+    fn drop(&mut self) {
+        // SAFETY: The `rcu_head` field is in-bounds of a valid allocation.
+        let rcu_head = unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
+        if core::mem::needs_drop::<T>() {
+            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All users will be
+            // gone in an rcu grace period. This is the destructor, so we may pass ownership of the
+            // allocation.
+            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T>)) };
+        } else {
+            // SAFETY: All users will be gone in an rcu grace period.
+            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
+        }
+    }
+}
+
+/// Free this `RcuBoxInner<T>`.
+///
+/// # Safety
+///
+/// `head` references the `rcu_head` field of an `RcuBoxInner<T>` that has no references to it.
+/// Ownership of the `KBox<RcuBoxInner<T>>` must be passed.
+unsafe extern "C" fn drop_rcu_box<T>(head: *mut bindings::callback_head) {
+    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `RcuBoxInner<T>`.
+    let box_inner = unsafe { crate::container_of!(head, RcuBoxInner<T>, rcu_head) };
+
+    // SAFETY: Caller ensures exclusive access and passed ownership.
+    drop(unsafe { KBox::from_raw(box_inner) });
+}

-- 
2.52.0.457.g6b5491de43-goog

