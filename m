Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361F3D25AD;
	Wed,  3 Jun 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506853; cv=none; b=arZ5mNDbjMCShiOLhBmemznRKirTF00w1swLyeZRACo6FXYm7TJ8tgkgF786458vV8slK8M2TOeDfYlw0m0JQ9dKHCDXMt4RD9gwkCy3sXM+FSkZoLgTgKoKy1M+xARehqFNczykF0q+/Q9QVK2x7YSf7ncx4atel3y0mTEOttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506853; c=relaxed/simple;
	bh=TLmekHM3EmmxpFvVf0s2ub+Xb1oU8p/GBNRtuqGNaWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JktrVO84nGZ/lvIYRW2FvxerIsqTYGDl+IOhwkMMdDpWRbC1kgoblhiidtulOydwhyztXyH+pYx1khii6N7LPdguKuDG8MyEgxoAanXn4PxA8tgqQPgvMokkAv0Z0Lpp4Ngvgs/V2nqsJEveQ1oCpb3D8hHbQ1P99PhneFVjFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=axVI2v1o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="axVI2v1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780506850;
	bh=TLmekHM3EmmxpFvVf0s2ub+Xb1oU8p/GBNRtuqGNaWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axVI2v1oU/IIMKtn8X01EBEvuFuOLnOM54apTBHtHP2lQNaDvDltdf3Mde3xDboLu
	 5PF0kH4s8L9VjNDKIawb74LfJJWXmGaOzeF1zLQf4paiY1MU9Fg48onr55L+Ak3C8G
	 mLbg4vgV0L5ufHjNtLWU3GzDo6UkwI9PvIt+0xKtW27/6moaWiv9Qo5SkzMTQHK52Y
	 O32VNGIJ/wbtBBB+ckEX1eAnQHOFLsSxhilyZSaDEAE2C/GvXsM7p35rQDSGVxOI57
	 xFXL5sgkzS5K99/iAAf5x62loT1VeTEz8pFwcAjtBNpiPOAnYassMd6yX+qgWAQAwS
	 Vnti14waWdv6w==
Received: from fedora-2.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57F2317E05FC;
	Wed,  3 Jun 2026 19:14:09 +0200 (CEST)
Date: Wed, 3 Jun 2026 19:14:05 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <dwlsalmeida@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Korotin
 <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Alexandre
 Courbot <acourbot@nvidia.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, Shankari Anand
 <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
Message-ID: <20260603191405.4c75badb@fedora-2.home>
In-Reply-To: <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
References: <20260530143541.229628-2-phasta@kernel.org>
	<20260530143541.229628-5-phasta@kernel.org>
	<4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 13:41:02 -0300
Daniel Almeida <dwlsalmeida@gmail.com> wrote:

> > +    /// Called when the fence is signaled.
> > +    ///
> > +    /// This is called from the fence signaling path, which may be in interrupt
> > +    /// context or with locks held, which is why `self` is only borrowed, so that
> > +    /// it cannot drop. Implementations must not sleep or perform
> > +    /// long-running operations.
> > +    ///
> > +    /// An implementation likely wants to inform itself (e.g., through a work item)
> > +    /// within this callback that the associated [`FenceCbRegistration`] can now be
> > +    /// dropped.
> > +    fn called(&mut self);  
> 
> This is a central point. We ideally would want this to consume self, because we
> may want to move things out of the callback.  

This one comes from me. The rationale being that ::called() is called
from an atomic context, and the resources attached to the callback data
might require acquiring other sleeping locks to be released, and
sometimes you don't even notice immediately because said resources are
refcounted, and the lock is only acquired when you happen to be the
last owner. Yes, those can be caught at runtime if the C side is
properly annotated with might_sleep(), but that's not always the case.

If we defer the drop of the data only when the FenceCb is
dropped/recycled, we're at least not constrained by this "runs in
atomic context" thing.

> 
> Consider a fence design where signal() consumes self. Now consider this:
> 
> ```
> impl FenceCb for MyCallback {
>  fn called(&mut self) {
>    // Can't move the fence out, so we have to put an Option<T> just to be able
>    // to move.
>    if let Some(f) = self.some_fence.take() {
>      f.signal();
>    }
> }
> ```
> 
> This used to be the case when our version of the job queue used the "proxy
> fence" design:
> 
> 
> ```
> // Callback on the hw fence
> impl FenceCb for MyCallback {
>  fn called(&mut self) {
>    if let Some(f) = self.submit_fence.take() {
>      f.signal();
>    }

I'm pretty sure lockdep won't like it anyway, because this is nested
locking of the same lock class. For such proxies, we'll need to teach
lockdep about the nesting like has been recently done on
dma_fence_array & co. But I'm digressing.

> }
> ```
> 
> Although this is not the case anymore, since we phased out this design given
> Christian's recent work. Still, we should ideally not require Option<T> here in
> general just to make resource transfer possible.

I see. OTOH, don't we need to make this inner data movable if we want
to cancel the FenceCb before the fence is signaled anyway? And that's
most certainly a case we have in the teardown path.
