Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67E44AB8D;
	Wed, 29 Jul 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318425; cv=none; b=pou79yFETa+AcSUvQ25DbTKfH9m0o2vFa8NZrCuukE4MwKTz6rM1JVUx/Wj8KGVUumOl0wn/HHLME4QoTl6sjVrr7qH4JHKULSMimd0vrIKI+rQOrfDWKuNaz6fVopGXiEnDxZuXdTjMSTBWziVa3PTlY7ksuc8cGVeHT8u+/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318425; c=relaxed/simple;
	bh=ut4EZNmKB0x3u3bEDLCqRsDyQfbzqSZglypmkeg8bkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcWmSh/rLD1LEjejj/8jTTPCu7hk7fWMIZsz0oF0pgAse5cE/4Rdgw3Uw+3Vx3JV7agKb91OTpvs5qXKS6U5NuVzy2kv8bj+81QoLm1pURl30FobB+lA2ltDJ3giea5i8aGusO25uNVW+IvBRx/JgP9Lpkv4Fgw7vJJ3jBC+awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIp5mmIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIp5mmIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D131F00A3A;
	Wed, 29 Jul 2026 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785318422;
	bh=el4es1Bl2ausTLKvYyel514yG1rQ4UereZP5l1izQWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIp5mmIh6kdljtWzFKb2d+p95xTkf19cNaNYpG6r8qbAEfYLldi0yZdE71B7lCAPR
	 H3w6zyY+zFGkhKrnkDLzjQcgvgnZhjf+RPgZxTiNTjBQnDlWcaK7TM2nWqYwY/wK6S
	 01i8qc6cvGJuClywH8KItz2PdTqEthD35KDKHPCmsbN3K8K2Wuppz4qz44MWkdujaT
	 EXffsSAU9DkaWETO92UvdBOq859oe8FFOVS4QkWk9uprMdH6oQDXEYEBfVrQeQOgZs
	 Ap2q9gppsHrZrOfczQmL93JHs8u/Z+CZkHxAWAbOb8WPr8Gd2dBgKUvYVGLjt4Lx1U
	 9wp6yI0ib3V5Q==
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Burak Emir <bqe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org
Subject: [PATCH v7 4/5] rust: Add dma_fence abstractions
Date: Wed, 29 Jul 2026 11:45:41 +0200
Message-ID: <20260729094542.302965-6-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729094542.302965-2-phasta@kernel.org>
References: <20260729094542.302965-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

C's dma_fence's are synchronisation primitives that will be needed by all
Rust GPU drivers.

The dma_fence framework sets a number of rules, notably:
  - fences must only be signaled once
  - all fences must be signaled at some point
  - fence error codes must only be set before signaling
  - every pointer to a fence must be backed by a reference

All those rules are being addressed by these abstractions.

To cleanly decouple fence issuers and consumers, two types are provided:
  - DriverFence: the only fence type that can be signaled and that
    carries driver-specific data.
  - Fence: the fence type to be shared with other drivers and / or
    userspace. The only type callbacks can be registered on.
    Cannot be signaled.

Hereby, a Fence lives in the same chunk of memory as a DriverFence. Both
share the refcount of the underlying C dma_fence. Since this
implementation does not provide a custom dma_fence_backend_ops.release()
function, the memory is freed by the dma_fence backend once the refcount
drops to 0.

To create a DriverFence, the user must first allocate a
DriverFenceAllocation, so that the creation of the DriverFence later on
can always succeed. Otherwise, deadlocks could occur if fences need to
be created in a GPU job submission path.

Synchronization is ensured by the dma_fence backend.

All DriverFence's created through this abstraction must be signaled by
the creator with an error code. In case a DriverFence drops without
being signaled beforehand, it is signaled with -ECANCELLED as its
error and a warning is printed. This allows the Rust abstraction to very
cleanly decouple fence issuer and consumer by relying on the decoupling
mechanisms in the C backend, which ensures through RCU and the
'signaled' fence-flag that dma_fence_backend_ops functions cannot
access the potentially unloaded driver code anymore.

Signalling fences on drop thus grants many advantages. Not signaling
fences on drop would risk deadlock and does not grant real advantages:
By definition only the drivers can ensure that a fence always represents
the hardware's state correctly.

This implementation models a DmaFenceContext object on which fences are
to be created, thereby ensuring correct sequence numbering according to
the timeline.

dma_fence supports a variety of callbacks. The mandatory callbacks
(get_timeline_name() and get_driver_name()) are implemented in this
patch. For convenience, they store those name parameters in the fence
context, saving the driver from implementing these two callbacks.

Support for other callbacks (like for hardware signaling) is prepared
for through the fact that both DriverFence and Fence live in the same
allocation, allowing for usage of container_of from the callback to
access the driver-specific data.

It is expected that other callbacks, added in the future, also mostly
operate on the generic data in the FenceContext. To make this safe, the
implementation ensures through a lifetime that a DriverFence cannot
outlive its FenceContext. Since this can, currently, not be fully
guaranteed (core::mem::forget() could make the compiler forget about the
memory) in Rust, an additional safety measure is implemented: the
FenceContext keeps track of all unsignaled fences, and should it ever
drop with such a fence present, it will signal it, ensuring full
decoupling.

Synchronization for dma_fence_ops callbacks is ensured by only running the
Rust deconstructor delayed with call_rcu(), which prevents UAF-bugs
should a DriverFence drop while a Fence callback is currently operating
on the associated driver data. Since they can also operate on the
FenceContext's data, its drop implementation also performs the necessary
delay with rcu_barrier().

An additional issue discovered during the review process of this code is
that there is (currently) no mechanism in Rust from circumventing the
DriverFence's lifetime on the FenceContext by "forgetting" the fence,
e.g. with core::mem::forget(). Since this apparently can also happen
with recfounting cycles, it's quite likely that it would enable UAF bugs
on the FenceContext. To make this absolutely water proof, the
FenceContext keeps track of unsignaled fences and signals those should
the context drop before some fences.

Add abstractions for dma_fence in Rust.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/bindings/bindings_helper.h  |    1 +
 rust/helpers/dma_fence.c         |   48 ++
 rust/helpers/helpers.c           |    1 +
 rust/kernel/dma_buf/dma_fence.rs | 1111 ++++++++++++++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       |   14 +
 rust/kernel/lib.rs               |    1 +
 6 files changed, 1176 insertions(+)
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..54b62d952e01 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -53,6 +53,7 @@
 #include <linux/debugfs.h>
 #include <linux/device/faux.h>
 #include <linux/dma-direction.h>
