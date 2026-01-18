Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E721FF33
	for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768731613; cv=none; b=RgsL/dnKTi+K6CNxXTufqxwaozq/1CbFOBuJngHTATV11DOG9bzzRjbmhX5+SisuAb1CanKoC2xVaqvRd8tK7CWLlnp3KyygW5JpT8ZbIJMwoX+JawIN+7M+dhgWy7tNbbMgZ15cc2juHkvg2lFLL0u9wry0h5NdlZK+5TL1VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768731613; c=relaxed/simple;
	bh=likXx3lsQApM6JONVukVE/Mpr53YqrYKc4J3h53njsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqm6tOrdeg8Qefxr1r8hWzlAgWpcyvh+b2Fw011iiEJbfmchrnNRUPgiFeGz0i6yyPYyV6wKJCV9t5zPRfHFneSNs/6gLeAT40saCjx6+JJGh8UR0l0q8zmIWYbdEOM/Fx9BYrkPXZqpMMA1ajcCYTZNSeOS6ezBLCkaVy0xPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9ldKYOx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9ldKYOx"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so2840625e87.1
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 02:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768731610; x=1769336410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=do81nvqxnQsd+JF7gNbhz4jmsUyXkHo3tqbXNTfxmZ8=;
        b=D9ldKYOxrDSx2DjAXqGLepwD5U7swFXzWrC++XJW75cgdtdxCRaVonYTZMYNXykuLm
         rGF1ry+Pft72FCPjiFQ731Goom82QjMwGRkQQEKMrEAO9ygOAm+JFqvd8tlSiK36U+hQ
         fkRsj3Wsh446WQLIeHt5huCFtihrXsDoG/1p8EciO+dlUp2IAnaBtaV9LMaVNayKkgJJ
         gm4oCeKMrt0cQfqCbnH+GbRDVXNtv1sXvET0UyrvXmqK9ENUvVbNV80vdkS61MdDCs/D
         LPNelLWPJj+GK8gsCqtmAMhXamHAbinYWPRH75+NfZdW4BjODXUx/AVysjO+vMF+rpcN
         1V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768731610; x=1769336410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do81nvqxnQsd+JF7gNbhz4jmsUyXkHo3tqbXNTfxmZ8=;
        b=Zq/RQc8qX4uwuca4Yqw93mwuHIXyXQfUFK1LnAtq6J577s79QXM6C1xFTPbR5YP8d0
         yng+ZjR9NrULqb6Gi3SLgC72kr7jFi9VTMu4ATsobljqLi95+44vwvvDHiYkRbPfukX2
         ehzw7ykO631ZTmABavTE36VctXtS4947BNd2zOKbzoq9b1m4dST5IoilACPznnnkw/Fw
         O/s1OPkl6rwPMeWUwi+KssmNRZ1dRx53m3JXSNXkmDM8lmZUCgHbX12WrWgiczfqvyQV
         287knh1TqZIkl6R/NHEXZhCu1Zr4nnHx/1eKHXZsSZc2v1zpCjn3KsMKtigmPszo2C0E
         Qy6A==
X-Forwarded-Encrypted: i=1; AJvYcCVOghAmKtdijKQcLUV6iMmwVK12FCHVdRqUF2rt0bUZKix2O1XywfZEWB1PXTR6rRub8a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCU3oSI9TL+VRupPXMs0bC2w31xSNuEFHBmOuIk4L/MnoQLWH
	p39Es/uu7Tdt+H8ztI2sPe8hmw9ss+11rQiTBIFi6Wzl5QPKSix+aOHtqTjjiA==
X-Gm-Gg: AY/fxX5durar6x/JA7Lcho3Eu4dn10euYxsD7/5QnAvncx3h6HG7K7yX3YUqzFNE4Ic
	u3yYmZEwZMfHIfQg6etux6jkasb0HDGlC3f8M+s3w7ETELxtml9EOwdyaB+hdqoiyvCuAavyU9b
	kuTwZR+Ge+zxgQj4EFUDuc7J2Pos03r83ivUNgqW+lVItC9F8zh7DtIxRU/5sKCzwOTSxwOXfk8
	kAWu08UvVks+CCsSqlILq5en809v+aApX5Gl0ZSM7QV2C7UABeh1LMSLvSB3dsmlBkVjWk2R/Oo
	9ka8qwWwkUNDDu6O8UhiG+d1Wgs+izIdv2zGCSpdpKx3yC2mEVjoYXigVLF6A+yCFV93UeZuN6r
	Jmhv0mZ/I45isWPecbzk/CexXqqxqw1KYP4kwriiK8NUMFhFUXMe5eViTu1vYoHJq9YFTqaokqF
	MTIbogjqS9eEpzxJINK982XRwDoKIBLs4SB3CGaM2Uofrm+40RV0VMlxpDggWlgo95viKUByJTv
	R6CMF8PJOZv7vBlCpo2p3yK2FyH9wVPGbMS6ZMVxLtNI4OXNNnv09PB
