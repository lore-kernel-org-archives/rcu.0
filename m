Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EC43E489
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917926; cv=none; b=k2M77MRub4uwr7AhpgIhT72kf96tP/yF+qXMuf7idyXxRkAGuUn2KpSKlUbgCsLdzZQE7NlUDv42C/CTJJ4AmjlBEcnofLK1H+ISoyGNExeXLXOlbZPaXQadVGxYNLN9WKabPONjweadFRmEiSJ65nAkkVqryLVrnb7ecyl5EI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917926; c=relaxed/simple;
	bh=BKLHL6GosVcMSmMVR2siGs9GnPyNEBiirPveW3YqweY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJaqwTd+7/bPAkPldCc4pL57Hvg+LHh+1R5nGskJBeWSyhXxAmYiRNA+HSwumdpwxxVlshH9A2ugpT18udOu8cUvxCVbST85Pz3SSWQZdykYhZR2GHIwJhH2uZnG/5eXz5EIcYdGPuLLHzGncK6RpIO9KEkh8jReXLdQPK397KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejZEvzdt; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejZEvzdt"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c07bc2ad13so365686685a.2
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917923; x=1769522723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdZCtc/SzUUU469DlUjjz+ivRYHRKqFHgnur+s05bgo=;
        b=ejZEvzdtgykt2uVi8cWMlNEO1ulIUU9VWAA9gkVh9a+4u/6HU+m7k8mMUJAWjuVjsm
         RaWcF80mMY1bl9ceouXFvkdG0zTBLlt8MPsFQeyRjT4KkYwfVPWD2OEcrnPhtvw92SXD
         j9yUtVvO0othFpHPwdyd2wRpcxGsM44jzgjkMXWrbvlSfJMgbCN5XDjr9vFCtRmB93CV
         mGJpG8zG3oddW7QUy3qSlW3Hlkj5BsneBL2X2A5vs5AmHT3oNEWKD/RxkQm2c5A6+CmK
         +SUqzKUYOtvFmPl4aaUF+cXODK6zTbeq4is2gWqPVpNPRvqn0GKOpfgjtD/rJ1M4a/jw
         94Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917923; x=1769522723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdZCtc/SzUUU469DlUjjz+ivRYHRKqFHgnur+s05bgo=;
        b=cO5cDf0RU7XJPS/boQ7/tpwHN1T0Ei7ZJWtP25ofDVhDqJLA/mbTfAkDTpHhfoKpZW
         Fn1auXWqGS5KF1B/WUB3oNIHWuJJvQAxIRRqk+ryZlXeUFBdNUN2EQlm3O2PpxEWY4Kq
         DkFXxBpEwmtEqQwS4Kkk+XqwzCpaVUhuNTOMn7hcYZkmWvkPT7JPDux4tFde+6F8teMR
         PmzElVmh2BZHUZ0zxnX9H6dH+YwTw2w/2pySTXdJFAaGl9EbDDYMEKXuULmkxyaD/6b5
         raLNC2RDlJO/RXvRZleIZl7NR43W/63Mk23ZYDSXQCe0/Fi7+A20rKFiBIrSak8rfzhk
         hefw==
X-Forwarded-Encrypted: i=1; AJvYcCU6+1Mnw5gGDzLXYVLeLPVdNz5G5FilrHVj9p9kU9PLZI6myuIaPefdLY46WMMU89r55KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3Ttt3H6JyPgV45MtMbhyv9ohMjFw57o9m1k2NddjDXLcWun6
	AXiU7+/8RsGem+O/ykq05BtORUPqJhSPHlxuC4NbOvAsQXftsm2uhKTa
X-Gm-Gg: AY/fxX6WnJY0exGBhNu5IgxEhu/L0TPcJbKbJkeAHvxbOZMSJsU8noTXLVL52Hxo2II
	VrIn7LceIdDbppl72XTIRZxkDAVzWStVwDXNWcSsyl41aFvCsBckDRzvv/pe6aNk4QPVWmJuobZ
	txf+9jt9hFZj3FD2LdBwJR3GVfZzdGkPfT7iFX2CsBTMGiCO19Ht62EF9c6hVDpEdy5w1Zv9soo
	KSR8IaT/aNnxHqdRkGvGdSWs/GFODhdaHXHyPT3CUl9ar2hSCGMIrCk2W3xBbPr+BycRY/93tg4
	A/QlfT6J/MmUVtzFfIG8r1d0xNhHVmVevl1WZM17em2Efhubt5RSe7KtWNE0PTu0ICnGQUpEIM1
	aXewYHnCwxbtT5Wc5GfelZEG9lnXhjkRuekibfuGaDvMlhfyV/nG9Ip6h6buD3NquRFoyiOMIyP
	GdIhvWxPr3SMZVihdk4ct0BzmEDiRkCofqSFRusAapjHgmgX2qF5ak6ICNM323uay0mHDGp+rqX
	Ls+U9w1GxuGPKk=
X-Received: by 2002:a05:620a:4404:b0:8c6:afa6:270f with SMTP id af79cd13be357-8c6ccf36a4fmr204945785a.76.1768917922310;
        Tue, 20 Jan 2026 06:05:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm1043200285a.53.2026.01.20.06.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:05:21 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6932EF40069;
	Tue, 20 Jan 2026 09:05:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 09:05:20 -0500
