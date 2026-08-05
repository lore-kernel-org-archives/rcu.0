Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C93939B1;
	Wed,  5 Aug 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942115; cv=none; b=hheTD66AP2cYjF1vMPeQQKI9Hd2qCRp381cXjb/eGyyvxM20QbW5OHqTSbJ6dp6rvkbEARAUwIcspzqkA2q74h07/NZ99d12jNU5RVbK/S8oHJiACWMySYKY0mMp/spwXEaYzDvHNgTFPlse7A6gwUIiwsmCk0SXbeCniWtEbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942115; c=relaxed/simple;
	bh=TGSVS27VsGgTdKeWuqJIXGATo3lWZJfA/ki8bAvqyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVpKIqIPNUFI417qXRMSF6BPUE+oz8AuF0COBBO/UryK24y1+iiLu2BjSvIsxiRmu0vUvXNyuL9guTZeM90bGGDS1DD/qDjN6+BInR8p+Lgzi0s9gjmfNaG5/4FNRxX9S63YQpGzoJAQt8bfO92RmOw/h7/0fgeyFxYrXafdbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juMsvdCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juMsvdCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A671F000E9;
	Wed,  5 Aug 2026 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942113;
	bh=LXJwHWfyIyYAol7hr0XIHN7RcUAOgHD73uS/AqOnnf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=juMsvdCE66RAjWyfSj04+GfkMyD7Ciy1yD2Cx0DxW18pNFXsyg4ww+LCtzci+5ff6
	 0jRsdVq/FOvK+uri82mj8rf2AwD6vwyj8Q7658YgH0q8j/c0hOf6gs4sxPO+NrNDKx
	 HtEQR0epBgVH7PbGQ/Zp5cJR2aRFm6g71qsp8/txyrcXzPLqFjPgQ+c90kYSbkPgEq
	 C2Ba1tx4OT2R9i4IOxqHKWhUopLAnVyeQy1gUDVVGQOJgrZmJgoPQute5KuPL4xDY7
	 FF1/6FCFYTq0HJZ+WeigqmBcLZMepLAh0rGiYk5u6Hw86WVxMarMHJXbOWN/64ARjd
	 0KJRY9gZLQgBg==
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
Subject: [PATCH v9 2/5] rust: types: implement ForeignOwnable for ARef<T>
Date: Wed,  5 Aug 2026 16:59:44 +0200
Message-ID: <20260805145949.938505-4-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
References: <20260805145949.938505-2-phasta@kernel.org>
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/aref.rs | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index b721b2e00b98..540766613659 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -24,6 +24,11 @@
     ptr::NonNull, //
 };
 
+use crate::{
+    prelude::*,
+    types::ForeignOwnable, //
+};
+
 /// Types that are _always_ reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decrement functions.
@@ -188,6 +193,41 @@ fn eq(&self, other: &ARef<U>) -> bool {
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
2.55.0