X-Received: by 2002:a05:6402:5114:b0:64b:93f4:bf85 with SMTP id 4fb4d7f45d1cf-654b955ce0dmr6185816a12.10.1768725520910;
        Sun, 18 Jan 2026 00:38:40 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:8193:226f:9765:711d? (p200300dfbf2de3008193226f9765711d.dip0.t-ipconnect.de. [2003:df:bf2d:e300:8193:226f:9765:711d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc5d6sm7155488a12.22.2026.01.18.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 00:38:39 -0800 (PST)
Message-ID: <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>
Date: Sun, 18 Jan 2026 09:38:36 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20260117122243.24404-5-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.01.26 13:22, Boqun Feng wrote:
> Atomic pointer support is an important piece of synchronization
> algorithm, e.g. RCU, hence provide the support for that.
> 
> Note that instead of relying on atomic_long or the implementation of
> `Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
> atomic pointer specifically, this is because ptr2int casting would
> lose the provenance of a pointer and even though in theory there are a
> few tricks the provenance can be restored, it'll still be a simpler
> implementation if C could provide atomic pointers directly. The side
> effects of this approach are: we don't have the arithmetic and logical
> operations for pointers yet and the current implementation only works
> on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
> issues and can be added later.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/atomic_ext.c            |  3 +++
>  rust/kernel/sync/atomic.rs           | 12 +++++++++++-
>  rust/kernel/sync/atomic/internal.rs  | 21 +++++++++++++++------
>  rust/kernel/sync/atomic/predefine.rs | 23 +++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
> index 240218e2e708..c267d5190529 100644
> --- a/rust/helpers/atomic_ext.c
> +++ b/rust/helpers/atomic_ext.c
> @@ -36,6 +36,7 @@ __rust_helper void rust_helper_atomic_##tname##_set_release(type *ptr, type val)
>  
>  GEN_READ_SET_HELPERS(i8, s8)
>  GEN_READ_SET_HELPERS(i16, s16)
> +GEN_READ_SET_HELPERS(ptr, const void *)
>  
>  /*
>   * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
> @@ -59,6 +60,7 @@ rust_helper_atomic_##tname##_xchg##suffix(type *ptr, type new)			\
>  
>  GEN_XCHG_HELPERS(i8, s8)
>  GEN_XCHG_HELPERS(i16, s16)
> +GEN_XCHG_HELPERS(ptr, const void *)
>  
>  /*
>   * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
> @@ -82,3 +84,4 @@ rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *ptr, type *old, type new)
>  
>  GEN_TRY_CMPXCHG_HELPERS(i8, s8)
>  GEN_TRY_CMPXCHG_HELPERS(i16, s16)
> +GEN_TRY_CMPXCHG_HELPERS(ptr, const void *)
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 4aebeacb961a..4d2a5228c2e4 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -51,6 +51,10 @@
>  #[repr(transparent)]
>  pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
>  
> +// SAFETY: `Atomic<T>` is safe to transfer between execution contexts because of the safety
> +// requirement of `AtomicType`.
> +unsafe impl<T: AtomicType> Send for Atomic<T> {}
> +
>  // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
>  unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>  
> @@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>  ///
>  /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
>  /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> +/// - [`Self`] must be safe to transfer between execution contexts, if it's [`Send`], this is
> +///   automatically satisfied. The exception is pointer types that are even though marked as
> +///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `unsafe` to do anything
> +///   meaningful on them. This is because transferring pointer values between execution contexts is
> +///   safe as long as the actual `unsafe` dereferencing is justified.
>  ///
>  /// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
>  /// [`transmute()`] is always sound between `U` and `T`) because of the support for atomic
> @@ -108,7 +117,8 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>  /// [`transmute()`]: core::mem::transmute
>  /// [round-trip transmutable]: AtomicType#round-trip-transmutability
>  /// [Examples]: AtomicType#examples
> -pub unsafe trait AtomicType: Sized + Send + Copy {
> +/// [`NonNull<T>`]: core::ptr::NonNull
> +pub unsafe trait AtomicType: Sized + Copy {
>      /// The backing atomic implementation type.
>      type Repr: AtomicImpl;
>  }
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> index 0dac58bca2b3..93f5a7846645 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -7,6 +7,7 @@
>  use crate::bindings;
>  use crate::macros::paste;
>  use core::cell::UnsafeCell;
> +use ffi::c_void;
>  
>  mod private {
>      /// Sealed trait marker to disable customized impls on atomic implementation traits.
> @@ -14,10 +15,11 @@ pub trait Sealed {}
>  }
>  
>  // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
> -// while the Rust side also layers provides atomic support for `i8` and `i16`
> -// on top of lower-level C primitives.
> +// while the Rust side also provides atomic support for `i8`, `i16` and `*const c_void` on top of
> +// lower-level C primitives.
>  impl private::Sealed for i8 {}
>  impl private::Sealed for i16 {}
> +impl private::Sealed for *const c_void {}
>  impl private::Sealed for i32 {}
>  impl private::Sealed for i64 {}
>  
> @@ -26,10 +28,10 @@ impl private::Sealed for i64 {}
>  /// This trait is sealed, and only types that map directly to the C side atomics
>  /// or can be implemented with lower-level C primitives are allowed to implement this:
>  ///
> -/// - `i8` and `i16` are implemented with lower-level C primitives.
> +/// - `i8`, `i16` and `*const c_void` are implemented with lower-level C primitives.
>  /// - `i32` map to `atomic_t`
>  /// - `i64` map to `atomic64_t`
> -pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
> +pub trait AtomicImpl: Sized + Copy + private::Sealed {
>      /// The type of the delta in arithmetic or logical operations.
>      ///
>      /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually it's the same type of
> @@ -51,6 +53,13 @@ impl AtomicImpl for i16 {
>      type Delta = Self;
>  }
>  
> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only

uses -> use ?

> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> +impl AtomicImpl for *const c_void {
> +    type Delta = isize;
> +}

Are all users of this guarded with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
well? Or do we want (need?) to cover the
non-CONFIG_ARCH_SUPPORTS_ATOMIC_RMW cases where someone tries to use
this as well?

Best regards

Dirk



