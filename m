Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF63D7D9E;
	Wed, 20 May 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283150; cv=none; b=eMqKeZx41VFKI/85BqPAOSw4jLlVabzXn625fd+oi6ZV4LcJ+s7TlE2hYjqbsxdF/QjT7qQY804XJpnskPuP2bvtv8dGqF8AZtw1Ys4nU+KVA7UhZkTtUCY5lYPlKZv4aROgVgM8cduYPL0HuFapFfw6uTNYgDapGrtdZKsxlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283150; c=relaxed/simple;
	bh=UIbk66JZvnzWXDB7MijFk7eDHSM1DsI/qulQVMtiqjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1M9DpIzjxLHiKciwJL7tGYK09XYvu9XbQm0CMhhWXpODUolD9SUDtnpo+aCzB79KMST2fxajjJYnZz5sH/mwa00D5EvPZkw2p8BL13ZU3917cDXrYQQcYvKYegvMxT6V1zL0AlbBL8FqZnjStGSPh86pBvuzbR8E54lHysmU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IypjKVq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IypjKVq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7451F000E9;
	Wed, 20 May 2026 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779283144;
	bh=VdeLf/yxTevduqKLpQNBEcZqKIVSslg1GB0Eg/Qsymw=;
	h=From:To:Cc:Subject:Date;
	b=IypjKVq2iTPjC++u/tcWmZ209OjL08I3bW+WzyaajYs4aVwIdgs9VVBpPrx0lTFzf
	 pcC3S/nv/PxGYvjNqPLEvfIZgi/such2Dj/QLOaHd+zX7Jkhk1+B7RggCW1Utlp5hn
	 uYXT9bH/tGDTUtuFLT3p2+Uf+wkPPGG2a4fDcnY/8PAQjISVVqlfXw057k5ai8fxgM
	 uYe73y/zMArbp+xD8Pt8dd5KyC1GSqLmROsQqt2cMgsUnUSPh8rrnkRKJdTZqZaXMa
	 zFc65Chb9uWljelh2/QIIISz45yBXj2/p9EQ9S6ltoH0i8cONA+kCkdPG+OQwkggFI
	 4zpD2vS7oiYRg==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>,
	Philipp Stanner <phasta@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tamir Duberstein <tamird@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
Date: Wed, 20 May 2026 15:17:26 +0200
Message-ID: <20260520131725.266014-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call_rcu() can be expected to be needed by a great variety of users.
This functionality is almost always used for deallocating resources
after all accessors are gone. Hence, it appears reasonable to implement
the abstractions in such a way that the user merely passes data, which
is later (after a grace period) dropped.

In the rare cases where the user needs special action to take place,
this could be achieved through implementing a custom drop() method.

Implement a first minimal abstraction for call_rcu().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/helpers/rcu.c      |  1 +
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 89 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
index 481274c05857..c9cfc99c93d5 100644
--- a/rust/helpers/rcu.c
+++ b/rust/helpers/rcu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/types.h> /* for callback_head */
 #include <linux/rcupdate.h>
 
 __rust_helper void rust_helper_rcu_read_lock(void)
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 993dbf2caa0e..1ddca3847b19 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -31,6 +31,7 @@
 pub use locked_by::LockedBy;
 pub use refcount::Refcount;
 pub use set_once::SetOnce;
+pub use rcu::Callback;
 
 /// Represents a lockdep class.
 ///
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..caf71fa46f5e 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,15 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::{
+    bindings,
+    prelude::*,
+    types::{
+        NotThreadSafe,
+        Opaque,
+    },
+    alloc::Flags,
+};
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -50,3 +58,82 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+
+/// An RCU callback object. Carries the user's data to drop() it once a grace period ellapsed.
+///
+/// This object serves to implement C's `call_rcu()` method. Since it is almost
+/// always used to free a resource once a grace period ellapsed, the only thing
+/// this implementation does is drop the user's data. In the rare cases in which
+/// the user needs more action to take place, said actions need to be implemented
+/// on the user's data via the [`Drop`] trait.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::rcu::Callback;
+///
+/// struct Foo {};
+///
+/// impl Drop for Foo {
+///     fn drop(&mut self) {
+///         pr_info!("rcu::Foo Dropping.\n");
+///     }
+/// }
+///
+/// let data = Foo {};
+///
+/// let cb = Callback::new(data, GFP_KERNEL)?;
+/// cb.submit();
+///
+/// Ok::<(), Error>(())
+/// ```
+#[repr(C)]
+#[pin_data]
+pub struct Callback<T: Send + 'static> {
+    /// The RCU head. Only used (and initialized) by the C backend.
+    #[pin]
+    inner: Opaque<bindings::callback_head>,
+    /// The user's data. This should implement [`Drop`] if the user wants specific
+    /// actions, besides mere deallocation, to happen.
+    #[pin]
+    data: T,
+}
+
+impl<T: Send + 'static> Callback<T> {
+    /// Create a new callback.
+    pub fn new(data: impl PinInit<T>, flags: Flags) -> Result<Pin<KBox<Self>>> {
+        let cb = try_pin_init!(Self {
+            inner: Opaque::uninit(), // Only needed for the C backend, who will initialize it.
+            data <- data,
+        });
+
+        KBox::pin_init(cb, flags)
+    }
+
+    extern "C" fn callback(rcu_head: *mut bindings::callback_head) {
+        let cb_ptr = rcu_head as *mut Self;
+
+        // SAFETY: All [`Callback`] objects in this module are always created
+        // as `Pin<KBox<Self>>`. `Pin` is a transparent container. The action
+        // below merely serves re-creating the KBox so that it can drop properly.
+        let _cb = unsafe { KBox::from_raw(cb_ptr) };
+
+        // Self::data drops, ensuring the desired cleanup operation.
+    }
+
+    fn as_raw(&self) -> *mut bindings::callback_head {
+        self.inner.get()
+    }
+
+    /// Arm a [`Callback`]. One grace period after this function was called,
+    /// the callback object will be dropped.
+    pub fn submit(self: Pin<KBox<Self>>) {
+        // SAFETY: The memory is not moved by this code or the C backend.
+        let cb = unsafe { Pin::into_inner_unchecked(self) };
+        let ptr = KBox::into_raw(cb);
+        // SAFETY: `ptr` was just created validly above. `Self::callback` relies
+        // on the RCU module / code never being unloaded.
+        unsafe { bindings::call_rcu((*ptr).as_raw(), Some(Self::callback)) };
+    }
+}
-- 
2.49.0

