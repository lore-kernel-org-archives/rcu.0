Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC65320A04
	for <rcu@vger.kernel.org>; Wed, 15 Jul 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124564; cv=pass; b=u57SKO/F+3TUb9+d86+2laVOETVzc3/oiMyF5Jw6mFreM1HSFzVyQrzcV5A5+K6FnQDS/8O54eTebPNWXvcqIn4ib0ItFyg54zlMPxjh1YuQKGVwWALKcO8HAGjjosKSwSn7aEVfdKXVCj97UkNLQv7YNGkEyKvCK+MqsNGS+yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124564; c=relaxed/simple;
	bh=SNqsn1X2G8kP/+EM1dJk3CmM2TUfgksbckY1LKNvZHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUV6JVTrVdBHFijRbzwPorj+MOEzQ8bpIa7GxknySGL2ChBp/DIeqnadRrdIOaWKthbz7GUoaSRq51TCBtaVYufqFpM5+n16Vam9k88rxRTKK6Wsl3HnyKw1uleh35GXXmYnDmiCKXUCF2yJUfYcCk4o8WPhVhLtXdJ9ao7TvhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaSfAw47; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaSfAw47"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c7902f47so46474835e9.1
        for <rcu@vger.kernel.org>; Wed, 15 Jul 2026 07:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784124561; cv=none;
        d=google.com; s=arc-20260327;
        b=SYPU/tudvWHWgZLclmn3j9Rk5+qTrX2CbdN8VsstdhmuSMInVknt7PjtJ7zOw6gJhc
         QwXJIhpfj6WxueBH2TrbnbGGEJxYsia0iU5YHobWVNSsMSJt6m5MQ/O8n+LV5jlfwVTe
         ouyrr/ELWai/X6Akf8RNVta92kJHxFHTQhkYjgOLqFCS0nyDjlqcwnuZ9dV481PzBRI8
         uHs3s9AcVflAvrbkejn5yjn383lqBhY7pYDYmYbcIddNuLk31DPY/QaIhVm8WY2bbG/C
         HrAQ+RySWSoy/cYZcV5FXP8fyQbutWhXOfTsfpuLrJTzr5487hj/jthZmEBw+1BalrXy
         tDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
        fh=7s5QI3PFzXmcORrDvBKiUIPTXaoFbMlmAmpoT8JINy4=;
        b=iFASko3L6sTFGXwwJEflEIi/Rk7LfbtldexEzs7y4SJJsGVgbTQ7ydm5/CkRBGbtyB
         ePyUmOaw7l4zZPU2L425to/NpCo0nzq862rGaSWIdZx/qZ5oItaxUwVwBHmubAr5BAiF
         rmdnwzJFpDYj+OTVHJEZUY1PdUeF4R1vU74eqkaJFGlGyhvghJfwaxtmiphJ8bgTAn8k
         YNmp2zt6S8OKap0415IsIup+7Gk10M8OezVI2jeau/Dyw/fPPceRIS+TwpiSAoB1V5SN
         Z+8QtNcnxe4GabSrxqmxtAu+e7iykBe/RcNPykOjdMilAlDhD7qn7d+YH4484O5+z0rL
         UDtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784124561; x=1784729361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
        b=UaSfAw47mfe2To7mpkFVmc5n0JVKld4Zp9BlmAHPqKKjxaAcOi8Gc53dGuMtjTJkot
         30OkIQx/GnCqe1zn9XcxNT+x5qXde9tenGtZDyE4It6anCRuW/ZjtNCqrLfWi8K/4fnh
         IZXtQsK3I6YA2J1hoa7mLqfndnPAJPLGyJOJMkp/h8KOTYBX6cMrXxXNMT4fdByR6CGN
         BSG6+u7Y733zuJuayhDf4DZiXRLfsEq6m9/ZcPk1pBEPRhEsQ2kfqLapk2yODzQEiVVN
         LpoMEYzQZ4oaZ7Gg8QZuI/uIWZiu9JfYSv2atUROZuUEa9OQZxdVEuXf3eJrDSv7nZJB
         JCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124561; x=1784729361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
        b=cfmxh/ja9/VQHm3kUz4LFJq8rniQFNihXRMyYjxEvT+skpqDU24m2rEeIm6KCGuzD+
         eW8ucd1aoPNN+mLis6WJFPcPf6WJp7Ccol+n0J4p04ILb31q/Zmknh8KlVccKPMsEolH
         +PICfX2eAY3W/REuvlDzvQbrFSNbU1QITAXxqMHfFONTLSndX2gFfi0VIeowIMgyvnBi
         VrHGyVbKFp/B44qNpAIMQkx7h/wGFkSYtnd0Ejjx6xFcIa7+6WQvtE3TqQ+3QL+HnD5v
         c9tWlk2hh7EoaHbRTqVG6aPncB3hvR3on325ht5oknngqck4c85XvD4gphDg+z5n3y36
         cBLw==
