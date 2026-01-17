Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16286314B9D
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652588; cv=none; b=jJnhFxDq8ONTZtm8kVKNpBP/zcNwPGpAN5U5JGJq1BSlcSkgrbvqa5JW/NwtT9KrSGLmpDs17GqJJcZSQEmhqUqD5qfguCwMUb+gNTWDdRm1EhTOrGDpCyK1TeRu7vgQW4IoLzHJMel8N8EZU3a1q3pDUZ+iT/nkcR6V6XzlCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652588; c=relaxed/simple;
	bh=Mn9K21+uoF4cJ3TSX9t5OyIIQAr4QjA54LiStkUJdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8sXAJ+fbWblngeRNMKDSDWp5Y8Y1FS48OvOXWSACMHWAHHnyv0DBtuODX/F/iOu5t/CFi7n8AMswUxpsFDePdDFtIpGvJnJUeMbjDWx7o1+Q/SN7h6AaqRz2AaU5P5KssnEb+RjKv4c1IEb5PHAYItA3yPhoIqTIuIQyD5cC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYLk7iNb; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYLk7iNb"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c532d8be8cso297436685a.2
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768652586; x=1769257386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqkORS96nGwm/tYZHUw31tz+3dE4qDqicBtgX0AoLrQ=;
        b=iYLk7iNblRbM46CW1cZBLTffa+NPDJqDFmr+Z2fqsm0zr5jw0pPMP9OCVwfxzDC7yy
         BqosSPt3A5lCtVzFsIqKM1nQ16UJRrcsqFJTDuo241s2FQZfqF5IPwQY8uH18qEno+f9
         A7D0cdOFsnG+YVtoCjfweZ0pl/jOqi2sQ7U3d53fy7EuPNJUsQSw+JSwL1Wpe/XyKC1W
         1MjTi76ZzuuvAmjy4Gu9DF8ZcKN8qk+PtKITj0tObmwzW0dFZ5+LVb/IFhh0oCY2w8rh
         mMtNNR3XeUQGBhAKIWgstcYkC0DXGSL0bkRexBCZOZmpFIniEqkfcOKK3WmA4btQOUVG
         rvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768652586; x=1769257386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqkORS96nGwm/tYZHUw31tz+3dE4qDqicBtgX0AoLrQ=;
        b=Cy0gVBywQE08UR4SM4Tk6p4EB1Ll/vwPYT+LG0gD4AKhJ0h8DwiPHhLdW4pMzCOD32
         D9qwJ+pogSa0Q9W7LZVYHs9i/G8ASlio8wV6C38gXVqL3rQhMdiTcXYgQ9l2Wity7ntX
         xDNNYOtpU7NMzchbdn3hDwvtaSKxw5Lu7ykrfb5/oiC8jgkrdFRm6rGkdmsrQHGTNCxt
         JjDu2a8ceW/9ex+6yK2BXTCugaUqbpMDDjZCLeSqJIC/vW5LnxHKafbm+rB7/FjDdDA0
         5wCrZKof3LCGu189v9IUujQ8RvdKtTSb3EDMEeH2Y0RYw3F90LMxHmLhfnw+0MontMmo
         CpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqf7QBR9HqGsDjfyqnrPdGeVcvtCP3K/CZiFjsO90BTLhB4kdof4nJKwCDtmroUmfwSzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77Dl/suSg7LcEqydVfo8kPC6BJu9RjGg4d8WHhg5KFtFigCwF
	dG7GkQCjzHqVfdzduFuTUWYjynZbFjjOHkVfnvk4sfWouxzuoco8NC8t
X-Gm-Gg: AY/fxX7AYf1EFeYUO5qlMbmXuQTlkoDGbOziRKsLcNjzXwDww4Qqb7WqkJFG+uI8AFU
	mQm9KVEWZioK87GYhX1JXgbtJRIOomwivfMTi4lMSxbfU5u3QOZJZTXx8aNzo4eKZp7HK+mM84N
	YTtUwsaTwF9qj3BtnRp/M8V+uRPCs8pjau9DUf0WlzoHBHpJTNrvBIMdMaGxFjoZIyoU6N3hvUb
	SL2RJ0X7RtXSMbN3sTwSSMQFEV15n59Z/c1wjThaLmVD7jfsadFKOx0ZmgB9RWox5QlXrHuldJw
	FZBGAVj/hOJ1+BSn7ZnvFqTlDVALRj+0XhRScvxm5Fo5nkYSPEchwIc1OZBDiQHEYGfFWG6uBuA
	u2AUSTh7K5QmLDN5blLdJGOOVMJPt7rOWEEfvpFvqhTudfCoqIfcxk20D1C9gZH+9+upckWLpJH
	r3zNkrEDJFHddMrxdzf9rCcAoSDahvTJkd32McO0xkbgiq1ToYpSwrblV8miM8i55XC7Nzbz7Ge
	r91tKfYJJNA8x4=
