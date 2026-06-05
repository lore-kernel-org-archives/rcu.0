Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFD2BEFE5
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668253; cv=none; b=r13zxUwxduX+/RSJZHRgxBzHBt2kezmX9DjmeJZNuTFfveGPtKEoOtQYE9vsYLV+anBGQojKlxTvSiICLFiezlbWtXIlv1uEdFNY6M9QrDHf+AZfpBVa2XovJkpqnu8U/8XtLA/Wo/dCgNvA+50fm66yojgtYyYekSVpwpclYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668253; c=relaxed/simple;
	bh=nE+jrhG/ppYv31sfWuxQUTVFQS7am2LwuFIGyuBECqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AmhJ/nK/obDAkiI9BJ/oNz5v2oKgD4TpiSAoKQ15WaWqFpdxQ/tE99pmA5O4HOa3llf/AXa73PPa5oRryozqN8SumJ0rcKzAKBVjaO5bISSiCRJLK72sgpu4z9h8oD4XI0Rd53hIyT/vnWoiSabV6uIRK80j0YplJcD1mLol/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUoXzFnC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUoXzFnC"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so17915935e9.0
        for <rcu@vger.kernel.org>; Fri, 05 Jun 2026 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780668250; x=1781273050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzxQflFVSTadDNXMRobclacHPyZHXHcPR4PL2Kdl0Ys=;
        b=GUoXzFnCTBFfQI6dDid1XcZGmj7m2tSJY7WIFu2ckaLvRyF1aJ3fw4aMzPHvtGcze2
         QZtE3FTt88bH8jLLG1WFqSHA/WaYnVcx0syrgdlApwIkmT2ctoQ/OQjyqsGo+RH6LiQp
         t7dpVTiDiyi7PgEX/QK6OsVfFBqUjVXFWJ723rkfFIrHKbokTUMlKAgtrgZ0/oJn387Q
         UcevcjD8fNoA7vlfqBVR+FMkgvu5bbPMiHEBbZJD89PGagrKGuUSBHzUdl4LiwLDbMYc
         YKYiHNxind5lwKlIPAaCkYY4Etop/9jnA5MbnYuFV1ESvHOVoBN5q0Y3mPR66YR7KzSp
         v0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668250; x=1781273050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzxQflFVSTadDNXMRobclacHPyZHXHcPR4PL2Kdl0Ys=;
        b=bwtzEE9FreU1hjURHrAd4L/GZCpEVY9XnuVDlmPFaRsY8bq3aapM3/8QKhJj0pS+Z8
         XnedBVvJOs3PwJBU3kz0YT6kdiqTQRWIMHZF6LEVcQmyrXSH3Qh/LjfTWgMGrh0n0VFE
         YyYKbw5x/drTwk6jb+V224/bz+S4qjJ1Tqa7bC3Z4+EYiMdyP9dfbVTsgMdOJwAwfdOG
         dyPSTGS3kbgk/HC7gqY2Jgh97XWSDM9VdP6TaHc6wbooHsSmcML5+at5rMc0NvBy7ioz
         l2AYgMjXk55y8j8bDclJu4wwUJA2H85ReeMMO+ubgWL3DKEdgYZyA5rjwQkKZtXnhljL
         xOHg==
X-Forwarded-Encrypted: i=1; AFNElJ+iQXKAaxdv5ujGE4Tn6EF1wQpHs5h1btgLjCYhsnH8ZgYT99y1E0mKR+CdQiWSRUXxLK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCH53qh5vUSjW0tDPW82jmLxeudo9kWLFzJQ8DbVfbg3wUht26
	NCtPCUenoTGOVIvhy9B3qX3So2Q/7Gul4elfDuWSRaVXpLyFROXb/AAs4nn6oSBTOmD7DllmJwn
	mEgXqAP7zbygppila6g==