X-Forwarded-Encrypted: i=1; AHgh+Roy09qZPGTgRmRKrfp7/VLzhMJMk/qNLWmlZ9XD1eImaUItlule1fCtTT7AKSMiv0KdgUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiGBRuJcAQvB2DgsGOtGA9mrfvns/VoYx3ChDNmWb2i5JApVs
	lNghH8glqHeZeL2djGqmNxX+nybk5c7kOU6uON7ixcRwKlyrZ3/P5EIuGbk5q3bvc533GoIDfE9
	wBcPtMecP6JSM2/ERi4OmxKap7HsP8ei2mAKDGe5f
X-Gm-Gg: AfdE7cnvQy3YLRmJVXtaxs1IIDlSc0Ypbxy1aQeHqmO37c8rO8Ntycl0dsffMg/G6/z
	yfgvP1qIb7DkoStS7wPq5VGJuWg2Q78tU4Nvco3+WqOSAFZ4KTjPN6/axcyzdXr+b5ni9mPsOlY
	UG2TG5FZ8N6j6U7CF5+h1aQ2ocDMTzAvY4+wtM8MBGhq9ooDfDnFUrSqWM8iIw7Pt5xiJ3TBmNx
	bxhOQUzsbJb9ZkkeyMDOeuMbnR+8/7fQxPDMotVcCSwueoiQ+2FD+eX6For+pNnvd64YbLjf8cE
	lul73I2ryGFatY/vJoHZrO0SI84=
X-Received: by 2002:a05:600d:8443:10b0:495:404b:85eb with SMTP id
 5b1f17b1804b1-495404b8636mr4530305e9.26.1784124560869; Wed, 15 Jul 2026
 07:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org> <20260605133541.22569-5-boqun@kernel.org>
In-Reply-To: <20260605133541.22569-5-boqun@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 Jul 2026 16:09:08 +0200
X-Gm-Features: AUfX_myXsOMxqzySIL_c6wjy_KTMgParE-LvwcdXFSkdOBkOsDSHqrVd6QhTOvc
Message-ID: <CAH5fLggHxeDMm1ygYEGPpjCdfRD8nEsgN31WMvjX3mMPs5p5yg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: maple_tree: Add load_rcu()
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:35=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote:
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> Now that we have a concept of rcu-safe containers, we may add a
> load_rcu() method to MapleTree that does not take the spinlock.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/maple_tree.rs | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 265d6396a78a..1499191b8935 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -16,6 +16,10 @@
>      alloc::Flags,
>      error::to_result,
>      prelude::*,
> +    sync::rcu::{
> +        self,
> +        ForeignOwnableRcu, //
> +    },
>      types::{ForeignOwnable, Opaque},
>  };
>
> @@ -233,6 +237,54 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
>
> +    /// Load the value at the given index with rcu.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Read the value under an rcu read lock. Even if the value is remo=
ved, it remains accessible
> +    /// for one rcu grace period.
> +    ///
> +    /// ```ignore
> +    /// use kernel::{
> +    ///     maple_tree::MapleTree,
> +    ///     sync::rcu::{self, RcuBox},
> +    /// };
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<RcuBox<i32>>::new(), GFP=
_KERNEL)?;
> +    ///
> +    /// let ten =3D RcuBox::new(10, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    ///
> +    /// let rcu_read_lock =3D rcu::Guard::new();
> +    /// let ten =3D tree.load_rcu(100, &rcu_read_lock);
> +    /// assert_eq!(ten, Some(&10));
> +    ///
> +    /// // Even if the value gets removed, we may continue to access it =
for one rcu grace period.
> +    /// tree.erase(100);
> +    /// assert_eq!(ten, Some(&10));
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn load_rcu<'rcu>(
> +        &self,
> +        index: usize,
> +        _rcu: &'rcu rcu::Guard,
> +    ) -> Option<T::RcuBorrowed<'rcu>>
> +    where
> +        T: ForeignOwnableRcu,
> +    {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_load(self.tree.get(), index=
) };

I think this is only legal if MT_FLAGS_USE_RCU is set on the tree. :(

Alice