X-ME-Sender: <xms:oItvaQM4q_qmUk0KmDijWjuPLPlEaH5kl5c5JZcCb_kX_iUq5uBoKQ>
    <xme:oItvafUjQjYqGSTbeZJeVa_yrzqIx9kQ6g2Fcn0mtcOrN9oIYT-w0A1YhAyfpsIDA
    s2F7tXeDWyGuSR1O_EEP05wlHUq-Z8eby2EousJLoQvxJr8E_7UCg>
X-ME-Received: <xmr:oItvaZfFF00g49nVUUAL8rlh7Dr9Yoq6tVOiXDTHfZwjgpbzus71r7lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oItvaQj9NjmaLdpJb7ukya3oFGZauhytynhLN7qi0OH7fMdrOq-1JA>
    <xmx:oItvaahV8ECiHj5CdXxFSdcjD_91kNCSWDcCaZR-E-Al-l51Dg_4RA>
    <xmx:oItvacrHOH41CneZvBU75D0b9TNLV0e36-6VD3P_3SEja6lhUygs9w>
    <xmx:oItvaQw31r8uoA_AUCro7HTgrndIxS9JY6hL_GMiQRToEpOUbDIWig>
    <xmx:oItvabyPsQIAJX0Hwx119jVucQ00o3B0vMSvvwm6TKE4DUZVa1RhqyqK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 09:05:19 -0500 (EST)
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v2 2/2] rust: sync: atomic: Add Atomic<*{mut,const} T> support
Date: Tue, 20 Jan 2026 22:05:03 +0800
Message-ID: <20260120140503.62804-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120140503.62804-1-boqun.feng@gmail.com>
References: <20260120140503.62804-1-boqun.feng@gmail.com>
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

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic_ext.c            |  3 ++
 rust/kernel/sync/atomic.rs           | 12 +++++++-
 rust/kernel/sync/atomic/internal.rs  | 24 +++++++++------
 rust/kernel/sync/atomic/predefine.rs | 46 ++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 10 deletions(-)

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
index 53177052b4b2..7ed8febe4a58 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -52,6 +52,10 @@
 #[repr(transparent)]
 pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
 
+// SAFETY: `Atomic<T>` is safe to transfer between execution contexts because of the safety
+// requirement of `AtomicType`.
+unsafe impl<T: AtomicType> Send for Atomic<T> {}
+
 // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
 unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 
@@ -69,6 +73,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
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
@@ -109,7 +118,8 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
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
index ef516bcb02ee..e301db4eaf91 100644
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
@@ -37,9 +39,9 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
     type Delta;
 }
 
-// The current helpers of load/store of atomic `i8` and `i16` use `{WRITE,READ}_ONCE()` hence the
-// atomicity is only guaranteed against read-modify-write operations if the architecture supports
-// native atomic RmW.
+// The current helpers of load/store of atomic `i8`, `i16` and pointers use `{WRITE,READ}_ONCE()`
+// hence the atomicity is only guaranteed against read-modify-write operations if the architecture
+// supports native atomic RmW.
 //
 // In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architecture plans to support Rust, the
 // load/store helpers that guarantee atomicity against RmW operations (usually via a lock) need to
@@ -58,6 +60,10 @@ impl AtomicImpl for i16 {
     type Delta = Self;
 }
 
+impl AtomicImpl for *const c_void {
+    type Delta = isize;
+}
+
 // `atomic_t` implements atomic operations on `i32`.
 impl AtomicImpl for i32 {
     type Delta = Self;
@@ -269,7 +275,7 @@ macro_rules! declare_and_impl_atomic_methods {
 }
 
 declare_and_impl_atomic_methods!(
-    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
+    [ i8 => atomic_i8, i16 => atomic_i16, *const c_void => atomic_ptr, i32 => atomic, i64 => atomic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
@@ -287,7 +293,7 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
 );
 
 declare_and_impl_atomic_methods!(
-    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
+    [ i8 => atomic_i8, i16 => atomic_i16, *const c_void => atomic_ptr, i32 => atomic, i64 => atomic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index e04268379157..a560518e96ee 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -4,6 +4,7 @@
 
 use crate::static_assert;
 use core::mem::{align_of, size_of};
+use ffi::c_void;
 
 // Ensure size and alignment requirements are checked.
 static_assert!(size_of::<bool>() == size_of::<i8>());
@@ -28,6 +29,26 @@ unsafe impl super::AtomicType for i16 {
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
+// SAFETY:
+//
+// - `*const T` has the same size and alignment with `*const c_void`, and is round-trip
+//   transmutable to `*const c_void`.
+// - `*const T` is safe to transfer between execution contexts. See the safety requirement of
+//   [`AtomicType`].
+unsafe impl<T: Sized> super::AtomicType for *const T {
+    type Repr = *const c_void;
+}
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -339,4 +360,29 @@ fn atomic_bool_tests() {
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
+
+        let x = Atomic::new(&raw const v);
+
+        assert_eq!(x.load(Acquire), &raw const v);
+        assert_eq!(
+            x.cmpxchg(&raw const u, &raw const u, Relaxed),
+            Err(&raw const v)
+        );
+        assert_eq!(
+            x.cmpxchg(&raw const v, &raw const u, Relaxed),
+            Ok(&raw const v)
+        );
+        assert_eq!(x.load(Relaxed), &raw const u);
+    }
 }
-- 
2.51.0

