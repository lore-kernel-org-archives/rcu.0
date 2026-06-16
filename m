Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1040E8CD;
	Tue, 16 Jun 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598538; cv=none; b=RcYRGH9IxR8juJNTIJqO3tTcj5/5cgMbICzLoHvlfFdCt4Um11gzb3osMMOI+6cvFg6ozoJuc75goFU8XadP+61t1Vzhi7BZYn9aFSkEAaXJy7BCmLH6tx7iikewnJqYSlNsjkY6493dGy/QlNdRqEk4PDVTydgILkd5pPPGsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598538; c=relaxed/simple;
	bh=iusRewpZ34TnQ5G2HLBSE7H0Lnu251CvtBRxV7HZGC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9BSCTVoYZ8lODE3op/Kc/IcnS2TjK65a4YrO+ufJmoj9hTvPJX+z23+aI77vVtYBdnQivtMLl2HZSHuQtBlqBb68iIa7oy7MZmdxl92zMX4uD3fE+m1MVciR2BPwCvvkqmzbrZkXCIM8vEEzJj/9c5QmQhUdOiOEb8FOh8olQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY5e7vYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY5e7vYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C411F00A3A;
	Tue, 16 Jun 2026 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598537;
	bh=pDJyMWyNek1/CTCATK0JZj8GklloT+oL+OiV9mbnCoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KY5e7vYpnbcv89QcCB08ReD5gzYRVrzkr1O0pVaJaVaXPLFXPUGwcSRiqpmD1FLaQ
	 RIN6+p8aqQy2zdJsqoIovF77Xn/k15p2Eew3PHqXU2y6eB8yrFE0mu8cE0oJT0N5Fc
	 mLJwnJ6e6ynN62WnF+xTWGxo5eK00Ny5NdIxqINwdqbKKPoXD4WBJhdySJ6eP2Q8tx
	 eB8HiVKZeRUdKN/k3Y/ngdxmOeRESY7XOra5w//Jc7MCUe+HhUIaq5YPOFMKitGm0S
	 0dyAefdhNFCbEf6dGy1k1fUrQTEO4G1aR9+yLeSMRle+2szaDMKvxIgNqIUBwsbhls
	 JmAowoV1QirxQ==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rcu@vger.kernel.org
Subject: [PATCH v2 1/6] rust: types: implement ForeignOwnable for ARef<T>
Date: Tue, 16 Jun 2026 10:28:13 +0200
Message-ID: <20260616082819.2943886-3-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Implement ForeignOwnable for ARef<T>, making it possible for C code to
own an ARef<T>.

Since ARef represents shared ownership, BorrowedMut is &T rather than
&mut T, matching the semantics of the underlying reference-counted type.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/aref.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 9989f56d0605..82907383c44b 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -17,6 +17,10 @@
 //! [`Arc`]: crate::sync::Arc
 //! [`Arc<T>`]: crate::sync::Arc
 
+use crate::{
+    prelude::*,
+    types::ForeignOwnable, //
+};
 use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
 
 /// Types that are _always_ reference counted.
@@ -183,6 +187,41 @@ fn eq(&self, other: &ARef<U>) -> bool {
 }
 impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
 
+// SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so it's non-null. The
+// `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's aligned to `T`.
+unsafe impl<T: AlwaysRefCounted + 'static> ForeignOwnable for ARef<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+
+    type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a T;
+
+    fn into_foreign(self) -> *mut c_void {
+        ARef::into_raw(self).as_ptr().cast()
+    }
+
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let ptr = unsafe { NonNull::new_unchecked(ptr.cast()) };
+
+        // SAFETY: `ptr` came from `into_foreign`, which consumed an `ARef` without decrementing
+        // the refcount, so we can transfer the ownership to the new `ARef`.
+        unsafe { ARef::from_raw(ptr) }
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: The safety requirements of this method ensure that the object remains alive and
+        // immutable for the duration of 'a.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
+        // requirements for `borrow`.
+        unsafe { <Self as ForeignOwnable>::borrow(ptr) }
+    }
+}
+
 impl<T, U> PartialEq<&'_ U> for ARef<T>
 where
     T: AlwaysRefCounted + PartialEq<U>,
-- 
2.54.0