X-Received: by 2002:a05:620a:710c:b0:8b2:d72d:e41b with SMTP id af79cd13be357-8c6a676de84mr823908785a.44.1768652585732;
        Sat, 17 Jan 2026 04:23:05 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e535dsm46061576d6.4.2026.01.17.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:23:05 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86362F4007E;
	Sat, 17 Jan 2026 07:23:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 07:23:04 -0500
X-ME-Sender: <xms:KH9radRlUQwQFWqGhgnZjxsP86nrAxn6VNc1wyl4qq7jzaZhFfkPeQ>
    <xme:KH9raf3IA3Hr-P6GC8WEfYl8ls5uJ-gSglicXi0S8BZHU7kxc2WNI6Wd_EsxJj3yo
    wcP1dMxm5R_GqUjTTb9pGWEDvpyMDFC82gpOFSKKhzw1HVqOvQO>
X-ME-Received: <xmr:KH9rab4-2Dg2sawme5wtJh6Zuz6nlSJNUYXP7YIh-r1YSFaKV4Zjgb72>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KH9raQzqezjVSBZDyx2jv2NfxekX3flqaWXflrrgNPmp7SQtUVD-lA>
    <xmx:KH9rafx18eLG7RxeutfWs8fkDu7CoBWP_3NysKgTW3oe7GlOYIXmRA>
    <xmx:KH9raYVb0MRzzfjlv4PMCSF6dPGLO7-ViSyRNsdiGMGrP_EgJFf0sg>
    <xmx:KH9racRKFOpTiJK_R5v4kNy4lsQIrT3C7mUjM1XESKcrsXToZUdFdQ>
    <xmx:KH9raXMzWh2GdHodk1g7LVRo6VzAK_qlCk1FiKqKlr6poTdVP_-BMYFh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 07:23:03 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
Date: Sat, 17 Jan 2026 20:22:42 +0800
Message-ID: <20260117122243.24404-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117122243.24404-1-boqun.feng@gmail.com>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic pointer support is an important piece of synchronization
algorithm, e.g. RCU, hence provide the support for that.