X-Received: from wmsk10.prod.google.com ([2002:a05:600d:848a:b0:490:acbb:67d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d1:b0:490:b9c3:6c62 with SMTP id 5b1f17b1804b1-490c261007dmr52711405e9.28.1780668249942;
 Fri, 05 Jun 2026 07:04:09 -0700 (PDT)
Date: Fri, 5 Jun 2026 14:04:08 +0000
In-Reply-To: <20260605133541.22569-6-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org> <20260605133541.22569-6-boqun@kernel.org>
Message-ID: <aiLXWHg22P6OTb7O@google.com>
Subject: Re: [RFC PATCH 3/3] rust: rcu: Introduce RcuFreeBox
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Philipp Stanner <phasta@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Content-Type: text/plain; charset="utf-8"

On Fri, Jun 05, 2026 at 06:35:41AM -0700, Boqun Feng wrote:
> The current RcuBox will call the `drop()` function after a grace period
> inside an RCU callback. This suffices for maintaining a RCU-protected
> object:
> 
>   RcuBox::drop():
>     call_rcu(
>       |..| { // <- call back after one grace period.
>         T::drop(); // <- call the destructor of the inner object.
>       }
>     )
> 
> However, to support a different RCU usage pattern as below we need to
> extend RcuBox:
> 
> 1. clean up the object, and unshare it from future RCU readers.
> 2. wait for an RCU grace period.
> 3. no other RCU readers, we can free the memory.
> 
> An `RcuFreeBox<T: RcuFreeSafe>` is introduced to provide support for
> this:
> 
>   RcuFreeBox::drop():
>     T::drop_before_gp(); // clean up and ushare.
>     kfree_call_rcu(..);  // free it after one grace period.
> 
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  rust/kernel/sync/rcu.rs         | 31 +++++++++++++++
>  rust/kernel/sync/rcu/rcu_box.rs | 68 +++++++++++++++++++++++++++++++--
>  2 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index 7da6b8d22277..7c26591bb318 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
>  
> +use core::pin::Pin;
> +
>  use crate::{
>      bindings,
>      types::{
> @@ -82,3 +84,32 @@ pub trait ForeignOwnableRcu: ForeignOwnable {
>      /// [`from_foreign`]: ForeignOwnable::from_foreign
>      unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed<'a>;
>  }
> +
> +/// Declares a struct is safe to free after a grace period if all readers are guarded by RCU.
> +///
> +/// # Safety
> +///
> +/// Implementation must guarantee `drop_before_gp()` makes sure no future RCU reader will access
> +/// any part of [`Self`], as a result, after `drop_before_gp()` return + one grace period, no RCU
> +/// reader will be on the object, and it's safe to free it.
> +///
> +/// Notes for implementators: implementing this trait in general requires `Self` being a
> +/// [`UnsafePinned`], i.e. a `&mut Self` is not a noalias reference if `Self` has non-trivial
> +/// `drop()` function.
> +pub unsafe trait RcuFreeSafe {
> +    fn drop_before_gp(self: Pin<&mut Self>);
> +}

Should this have an associated type for the rcu-safe view?

pub unsafe trait RcuFreeSafe {
    type RcuView<'a>;

    /// Access this value in a manner that is safe after
    /// `drop_before_gp` for one grace period.
    fn rcu_view<'a>(self: Pin<&'a Self>, _rcu: &'a RcuGuard) -> Self::RcuView<'a>;

    /// Drop this value in a manner where it may still be accessed via
    /// `rcu_view` for one grace period.
    ///
    /// # Safety
    ///
    /// All other accesses to this value must happen before the call to this
    /// method, except for accesses using `rcu_view`.
    fn drop_before_gp(self: Pin<&mut Self>);
}

The idea being that once you call `drop_before_gp()`, the value
immediately becomes unusable as the type itself, but you can still use
it via `rcu_view`. The `RcuView` type can then be a type that has a
subset of the type's methods that is safe to use for one grace period
after `drop_before_gp`.

If you define the trait like this, then PollCondVar becomes RcuFreeSafe.
It can't be RcuFreeSafe today because you must not create new waiters after
`drop_before_gp()` is called. With this modified trait, it can simply
not provide methods for registering new waiters from the RcuView type.

Alice