+#include <linux/dma-fence.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-resv.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/dma_fence.c b/rust/helpers/dma_fence.c
new file mode 100644
index 000000000000..0e08411098fa
--- /dev/null
+++ b/rust/helpers/dma_fence.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-fence.h>
+
+__rust_helper void rust_helper_dma_fence_get(struct dma_fence *f)
+{
+	dma_fence_get(f);
+}
+
+__rust_helper void rust_helper_dma_fence_put(struct dma_fence *f)
+{
+	dma_fence_put(f);
+}
+
+__rust_helper bool rust_helper_dma_fence_begin_signalling(void)
+{
+	return dma_fence_begin_signalling();
+}
+
+__rust_helper void rust_helper_dma_fence_end_signalling(bool cookie)
+{
+	dma_fence_end_signalling(cookie);
+}
+
+__rust_helper bool rust_helper_dma_fence_is_signaled(struct dma_fence *f)
+{
+	return dma_fence_is_signaled(f);
+}
+
+__rust_helper bool rust_helper_dma_fence_test_signaled_flag(struct dma_fence *f)
+{
+	return dma_fence_test_signaled_flag(f);
+}
+
+__rust_helper void rust_helper_dma_fence_lock_irqsave(struct dma_fence *f, unsigned long *flags)
+{
+	dma_fence_lock_irqsave(f, *flags);
+}
+
+__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fence *f, unsigned long *flags)
+{
+	dma_fence_unlock_irqrestore(f, *flags);
+}
+
+__rust_helper void rust_helper_dma_fence_set_error(struct dma_fence *f, int error)
+{
+	dma_fence_set_error(f, error);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e66..4ab8aa9da7e7 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -58,6 +58,7 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#include "dma_fence.c"
 #include "dma-resv.c"
 #include "drm.c"
 #include "drm_gpuvm.c"
diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
new file mode 100644
index 000000000000..c33cc8d40e94
--- /dev/null
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -0,0 +1,1111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2025, 2026 Red Hat Inc.:
+ *   Author: Philipp Stanner <pstanner@redhat.com>
+ */
+
+//! DriverFence support.
+//!
+//! Reference: <https://docs.kernel.org/driver-api/dma-buf.html#c.dma_fence>
+//!
+//! header: [`include/linux/dma-fence.h`](srctree/include/linux/dma-fence.h)
+
+use crate::{
+    alloc::AllocError,
+    bindings,
+    container_of,
+    error::to_result,
+    prelude::*,
+    types::ForeignOwnable,
+    types::Opaque,
+    warn_on, //
+};
+
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr,
+    ptr::{
+        drop_in_place,
+        NonNull, //
+    }, //
+};
+
+use kernel::{
+    list::*,
+    str::CString,
+    sync::{
+        aref::{
+            ARef,
+            AlwaysRefCounted, //
+        },
+        atomic::{
+            Atomic,
+            Relaxed, //
+        },
+        new_spinlock,
+        rcu::rcu_barrier,
+        Arc,
+        SpinLock, //
+    }, //
+};
+
+/// Helper for enlisting fences into a [`FenceContext`] so that the fence context
+/// can signal fences as a last resort.
+#[pin_data]
+struct FenceLastResortSignaler {
+    fence: Option<ARef<Fence>>,
+    #[pin]
+    links: ListLinks,
+}
+
+impl FenceLastResortSignaler {
+    fn alloc() -> Result<ListArc<Self>> {
+        ListArc::pin_init(
+            try_pin_init!(Self {
+                fence: None,
+                links <- ListLinks::new(),
+            }),
+            GFP_KERNEL,
+        )
+    }
+}
+
+impl_list_arc_safe! {
+    impl ListArcSafe<0> for FenceLastResortSignaler { untracked; }
+}
+
+impl_list_item! {
+    impl ListItem<0> for FenceLastResortSignaler { using ListLinks { self.links }; }
+}
+
+/// VTable for dma_fence backend_ops callbacks.
+//
+// Mandatory dma_fence backend_ops are implemented implicitly through
+// [`FenceContext`]. Additional ones shall get implemented on this trait, which
+// then shall be demanded for the fence context data.
+pub trait FenceContextOps {
+    /// The generic payload data for [`DriverFence`]s created on this fctx.
+    type FenceDataType: Send + Sync;
+}
+
+/// A dma-fence context. A fence context takes care of associating related fences
+/// with each other, providing each with raising sequence numbers and a common
+/// identifier.
+#[pin_data(PinnedDrop)]
+pub struct FenceContext<T: FenceContextOps + Send + Sync> {
+    /// The fence context number.
+    nr: u64,
+    /// The sequence number for the next fence created.
+    seqno: Atomic<u64>,
+    // The name parameters can be accessed by the dma_fence backend_ops. UAF
+    // errors are prevented by the `call_rcu()` in `drop_driver_fence_data()`.
+    /// The name of the driver this FenceContext's fences belong to.
+    driver_name: CString,
+    /// The name of the timeline this FenceContext's fences belong to.
+    timeline_name: CString,
+    /// A list of all unsignaled fences of this context.
+    // As an additional safety-measure, the fence context will signal all fences
+    // that were not yet signaled when it drops.
+    //
+    // The life-time on `DriverFence`s should typically prevent this from
+    // happening.
+    //
+    // However, we cannot fully guarantee in Rust that `DriverFence`s will not
+    // be forgotten, e.g., through refcounting. This could circumvent the
+    // lifetime which intends to enforce that all fences disappear before their
+    // context.
+    //
+    // Safety can still be ensured, though, by keeping track of unsignaled fences
+    // and signalling those manually when the context drops.
+    #[pin]
+    fences: SpinLock<List<FenceLastResortSignaler>>,
+    /// The user's data.
+    #[pin]
+    data: T,
+}
+
+impl<'a, T: Send + Sync + FenceContextOps> FenceContext<T> {
+    // This can later be extended as a vtable in case other parties need support
+    // for the more "exotic" callbacks.
+    const OPS: bindings::dma_fence_ops = bindings::dma_fence_ops {
+        get_driver_name: Some(Self::get_driver_name),
+        get_timeline_name: Some(Self::get_timeline_name),
+        enable_signaling: None,
+        signaled: None,
+        wait: None,
+        release: None,
+        set_deadline: None,
+    };
+
+    /// Create a new `FenceContext`.
+    pub fn new<E>(
+        initial_seqno: u64,
+        driver_name: CString,
+        timeline_name: CString,
+        data: impl PinInit<T, E>,
+    ) -> impl PinInit<Self, Error>
+    where
+        Error: From<E>,
+    {
+        try_pin_init!(Self {
+            // SAFETY: `dma_fence_context_alloc()` merely works on a global
+            // atomic. Parameter `1` is the number of contexts we want to
+            // allocate.
+            nr: unsafe { bindings::dma_fence_context_alloc(1) },
+            seqno: Atomic::new(initial_seqno),
+            driver_name,
+            timeline_name,
+            fences <- new_spinlock!(List::<FenceLastResortSignaler>::new()),
+            data <- data,
+        })
+    }
+
+    fn get_next_seqno(&self) -> u64 {
+        self.seqno.fetch_add(1, Relaxed)
+    }
+
+    /// Allocate the memory for a [`DriverFence`] and already store `data` inside.
+    ///
+    /// This is needed because many times, creation of a [`DriverFence`] must not
+    /// fail, and allocating might deadlock in some situations.
+    ///
+    /// The `data` you pass here must not perform any operations that are illegal
+    /// in atomic context in its [`Drop`] implementation.
+    // Mutable so that the unlikely issue of seqno misordering gets impossible.
+    pub fn fence_alloc(&self, data: T::FenceDataType) -> Result<DriverFenceAllocation<'_, T>> {
+        let fence_data = DriverFenceData {
+            rcu_head: Default::default(),
+            // `inner` remains uninitialized until a [`DriverFence`] takes over.
+            inner: Fence {
+                inner: Opaque::uninit(),
+            },
+            fctx: self,
+            data,
+        };
+
+        // In order to support the C dma_fence callbacks, it is necessary for
+        // a `Fence` and a `DriverFence` to live in the same allocation,
+        // because the C backend passes a dma_fence, from which the driver most
+        // likely wants to be able to access its `data` in `DriverFence`.
+        //
+        // Hence, we need the manage the memory manually. It will be freed by the
+        // C backend automatically once the refcount within `Fence` drops to 0.
+        let data = KBox::new(fence_data, GFP_KERNEL | __GFP_ZERO)?;
+        let signaler = FenceLastResortSignaler::alloc()?;
+
+        Ok(DriverFenceAllocation {
+            data,
+            signaler,
+            ops: &Self::OPS,
+        })
+    }
+
+    extern "C" fn get_driver_name(ptr: *mut bindings::dma_fence) -> *const c_char {
+        // SAFETY: The C backend only invokes this callback with `ptr` pointing
+        // to a valid, unsignaled `bindings::dma_fence`. All fences created in
+        // this module always reside within `Fence` which always resides in a
+        // `DriverFenceData`, thus satisfying the function's safety
+        // requirements.
+        let fctx = unsafe { Self::from_raw_fence(ptr) };
+
+        fctx.driver_name.as_char_ptr()
+    }
+
+    extern "C" fn get_timeline_name(ptr: *mut bindings::dma_fence) -> *const c_char {
+        // SAFETY: The C backend only invokes this callback with `ptr` pointing
+        // to a valid, unsignaled `bindings::dma_fence`. All fences created in
+        // this module always reside within `Fence` which always resides in a
+        // `DriverFenceData`, thus satisfying the function's safety
+        // requirements.
+        let fctx = unsafe { Self::from_raw_fence(ptr) };
+
+        fctx.timeline_name.as_char_ptr()
+    }
+
+    /// Create a [`FenceContext`] from an associated [`bindings::dma_fence`].
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a [`bindings::dma_fence`] which resides
+    /// within a [`Fence`], which in turn resides in a [`DriverFenceData`].
+    unsafe fn from_raw_fence(ptr: *mut bindings::dma_fence) -> &'a Self {
+        let opaque_fence = Opaque::cast_from(ptr);
+
+        // SAFETY: Safe due to the function's overall safety requirements.
+        let fence_ptr = unsafe { container_of!(opaque_fence, Fence, inner) };
+
+        // CAST: `DriverFenceData` is repr(C) and a `Fence` is its first member.
+        let fence_data_ptr = fence_ptr as *mut DriverFenceData<'a, T>;
+
+        // SAFETY: Safe because of the comments directly above.
+        let fence_data = unsafe { &*fence_data_ptr };
+
+        fence_data.fctx
+    }
+}
+
+// FenceContext's drop() ensures that the driver cannot unload while there are
+// still dma_fence callbacks running. This also prevents UAF problems with
+// `fctx.driver_name` and `fctx.timeline_name`.
+//
+// DriverFence data gets dropped through call_rcu() in DriverFence::drop.
+// This `rcu_barrier()` also serves to wait for their completion.
+#[pinned_drop]
+impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<T> {
+    fn drop(self: Pin<&mut Self>) {
+        let mut guard = self.fences.lock();
+        let mut cursor = guard.cursor_front();
+
+        while let Some(pos) = cursor.peek_next() {
+            let list_arc = pos.remove();
+            let mut signaler =
+                Arc::<FenceLastResortSignaler>::into_unique_or_drop(list_arc.into_arc()).unwrap();
+
+            // All fences in this list are always set. Unwrap.
+            let fence = signaler.as_mut().project().fence.take().unwrap();
+            let fence = fence.lock();
+
+            // SAFETY: We still hold a reference, thus the pointer is valid.
+            let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(*fence.deref()) };
+            if !signaled {
+                // SAFETY: We still hold a reference, thus the pointer is
+                // valid. The fence must not have been signaled yet, which we
+                // check directly above. The lock must be held, which we
+                // acquired above.
+                unsafe { bindings::dma_fence_set_error(*fence.deref(), ECANCELED.to_errno()) };
+                // SAFETY: We still hold a reference, thus the pointer is
+                // valid. The lock must be held, which we acquired above.
+                unsafe { bindings::dma_fence_signal_locked(*fence.deref()) };
+            } else {
+                pr_warn!("Signaled Fences in FenceContext.");
+            }
+        }
+
+        drop(guard);
+        rcu_barrier();
+    }
+}
+
+/// Error type for fence callback registration.
+///
+/// Generic over `T` so that `AlreadySignaled` can return the callback to the
+/// caller, allowing it to reclaim any resources owned by the callback (e.g.,
+/// a fence handle that needs to be signaled).
+#[derive(Debug)]
+pub enum CallbackError<T = ()> {
+    /// The fence was already signaled. The callback is returned so the caller
+    /// can extract owned resources without losing them.
+    AlreadySignaled(T),
+    /// Some other error occurred during registration.
+    Other(Error),
+}
+
+impl<T> From<CallbackError<T>> for Error {
+    fn from(err: CallbackError<T>) -> Self {
+        match err {
+            CallbackError::AlreadySignaled(_) => ENOENT,
+            CallbackError::Other(e) => e,
+        }
+    }
+}
+
+impl<T> From<AllocError> for CallbackError<T> {
+    fn from(e: AllocError) -> Self {
+        CallbackError::Other(Error::from(e))
+    }
+}
+
+/// Trait for callbacks that can be registered on fences.
+///
+/// When the fence signals, the callback will be invoked.
+///
+/// # Example
+///
+/// ```rust
+/// use kernel::dma_buf::FenceCallback;
+///
+/// struct MyCallback {
+///     // Your callback state here
+/// }
+///
+/// impl FenceCallback for MyCallback {
+///     fn called(&mut self) {
+///         pr_info!("Fence signaled!");
+///         // Handle fence completion
+///     }
+/// }
+/// ```
+pub trait FenceCallback: Send + 'static {
+    /// Called when the fence is signaled.
+    ///
+    /// This is called from the fence signaling path, which may be in interrupt
+    /// context or with locks held, which is why `self` is only borrowed, so that
+    /// it cannot drop. Implementations must not sleep or perform
+    /// long-running operations.
+    ///
+    /// An implementation likely wants to inform itself (e.g., through a work item)
+    /// within this callback that the associated [`FenceCallbackRegistration`]
+    /// can now be dropped.
+    fn called(&mut self);
+}
+
+/// A callback registration on a fence.
+///
+/// When this object is dropped, the callback is automatically removed if it
+/// hasn't been called yet.
+#[pin_data(PinnedDrop)]
+pub struct FenceCallbackRegistration<T: FenceCallback + 'static> {
+    #[pin]
+    callback_foreign: Opaque<bindings::dma_fence_cb>,
+    callback: ManuallyDrop<T>,
+    fence: ARef<Fence>,
+}
+
+impl<T: FenceCallback> FenceCallbackRegistration<T> {
+    /// Create a [`PinInit`] closure for registering a callback on a fence.
+    ///
+    /// The actual attempt at registering the callback will take place once you
+    /// call an allocator's `pin_init()` function.
+    ///
+    /// On success the callback is pinned in place and will fire when the fence
+    /// signals. On `AlreadySignaled` the callback is returned to the caller so
+    /// that owned resources can be reclaimed.
+    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, CallbackError<T>> + 'a
+    where
+        T: 'a,
+    {
+        try_pin_init!(Self {
+            // We need to fully initialize the fence because after
+            // `dma_fence_add_callback()` ran, the callback might immediately
+            // get invoked.
+            callback: ManuallyDrop::new(callback),
+            fence: ARef::from(fence),
+            callback_foreign <- Opaque::try_ffi_init(|ptr| {
+                // SAFETY: `fence.inner.get()` is a valid, initialized `struct
+                // dma_fence`. `ptr` points to the `struct dma_fence_cb` field
+                // within the pinned allocation, so it remains valid until
+                // `dma_fence_remove_callback()` in `PinnedDrop` or until the
+                // callback fires.
+                let ret = unsafe {
+                    to_result(bindings::dma_fence_add_callback(
+                        fence.inner.get(),
+                        ptr,
+                        Some(Self::dma_fence_callback),
+                    ))
+                };
+                match ret {
+                    Ok(()) => Ok(()),
+                    Err(e) => {
+                        // SAFETY: We could not register the callback. Thus,
+                        // C will not use it. So we can just take it back
+                        // and pass it to the user again.
+                        let cb_back = unsafe { ManuallyDrop::take(callback) };
+                        if e == ENOENT {
+                            Err(CallbackError::AlreadySignaled(cb_back))
+                        } else {
+                            Err(CallbackError::Other(e))
+                        }
+                    },
+                }
+            }),
+        }? CallbackError<T>)
+    }
+
+    /// Raw dma fence callback that is called by the C code.
+    ///
+    /// # Safety
+    ///
+    /// This is only called by the dma_fence subsystem with valid pointers.
+    unsafe extern "C" fn dma_fence_callback(
+        _fence: *mut bindings::dma_fence,
+        callback_foreign: *mut bindings::dma_fence_cb,
+    ) {
+        let ptr = Opaque::cast_from(callback_foreign).cast_mut();
+
+        // SAFETY: All `cb` we can receive here have been created in such a way
+        // that they are embedded into a `FenceCallbackRegistration`. The
+        // backend ensures synchronisation so whoever holds the registration
+        // object cannot drop it while this code is running. See
+        // `FenceCallbackRegistration::drop`.
+        unsafe {
+            let reg: *mut Self = container_of!(ptr, Self, callback_foreign);
+
+            (*reg).callback.called();
+        }
+    }
+
+    /// Returns a reference to the fence this callback is registered on.
+    pub fn fence(self: Pin<&Self>) -> &Fence {
+        &self.get_ref().fence
+    }
+}
+
+#[pinned_drop]
+impl<T: FenceCallback> PinnedDrop for FenceCallbackRegistration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Always call dma_fence_remove_callback, even if `callback` has already
+        // been taken by `dma_fence_callback`.  This is necessary for
+        // synchronization: `dma_fence_remove_callback` acquires `fence->lock`,
+        // which ensures that any in-flight `dma_fence_signal` (which calls our
+        // callback while holding the same lock) has completed before we free
+        // the struct.
+        //
+        // Without this, Drop can race with a concurrent signal:
+        //   CPU0 (signal, lock held): take() -> signaled(fence_ref) (in progress)
+        //   CPU1 (drop): sees is_some()==false -> skips lock -> frees struct
+        //   CPU0: accesses fence_ref -> use-after-free
+        //
+        // When the callback has already fired, the signal path detached the
+        // list node via INIT_LIST_HEAD, so dma_fence_remove_callback just sees
+        // an empty node and returns false — the lock acquisition is the only
+        // thing that matters.
+        //
+        // SAFETY: The fence pointer is valid and the cb was initialized by
+        // dma_fence_add_callback during construction.
+        unsafe {
+            bindings::dma_fence_remove_callback(self.fence.as_raw(), self.callback_foreign.get());
+        }
+
+        // SAFETY: This is literally the drop implementation, so no one has
+        // dropped this so far; so we can do it now.
+        unsafe { ManuallyDrop::<T>::drop(self.project().callback) };
+    }
+}
+
+// SAFETY: FenceCallbackRegistration can be sent between threads.
+unsafe impl<T: FenceCallback> Send for FenceCallbackRegistration<T> {}
+
+// SAFETY: &FenceCallbackRegistration can be shared between threads if &T can.
+unsafe impl<T: FenceCallback> Sync for FenceCallbackRegistration<T> where T: Sync {}
+
+/// The receiving counterpart of a [`DriverFence`].
+///
+/// The Rust DMA fence implementation has a dualistic design: [`DriverFence`]s
+/// are the producer-side, intended to be always owned by only one party. That
+/// party has the monopoly on signalling the fence.
+///
+/// A [`Fence`] is the counterpart for consumers. Thus, [`Fence`]s are always
+/// refcounted and can shared with an arbitrary number of parties, including
+/// userspace. Hereby, a [`Fence`] can only be used for actions such as checking
+/// the fence's status or for registering callbacks on it.
+///
+/// Once the associated [`DriverFence`] signals, all
+/// [`FenceCallbackRegistration`]s registered on the [`Fence`] will be executed.
+///
+/// A [`Fence`] can arbitrarily outlive its [`DriverFence`] and the
+/// [`FenceContext`]. Signalling a [`DriverFence`] decouples it from its
+/// [`Fence`]s.
+#[repr(transparent)]
+pub struct Fence {
+    /// The actual dma_fence passed to C.
+    inner: Opaque<bindings::dma_fence>,
+}
+
+/// Guard helper for locking within this module.
+struct FenceGuard {
+    inner: *mut bindings::dma_fence,
+    flags: usize,
+}
+
+impl Deref for FenceGuard {
+    type Target = *mut bindings::dma_fence;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+impl Drop for FenceGuard {
+    fn drop(&mut self) {
+        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` is
+        // merely a pointer to an integer, which lives as long as this function.
+        // When a `FenceGuard` exists, the lock has been taken by definition.
+        unsafe { bindings::dma_fence_unlock_irqrestore(self.inner, &raw mut self.flags) };
+    }
+}
+
+// SAFETY: Fences are literally designed to be shared between threads.
+unsafe impl Send for Fence {}
+// SAFETY: Fences are literally designed to be shared between threads.
+unsafe impl Sync for Fence {}
+
+impl Fence {
+    /// Check whether the fence was signaled at the moment of the function call.
+    ///
+    /// Note that this can return `true` for a [`Fence`] whose [`DriverFence`]
+    /// has not yet been dropped. The reason is that the fence ops callbacks can
+    /// cause the fence to get signaled by the C backend.
+    pub fn is_signaled(&self) -> bool {
+        // We should not use `dma_fence_is_signaled_locked()` here, because
+        // according to the C backend's recommendations, that function is
+        // problematic and we should avoid calling that function with a lock
+        // held.
+
+        // SAFETY: `fence` stems from `self`, which is valid by definition.
+        let ret = unsafe { bindings::dma_fence_is_signaled(self.as_raw()) };
+
+        // To be as robust as possible for the future we guarantee that an API
+        // caller can 100% rely on the signalling being completed (i.e., all
+        // fence callbacks ran), so we have to take the lock.
+        //
+        // The reason is that the C dma_fence backend currently does not
+        // carefully synchronize the `dma_fence_is_signaled()` function with the
+        // proper spinlock. This can lead to the function returning `true` while
+        // fence callbacks are still being executed. This can be mitigated by
+        // guarding the entire function with the spinlock.
+        //
+        // The fundamental reason is that the C backend currently does guard
+        // setting of the fence's signaled-bit with the fence's spinlock, but
+        // reading is done locklessly.
+        //
+        // See commit c8a5d5ea3ba6a.
+
+        let _ = self.lock();
+
+        ret
+    }
+
+    fn lock(&self) -> FenceGuard {
+        let mut guard = FenceGuard {
+            inner: self.as_raw(),
+            flags: 0,
+        };
+
+        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` is
+        // merely a pointer to an integer, which lives as long as this function.
+        unsafe { bindings::dma_fence_lock_irqsave(guard.inner, &raw mut guard.flags) };
+
+        guard
+    }
+
+    /// Get the fence's sequence number.
+    pub fn get_seqno(&self) -> u64 {
+        // SAFETY: Valid because `self` is valid.
+        unsafe { (*self.as_raw()).seqno }
+    }
+
+    fn as_raw(&self) -> *mut bindings::dma_fence {
+        self.inner.get()
+    }
+
+    /// Create a [`Fence`] from a raw C [`bindings::dma_fence`].
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an initialized fence that is embedded into a [`Fence`].
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::dma_fence) -> &'a Self {
+        // SAFETY: Safe as per the function's overall safety requirements.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: These implement the C backends refcounting methods which are proven
+// to work correctly.
+unsafe impl AlwaysRefCounted for Fence {
+    fn inc_ref(&self) {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct dma_fence`.
+        unsafe { bindings::dma_fence_get(self.as_raw()) }
+    }
+
+    /// # Safety
+    ///
+    /// `ptr`must be a valid pointer to a [`DriverFence`].
+    unsafe fn dec_ref(ptr: NonNull<Self>) {
+        // SAFETY: `ptr` is never a NULL pointer; and when `dec_ref()` is called
+        // the fence is by definition still valid.
+        let fence = unsafe { (*ptr.as_ptr()).inner.get() };
+
+        // SAFETY: `fence` was created validly above. When `dec_ref()` is called,
+        // there is by definition still a reference alive that can be put.
+        unsafe { bindings::dma_fence_put(fence) }
+    }
+}
+
+// Necessary to guarantee that `inner` always comes first and can be freed by C.
+// Also useful for using casts instead of container_of().
+#[repr(C)]
+#[pin_data]
+struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
+    #[pin]
+    /// The inner fence.
+    // Must always be the first member so that unsafe casting works; but also
+    // necessary so that the C backend can free the allocation (coming from our
+    // Rust code) with kfree_rcu().
+    inner: Fence,
+    /// Callback head for dropping this in a deferred manner through RCU.
+    rcu_head: bindings::callback_head,
+    /// Reference to access the FenceContext. Useful for obtaining name parameters.
+    fctx: &'a FenceContext<T>,
+    /// The API user's data. This must either not need drop, or must delay its
+    /// drop by a grace period. It is essential that the data only performs
+    /// operations legal in atomic context in its [`Drop`] implementation.
+    #[pin]
+    data: T::FenceDataType,
+}
+
+/// A synchronization primitive mainly for GPU drivers.
+///
+/// The Rust DMA fence implementation has a dualistic design: [`DriverFence`]s
+/// are the producer-side, intended to be always owned by only one party. That
+/// party has the monopoly on signalling the fence.
+///
+/// A [`Fence`] is the counterpart for consumers. Thus, [`Fence`]s are always
+/// refcounted and can shared with an arbitrary number of parties, including
+/// userspace. Hereby, a [`Fence`] can only be used for actions such as checking
+/// the fence's status or for registering callbacks on it.
+///
+/// Once the associated [`DriverFence`] signals, all
+/// [`FenceCallbackRegistration`]s registered on a [`Fence`] will be executed.
+///
+/// A [`Fence`] can arbitrarily outlive its [`DriverFence`] and the
+/// [`FenceContext`]. Signalling a [`DriverFence`] decouples it from its
+/// [`Fence`]s.
+///
+/// It is crucial that a [`DriverFence`] always correctly represents the state
+/// of the associated job on the hardware. Especially, it is strictly necessary
+/// that the owner ensures that all [`DriverFence`]s get eventually signaled.
+/// As a last ressort, a [`DriverFence`] will signal itself if it drops
+/// unsignaled.
+///
+/// This design intends to implement the [`bindings::dma_fence_ops`] in such a
+/// way that the driver-data necessary to implement the callback's functionality
+/// resides in the [`FenceContext`]. Thus, a [`DriverFence`] contains a
+/// reference to the context, which can be accessed in the callbacks. The
+/// implementation, therefore, ensures that a [`DriverFence`] cannot outlive its
+/// [`FenceContext`]. Unfortunately, this can be circumvented under certain
+/// circumstances in Rust. To mitigate this, the [`FenceContext`] will signal
+/// all unsignaled [`DriverFence`]s in the unlikely case of it dropping before
+/// the last fence.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::dma_buf::{
+///     DriverFence,
+///     FenceContext,
+///     FenceContextOps,
+///     FenceCallback,
+///     FenceCallbackRegistration, //
+/// };
+/// use kernel::str::CString;
+/// use kernel::sync::aref::ARef;
+/// use core::fmt::Display;
+///
+/// struct CallbackData { }
+///
+/// impl FenceCallback for CallbackData {
+///     fn called(&mut self) {
+///         pr_info!("DmaFence callback executed.\n");
+///     }
+/// }
+///
+/// #[pin_data]
+/// struct FenceContextData {}
+///
+/// impl FenceContextData {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {})
+///     }
+/// }
+///
+/// impl FenceContextOps for FenceContextData {
+///     type FenceDataType = FenceData;
+/// }
+///
+/// let fctx_data = FenceContextData::new();
+///
+/// let driver_name = CString::try_from_fmt(fmt!("dummy_driver"))?;
+/// let timeline_name = CString::try_from_fmt(fmt!("dummy_timeline"))?;
+///
+/// let mut fctx = KBox::pin_init(FenceContext::new(0, driver_name, timeline_name, fctx_data), GFP_KERNEL)?;
+///
+/// struct FenceData {
+///     data: CString,
+/// }
+///
+/// let data = CString::try_from_fmt(fmt!("dummy_data"))?;
+/// let fence_data = FenceData { data };
+///
+/// let fence_alloc = fctx.fence_alloc(fence_data)?;
+/// let mut fence = fence_alloc.new_fence();
+///
+/// let cb_data = CallbackData { };
+/// let waiting_fence = ARef::from(fence.as_fence());
+/// let cb_reg = FenceCallbackRegistration::new(&waiting_fence, cb_data);
+/// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
+///
+/// // TODO signalling guards
+/// fence.signal(Ok(()));
+/// assert_eq!(waiting_fence.is_signaled(), true);
+///
+/// Ok::<(), Error>(())
+/// ```
+pub struct DriverFence<'a, T: Send + Sync + FenceContextOps> {
+    /// The actual content of the fence. Lives in a [`NonNull`] so that its
+    /// memory can be managed independently. Valid until both the [`DriverFence`]
+    /// and all associated [`Fence`]s have disappeared.
+    data: NonNull<DriverFenceData<'a, T>>,
+}
+
+/// A pre-prepared DMA fence, carrying the user's data and the memory it and the
+/// fence reside in. Only useful for creating a [`DriverFence`]. Splitting
+/// allocation and full initialization is necessary because fences cannot be
+/// allocated dynamically in some circumstances (deadlock).
+pub struct DriverFenceAllocation<'a, T: Send + Sync + FenceContextOps> {
+    /// The memory for the actual content of the fence.
+    /// Handed over to a [`DriverFence`], or deallocated once the
+    /// [`DriverFenceAllocation`] drops.
+    data: KBox<DriverFenceData<'a, T>>,
+    /// Pointer for the ops for the associated [`FenceContext`]
+    ops: *const bindings::dma_fence_ops,
+    /// Pre-allocated last ressort signaler to absolutely prevent unsignaled fences.
+    signaler: ListArc<FenceLastResortSignaler>,
+}
+
+impl<'a, T: Send + Sync + FenceContextOps> DriverFenceAllocation<'a, T> {
+    /// Create a new fence, consuming `data`.
+    ///
+    /// This increments the sequence number in the associated [`FenceContext`].
+    pub fn new_fence(self) -> DriverFence<'a, T> {
+        // We feed the C dma_fence backend a NULL for the spinlock so that it
+        // uses per-fence locks automatically.
+        let null_ptr: *mut bindings::spinlock = ptr::null_mut();
+        let seqno = self.data.fctx.get_next_seqno();
+        let fence_ptr = self.as_raw();
+        // SAFETY: `fence_ptr` has been created directly above. It will live
+        // at least as long as `Self`. The same applies to `&Self::OPS`.
+        unsafe {
+            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
+        };
+
+        let fence = ARef::from(&self.data.inner);
+
+        // A list element's are always refcounted, which forces us to establish
+        // that no one else is holding a reference. This element is in no list
+        // yet, so we can unwrap.
+        let mut signaler =
+            Arc::<FenceLastResortSignaler>::into_unique_or_drop(self.signaler.into_arc()).unwrap();
+        *signaler.as_mut().project().fence = Some(fence);
+
+        let signaler = ListArc::from(signaler);
+        self.data.fctx.fences.lock().push_back(signaler);
+
+        // A `DriverFenceAllocation`'s purpose is to carry allocated memory, so that
+        // `DriverFence`s can always be created without allocating. In this
+        // method, ownership over that memory is transferred to the new
+        // `DriverFence` and managed through refcounting. The C dma_fence
+        // backend will ultimately free the memory once the refcount reaches 0.
+        let ptr = KBox::into_raw(self.data);
+        // SAFETY: `ptr` was just created validly directly above.
+        let ptr = unsafe { NonNull::new_unchecked(ptr) };
+
+        DriverFence { data: ptr }
+    }
+
+    fn as_raw(&self) -> *mut bindings::dma_fence {
+        self.data.inner.inner.get()
+    }
+}
+
+impl<'a, T: Send + Sync + FenceContextOps> DriverFence<'a, T> {
+    fn as_raw(&self) -> *mut bindings::dma_fence {
+        // SAFETY: Valid because `self` is valid.
+        let fence_data = unsafe { &*self.data.as_ptr() };
+
+        fence_data.inner.inner.get()
+    }
+
+    /// Create a [`DriverFence`] from a raw pointer to a [`bindings::dma_fence`].
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `dma_fence` that was obtained through
+    /// a [`DriverFence`] with matching generic data for both fence and associated
+    /// [`FenceContext`].
+    unsafe fn from_raw(ptr: *mut bindings::dma_fence) -> Self {
+        let opaque_fence = Opaque::cast_from(ptr);
+
+        // SAFETY: Safe due to the function's overall safety requirements.
+        let fence_ptr = unsafe { container_of!(opaque_fence, Fence, inner) };
+
+        // DriverFenceData is repr(C) and a Fence is its first member.
+        let fence_data_ptr = fence_ptr as *mut DriverFenceData<'a, T>;
+
+        // SAFETY: `fence_data_ptr` was created validly above.
+        let data = unsafe { NonNull::new_unchecked(fence_data_ptr) };
+
+        Self { data }
+    }
+
+    /// Return the underlying [`Fence`].
+    pub fn as_fence(&self) -> &Fence {
+        // SAFETY: `self` is by definition still valid, and it cannot drop until
+        // this new reference is gone.
+        unsafe { Fence::from_raw(self.as_raw()) }
+    }
+
+    // TODO: Base this on a more efficient data structure.
+    //
+    // The fctx needs to keep track of unsignaled fences to prevent UAF bugs if
+    // a `DriverFence` is forgotten. To do so, the fctx needs a data structure
+    // to keep track of all these fences.
+    //
+    // Originally, an XArray was supposed to do that. The current XArray
+    // implementation, however, is not suitable because:
+    //   a) this implementation needs to support 32-bit architectures. The fence
+    //      sequence number is a u64, and XArray tracks indices with a `usize`,
+    //      which can be u32 and therefore be incompatible.
+    //   b) XArray is in general not a good data structure for huge indices (i.e.,
+    //      those approaching U32_MAX), since it then ends up doing a lot of
+    //      pointer indirections.
+    //
+    // Our choice of data structures is limited by the fact that the entries to
+    // be stored need to be pre-allocated, and by what Rust4Linux currently
+    // provides. We cannot have the `ListArc` refcount exposed, so the only way
+    // to remove from the list for now is by searching for the sequence number.
+    //
+    // While in theory this means O(n) for signaling a fence, in practice it
+    // should usually be O(1) because fences on the same fence context are
+    // created, submitted and signaled in order. So this solution is good for
+    // now, and, as stated above, the only alternative (XArray) would also
+    // become very inefficient once the sequence number gets high.
+    //
+    // Anyways, the best data structure for this task is probably a hash table,
+    // which allows for getting the fence with O(1) and iterating over all
+    // fences once the context drops.
+    //
+    // Alternatively, someone could explore how the `ListArc` could be stored in
+    // the `DriverFenceData`. It would then have to be moved, however, and the
+    // cast into a `UniqueArc` would have to be considered. Having a data
+    // structure like a list has the advantage of no fence sequence numbers
+    // having to be preallocated.
+    fn remove_from_fctx_list(&self) {
+        // SAFETY: `self.data` is valid because `self` was validly initialized.
+        let mut guard = unsafe { self.data.as_ref().fctx.fences.lock() };
+        let mut cursor = guard.cursor_front();
+
+        while let Some(pos) = cursor.peek_next() {
+            // Fences in this list are always initialized, so `unwrap` is OK.
+            if self.as_fence().get_seqno() == pos.fence.as_ref().unwrap().get_seqno() {
+                let _ = pos.remove();
+            }
+        }
+    }
+
+    /// Signal the fence. This will invoke all registered callbacks.
+    pub fn signal(self, res: Result) {
+        // We signal this fence now. Remove it from the list of unsignaled fences.
+        self.remove_from_fctx_list();
+
+        let fence = self.as_fence().lock();
+
+        // SAFETY: `fence` is valid because `self` is valid. The lock must be
+        // held, which we acquired directly above.
+        if !unsafe { bindings::dma_fence_test_signaled_flag(*fence.deref()) } {
+            if let Err(err) = res {
+                // SAFETY: `fence` is valid because `self` is valid. The fence
+                // must not have been signaled yet, which we check directly above.
+                unsafe { bindings::dma_fence_set_error(*fence.deref(), err.to_errno()) };
+            }
+            // SAFETY: `fence` is valid because `self` is valid. The lock must
+            // be held, which we acquired above.
+            unsafe { bindings::dma_fence_signal_locked(*fence.deref()) };
+        }
+    }
+}
+
+// SAFETY: Fences are literally designed to be shared between threads.
+unsafe impl<'a, T: Send + Sync + FenceContextOps> Send for DriverFence<'a, T> {}
+// SAFETY: Fences are literally designed to be shared between threads.
+unsafe impl<'a, T: Send + Sync + FenceContextOps> Sync for DriverFence<'a, T> {}
+
+impl<'a, T: Send + Sync + FenceContextOps> Deref for DriverFence<'a, T> {
+    type Target = T::FenceDataType;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Thanks to refcounting, `data` is always valid as long as `self` is.
+        let data = unsafe { &*self.data.as_ptr() };
+
+        &data.data
+    }
+}
+
+/// A borrow wrapper for [`DriverFence`]. Implements [`Deref`].
+pub struct DriverFenceBorrow<'a, T: Send + Sync + FenceContextOps> {
+    driver_fence: ManuallyDrop<DriverFence<'a, T>>,
+    _lifetime: PhantomData<&'a T>,
+}
+
+impl<'a, T: Send + Sync + FenceContextOps> Deref for DriverFenceBorrow<'a, T> {
+    type Target = DriverFence<'a, T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.driver_fence.deref()
+    }
+}
+
+// SAFETY: The Rust dma_fence abstractions are already designed around the inner
+// C `dma_fence`, which can serve safely as the identification point when being
+// owned by C. Moreover, safety is ensured by not dropping `DriverFence` and by
+// only allowing operations without side effects on the Borrowed type.
+unsafe impl<T: Send + Sync + FenceContextOps + 'static> ForeignOwnable for DriverFence<'_, T> {
+    type Borrowed<'a>
+        = DriverFenceBorrow<'a, T>
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = DriverFenceBorrow<'a, T>
+    where
+        Self: 'a;
+
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<bindings::dma_fence>();
+
+    fn into_foreign(self) -> *mut c_void {
+        let fence = self;
+
+        let ptr = fence.as_raw();
+
+        // DriverFence must not drop.
+        let _ = ManuallyDrop::new(fence);
+
+        ptr.cast()
+    }
+
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
+        // SAFETY: Safe because the trait implementation only invokes this with
+        // a valid `ptr`, associated to a `DriverFence` with matching generic data.
+        unsafe { Self::from_raw(ptr.cast()) }
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> Self::Borrowed<'a>
+    where
+        Self: 'a,
+    {
+        // SAFETY: The trait implementation ensures that `ptr` always resides
+        // within a [`Fence`] within a [`DriverFenceData`].
+        let driver_fence = unsafe { Self::from_raw(ptr.cast()) };
+
+        let driver_fence = ManuallyDrop::new(driver_fence);
+
+        DriverFenceBorrow {
+            driver_fence,
+            _lifetime: PhantomData,
+        }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> Self::BorrowedMut<'a>
+    // FIXME: The bound below and the one above in `borrow` should actually be
+    // unnecessary since the compiler should be able to completely derive all
+    // necessary information automatically. There is currently a compiler bug
+    // preventing that, though:
+    //
+    // https://github.com/rust-lang/rust/issues/155430.
+    //
+    // (Help to) fix the compiler bug and remove the bounds afterwards.
+    where
+        Self: 'a,
+    {
+        // SAFETY: The trait implementation ensures that `ptr` always resides
+        // within a [`Fence`] within a [`DriverFenceData`].
+        let driver_fence = unsafe { Self::from_raw(ptr.cast()) };
+
+        let driver_fence = ManuallyDrop::new(driver_fence);
+
+        DriverFenceBorrow {
+            driver_fence,
+            _lifetime: PhantomData,
+        }
+    }
+}
+
+impl<'a, T: Send + Sync + FenceContextOps> Drop for DriverFence<'a, T> {
+    fn drop(&mut self) {
+        let guard = self.as_fence().lock();
+
+        // Use dma_fence_test_signaled_flag() instead of
+        // dma_fence_is_signaled_locked() because the C backend wants to get rid
+        // of the latter.
+
+        // SAFETY: `guard` is valid until the `call_rcu()` below.
+        let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(*guard.deref()) };
+        if warn_on!(!signaled) {
+            // SAFETY: `guard` is valid until the `call_rcu()` below. The fence
+            // must not have been signaled yet, which we check directly above.
+            unsafe { bindings::dma_fence_set_error(*guard.deref(), ECANCELED.to_errno()) };
+            // SAFETY: `guard` is valid until the `call_rcu()` below. The lock
+            // must be held, which we acquired above.
+            unsafe { bindings::dma_fence_signal_locked(*guard.deref()) };
+        }
+        drop(guard);
+
+        // SAFETY: Valid because `self` is valid.
+        let rcu_head_ptr = unsafe { &raw mut (*self.data.as_ptr()).rcu_head };
+
+        // `DriverFenceData` but could be accessed through some dma_fence
+        // callbacks right now. Access is being revoked in principle above by
+        // signalling the fence, but since the C backend does not guarantee
+        // perfect full synchronization, we have to wait for one grace period to
+        // ensure that all accessors of `DriverFenceData` (through the
+        // dma_fence_ops accessible through a `Fence`) are gone.
+
+        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_ptr` was
+        // created validly above. The module must perform a `synchronize_rcu()`
+        // or `rcu_barrier()` call to guard against module unload.
+        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence_data::<T>)) };
+    }
+}
+
+// TODO:
+// The entire call_rcu() mechanism in the drop above and the code below would be
+// unnecessary if C's dma_fence_signal() could be reworked in a way that after it
+// ran, the caller knows that no fence_ops callbacks can be running anymore.
+// In other words, if the dma_fence backend would use its spinlock for full
+// synchronization.
+//
+// Then we could move the drop_in_place() and dma_fence_put() upwards into the
+// drop() implementation and call it a day.
+
+/// Finally really drop this `DriverFence<T>`
+///
+/// # Safety
+///
+/// `head` references the `rcu_head` field of an `DriverFenceData<T>`. All
+/// accessors to that `DriverFenceData<T>` must be gone by now. This must be
+/// ensured by signalling the associated `DriverFence<T>` and then waiting
+/// for a grace period until calling this function here.
+unsafe extern "C" fn drop_driver_fence_data<T: Send + Sync + FenceContextOps>(
+    head: *mut bindings::callback_head,
+) {
+    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `DriverFenceData<C>`.
+    let fence_data = unsafe { container_of!(head, DriverFenceData<'_, T>, rcu_head) };
+
+    // SAFETY: `fence_data` was created validly above. All the fence's data will
+    // only drop below, but the raw pointer to the raw C `dma_fence` remains
+    // valid because the reference count is only decremented at the end of the
+    // function.
+    let fence = unsafe { (*fence_data).inner.inner.get() };
+
+    // SAFETY: `fence_data` was created validly above. A grace period has passed.
+    // All callbacks which might have had access to the `fctx` are gone now.
+    unsafe { drop_in_place(&raw mut (*fence_data).fctx) };
+
+    // SAFETY: `fence_data` was created validly above. The user has already
+    // dropped the only conventional accessor to the user data, the `DriverFence`,
+    // one grace period ago. All accessors are gone now.
+    unsafe { drop_in_place(&raw mut (*fence_data).data) };
+
+    // The inner `Fence` explicitly does not get dropped because there may be
+    // many more users / consumers, each holding their own reference.
+
+    // SAFETY: Once a `DriverFence` is initialized, the inner `fence` is
+    // valid and initialized. It is valid until the refcount drops
+    // to 0, which can earliest happen once we drop the `DriverFence`'s reference
+    // here.
+    unsafe { bindings::dma_fence_put(fence) };
+
+    // The actual memory the data associated with a `DriverFence` lives in
+    // gets freed by the C dma_fence backend once the fence's refcount reaches 0.
+}
diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs
new file mode 100644
index 000000000000..4764a828642e
--- /dev/null
+++ b/rust/kernel/dma_buf/mod.rs
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DMA-buf subsystem abstractions.
+
+pub mod dma_fence;
+
+pub use self::dma_fence::{
+    DriverFence,
+    Fence,
+    FenceCallback,
+    FenceCallbackRegistration,
+    FenceContext,
+    FenceContextOps, //
+};
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 68f4d9a3425d..6221ebfe71df 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -67,6 +67,7 @@
 pub mod device_id;
 pub mod devres;
 pub mod dma;
+pub mod dma_buf;
 pub mod driver;
 #[cfg(CONFIG_DRM = "y")]
 pub mod drm;
-- 
2.55.0