Note that instead of relying on atomic_long or the implementation of
`Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
atomic pointer specifically, this is because ptr2int casting would
lose the provenance of a pointer and even though in theory there are a
few tricks the provenance can be restored, it'll still be a simpler
implementation if C could provide atomic pointers directly. The side
effects of this approach are: we don't have the arithmetic and logical
operations for pointers yet and the current implementation only works
on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
issues and can be added later.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic_ext.c            |  3 +++
 rust/kernel/sync/atomic.rs           | 12 +++++++++++-
 rust/kernel/sync/atomic/internal.rs  | 21 +++++++++++++++------
 rust/kernel/sync/atomic/predefine.rs | 23 +++++++++++++++++++++++
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 240218e2e708..c267d5190529 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -36,6 +36,7 @@ __rust_helper void rust_helper_atomic_##tname##_set_release(type *ptr, type val)
 
 GEN_READ_SET_HELPERS(i8, s8)
 GEN_READ_SET_HELPERS(i16, s16)
+GEN_READ_SET_HELPERS(ptr, const void *)
 
 /*
  * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
@@ -59,6 +60,7 @@ rust_helper_atomic_##tname##_xchg##suffix(type *ptr, type new)			\
 
 GEN_XCHG_HELPERS(i8, s8)
 GEN_XCHG_HELPERS(i16, s16)
+GEN_XCHG_HELPERS(ptr, const void *)
 
 /*
  * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
@@ -82,3 +84,4 @@ rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *ptr, type *old, type new)
 
 GEN_TRY_CMPXCHG_HELPERS(i8, s8)
 GEN_TRY_CMPXCHG_HELPERS(i16, s16)
+GEN_TRY_CMPXCHG_HELPERS(ptr, const void *)
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4aebeacb961a..4d2a5228c2e4 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -51,6 +51,10 @@
 #[repr(transparent)]
 pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
 
+// SAFETY: `Atomic<T>` is safe to transfer between execution contexts because of the safety
+// requirement of `AtomicType`.
+unsafe impl<T: AtomicType> Send for Atomic<T> {}
+
 // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
 unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 
@@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 ///
 /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
 /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+/// - [`Self`] must be safe to transfer between execution contexts, if it's [`Send`], this is
+///   automatically satisfied. The exception is pointer types that are even though marked as
+///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `unsafe` to do anything
+///   meaningful on them. This is because transferring pointer values between execution contexts is
+///   safe as long as the actual `unsafe` dereferencing is justified.
 ///
 /// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
 /// [`transmute()`] is always sound between `U` and `T`) because of the support for atomic
@@ -108,7 +117,8 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 /// [`transmute()`]: core::mem::transmute
 /// [round-trip transmutable]: AtomicType#round-trip-transmutability
 /// [Examples]: AtomicType#examples
-pub unsafe trait AtomicType: Sized + Send + Copy {
+/// [`NonNull<T>`]: core::ptr::NonNull
+pub unsafe trait AtomicType: Sized + Copy {
     /// The backing atomic implementation type.
     type Repr: AtomicImpl;
 }
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index 0dac58bca2b3..93f5a7846645 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -7,6 +7,7 @@
 use crate::bindings;
 use crate::macros::paste;
 use core::cell::UnsafeCell;
+use ffi::c_void;
 
 mod private {
     /// Sealed trait marker to disable customized impls on atomic implementation traits.
@@ -14,10 +15,11 @@ pub trait Sealed {}
 }
 
 // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
-// while the Rust side also layers provides atomic support for `i8` and `i16`
-// on top of lower-level C primitives.
+// while the Rust side also provides atomic support for `i8`, `i16` and `*const c_void` on top of
+// lower-level C primitives.
 impl private::Sealed for i8 {}
 impl private::Sealed for i16 {}
+impl private::Sealed for *const c_void {}
 impl private::Sealed for i32 {}
 impl private::Sealed for i64 {}
 
@@ -26,10 +28,10 @@ impl private::Sealed for i64 {}
 /// This trait is sealed, and only types that map directly to the C side atomics
 /// or can be implemented with lower-level C primitives are allowed to implement this:
 ///
-/// - `i8` and `i16` are implemented with lower-level C primitives.
+/// - `i8`, `i16` and `*const c_void` are implemented with lower-level C primitives.
 /// - `i32` map to `atomic_t`
 /// - `i64` map to `atomic64_t`
-pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
+pub trait AtomicImpl: Sized + Copy + private::Sealed {
     /// The type of the delta in arithmetic or logical operations.
     ///
     /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually it's the same type of
@@ -51,6 +53,13 @@ impl AtomicImpl for i16 {
     type Delta = Self;
 }
 
+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
+// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
+impl AtomicImpl for *const c_void {
+    type Delta = isize;
+}
+
 // `atomic_t` implements atomic operations on `i32`.
 impl AtomicImpl for i32 {
     type Delta = Self;
@@ -262,7 +271,7 @@ macro_rules! declare_and_impl_atomic_methods {
 }
 
 declare_and_impl_atomic_methods!(
-    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
+    [ i8 => atomic_i8, i16 => atomic_i16, *const c_void => atomic_ptr, i32 => atomic, i64 => atomic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
@@ -280,7 +289,7 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
 );
 
 declare_and_impl_atomic_methods!(
-    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
+    [ i8 => atomic_i8, i16 => atomic_i16, *const c_void => atomic_ptr, i32 => atomic, i64 => atomic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 42067c6a266c..1a4670d225b5 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -4,6 +4,7 @@
 
 use crate::static_assert;
 use core::mem::{align_of, size_of};
+use ffi::c_void;
 
 // Ensure size and alignment requirements are checked.
 static_assert!(size_of::<bool>() == size_of::<i8>());
@@ -28,6 +29,16 @@ unsafe impl super::AtomicType for i16 {
     type Repr = i16;
 }
 
+// SAFETY:
+//
+// - `*mut T` has the same size and alignment with `*const c_void`, and is round-trip
+//   transmutable to `*const c_void`.
+// - `*mut T` is safe to transfer between execution contexts. See the safety requirement of
+//   [`AtomicType`].
+unsafe impl<T: Sized> super::AtomicType for *mut T {
+    type Repr = *const c_void;
+}
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -215,4 +226,16 @@ fn atomic_bool_tests() {
         assert_eq!(false, x.load(Relaxed));
         assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
     }
+
+    #[test]
+    fn atomic_ptr_tests() {
+        let mut v = 42;
+        let mut u = 43;
+        let x = Atomic::new(&raw mut v);
+
+        assert_eq!(x.load(Acquire), &raw mut v);
+        assert_eq!(x.cmpxchg(&raw mut u, &raw mut u, Relaxed), Err(&raw mut v));
+        assert_eq!(x.cmpxchg(&raw mut v, &raw mut u, Relaxed), Ok(&raw mut v));
+        assert_eq!(x.load(Relaxed), &raw mut u);
+    }
 }
-- 
2.51.0

