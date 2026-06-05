Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905503DDDD8
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671262; cv=pass; b=OUYBolHvuD/Ropzto/x8DUcEZeUE6tPlqosstTMq+o9CyVULvA9O0Bm9I6hSBAK4n68oZuggFzZLC2O58iyVVhkQN9QaO79kZNhkCYVbN3uqbrIhmfBTKyZPFeUn27dOvlafRw1a9JgS2f+t4Z4w5Vw0YFBzx73qhUeqkLOWm7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671262; c=relaxed/simple;
	bh=5U2bHCSeSFtZBuKuVq8W81kjSD7uabbhoCN8hd/76pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arZFytNN5hrdY0lXo2jvgWq3PrrIZq//nG4QYQdF/V8Katg3+XRAVlZgx+AblwoVfmPt0FSuxftcQrpIZuUHYtcU3IaajaSiXHFe3AiLAPqlUjHTS8aVtmT57pvN9vTgz5RoVrcC71ntUdIARXb2Aid5EzczeuleVoDknW0GFD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wShIty/h; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wShIty/h"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1392417f8f.1
        for <rcu@vger.kernel.org>; Fri, 05 Jun 2026 07:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671259; cv=none;
        d=google.com; s=arc-20240605;
        b=lWNFRTrmDClQ8Q+8lkM/kP/vFfsTi7HgL1CrTL8zBnJjXedMu+yrckj5OesF43D8MM
         bWVU2XzG1sP92Zs1NVdfaWj2ft9sE4cUI7tF7Vojjw7znLEs2qN2jdgWx/U/7Ma6o3mw
         nTJZEw2jP2MRmXrriGUSiNPzXhK6ZDADulIXtl1Um7Z7JUZQAUkKA3VLyoberkG+9gHc
         VaMVSjUMa72YEe8UBLZlVYgXjLZEyBtDgqe6gLoA86GvRoGfh2GErHClKEP+Mq3dJWpE
         Csp7aMUoLTN4ObPOkZkZ6S4kIOrdupwZnKEXZzC68QNs+z327/NjO9RLEaEydqbSkt+w
         gTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
        fh=u9xkUXBpjPrfvh9KBf/mC/oGIkzlQyhGpfP5ApRcXDw=;
        b=bucVXNfK37A2cqYBNYFk3zXSP4Cnd37SBmT4ezWmWZpp7Jppg2aZIQOgotHZ+BIWAt
         wwjuEx5RQ05XKQ+Mi6cDmMkuF+Zdu8ClSIxi5eqyEFPqNCdwwXusuX6/jBBpnv18l4Xo
         FjTdR2P1tiExBESx4ezcr7MzPJWqjzCKCuAq2Z1Sg1rvn70jjLz5A+PxGpTMpwznIFEC
         VVkN73UKVmSx6BlDV9vlfSl59DEZc9G51mqZnZvHcF2QTCtBoxlYC/R57QB4icazyRzK
         iKlCG+mN/5kOEn5quL8Tbd+kQANOPiMBfOiDpIhU5orfmEzAPAHTZmenqB89W56Tht8r
         tLAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780671259; x=1781276059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
        b=wShIty/hqg+rPx64r/atcg+EYvg/Z/F6FlaKQqHXNbAfO88S4Ki6U5lF/sspBOvceg
         1ffkhGqDQ2f9AEHLgZTPRw6PQXj3nuOis39774CMKK8pFAMrtSE51RxZw2Dz1yRKCr6J
         if04owCusUMW1YU/gwcN9DY3YoTDVMYwBz9tzU1nMuF8AmR3WWpOra3xH7ZHXob0t5YQ
         jMGSBFP1PNeTcE/WGDxGEBba5gIWV6w8wymlU25qxKN40g17YHq00G8ORMj5yC4pIwvk
         4OVcenW9LVSdoaVbHSnarY+orrApqBvOmZyRlHtjXvGm+9+CTGe4KViUGUIao32gfvEP
         PxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671259; x=1781276059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
        b=OZDpo8loT2R1KayM9ZFBS4mMlx7xiEX/hON59uPElQpM0x1N/cBxTtDdJX52GbkXFs
         6BK/c/bfhfaFWxyR+jXrEvBSIaMpgtmp51zJdSo9jkXBiLduCMfoGBK2WnlVXm8ljM9n
         i2R1gsdZEc5TvfFwectgnW2yu7t+4uO9kp5h1RCm2sCnnJF8GlSkYUKm90dfgOrVn0an
         AyKin0ynaxaHsjfpbmoGeX0TNSA2C1nczK7AYeWLQ6gPoBUushlA7qGmlaqH28g7LPZW
         SwaAZsO5gbISc3Lop0b4eR/vVUVuCgyZmLyOV/zS4E1Jd6CAG2siqug57n6LI3bzSCQs
         LlwA==
X-Forwarded-Encrypted: i=1; AFNElJ8Js/sCpimfIz+vUCy0Nm7JQeZXZjfgcQ0vzwZCKd1zRHoroavkiUo13FiPoqmrvwaEaKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYd2J06wrGAn5To0WEwzJ7IfoPaiYZrXg+D4u9nvk1LkCjMTJ
	2ox/DZe+XasecChuc+5wwufVdBeg8uQGhGXZS2zN/vMZbjHn1fWLKzuiPZwfHRlChYGcG7bZ8sz
	jwT52T0ubqESicCBfjmtq1Ch5h8d1rUW9pmAp+sHO
X-Gm-Gg: Acq92OGuylTmATt58Fad83SAj/vkM9BVU50kZeWjwFKIVYfNF8E5lF/K/oNjZudkwV7
	T6VrewiV3fnHd/uGYtu470vziPEhSLAFmnf9GhFcRoPj9r2Su9GOonLFYWO5lXQgZ5GSuMPiVZw
	BHwh9oejqmGUhEcQLOZwXzF0YLvB2WGx+SE8Qi3Il8n+yk0e4ABlpsuVQJ3uRF9FGI/VU9VxMoX
	/2RB4YF419L3MHwAMRoF1VqAIK1r/c/Bh1omr3ynloWJP0OJ4fqI67VvDhxPc3U8K5bZ6lKee/K
	mBp+bER53ysPiuilrRKkTjlv4f8D6IwGMGH9MjSrdR2ndg1Vm1Vl2FuqADA=
X-Received: by 2002:a5d:5747:0:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-46030762e2dmr4902991f8f.35.1780671258380; Fri, 05 Jun 2026
 07:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org> <20260605133541.22569-6-boqun@kernel.org>
 <aiLXWHg22P6OTb7O@google.com> <aiLbOd9BkRrrzauk@tardis-2.local>
In-Reply-To: <aiLbOd9BkRrrzauk@tardis-2.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Jun 2026 16:54:05 +0200
X-Gm-Features: AVVi8Cdg9vKBauMx2gFlTcbSb2NA7zDY8I7EUodYwLM12r5vWqTj6E3w8SCGnp8
Message-ID: <CAH5fLgiBayr6S5ijfEdXNgZqaZvFbKWqLvVEsVePmrBybqDZzg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] rust: rcu: Introduce RcuFreeBox
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

On Fri, Jun 5, 2026 at 4:20=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote:
>
> On Fri, Jun 05, 2026 at 02:04:08PM +0000, Alice Ryhl wrote:
> > On Fri, Jun 05, 2026 at 06:35:41AM -0700, Boqun Feng wrote:
> > > The current RcuBox will call the `drop()` function after a grace peri=
od
> > > inside an RCU callback. This suffices for maintaining a RCU-protected
> > > object:
> > >
> > >   RcuBox::drop():
> > >     call_rcu(
> > >       |..| { // <- call back after one grace period.
> > >         T::drop(); // <- call the destructor of the inner object.
> > >       }
> > >     )
> > >
> > > However, to support a different RCU usage pattern as below we need to
> > > extend RcuBox:
> > >
> > > 1. clean up the object, and unshare it from future RCU readers.
> > > 2. wait for an RCU grace period.
> > > 3. no other RCU readers, we can free the memory.
> > >
> > > An `RcuFreeBox<T: RcuFreeSafe>` is introduced to provide support for
> > > this:
> > >
> > >   RcuFreeBox::drop():
> > >     T::drop_before_gp(); // clean up and ushare.
> > >     kfree_call_rcu(..);  // free it after one grace period.
> > >
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > ---
> > >  rust/kernel/sync/rcu.rs         | 31 +++++++++++++++
> > >  rust/kernel/sync/rcu/rcu_box.rs | 68 +++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 95 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > > index 7da6b8d22277..7c26591bb318 100644
> > > --- a/rust/kernel/sync/rcu.rs
> > > +++ b/rust/kernel/sync/rcu.rs
> > > @@ -4,6 +4,8 @@
> > >  //!
> > >  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcu=
pdate.h)
> > >
> > > +use core::pin::Pin;
> > > +
> > >  use crate::{
> > >      bindings,
> > >      types::{
> > > @@ -82,3 +84,32 @@ pub trait ForeignOwnableRcu: ForeignOwnable {
> > >      /// [`from_foreign`]: ForeignOwnable::from_foreign
> > >      unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorr=
owed<'a>;
> > >  }
> > > +
> > > +/// Declares a struct is safe to free after a grace period if all re=
aders are guarded by RCU.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// Implementation must guarantee `drop_before_gp()` makes sure no f=
uture RCU reader will access
> > > +/// any part of [`Self`], as a result, after `drop_before_gp()` retu=
rn + one grace period, no RCU
> > > +/// reader will be on the object, and it's safe to free it.
> > > +///
> > > +/// Notes for implementators: implementing this trait in general req=
uires `Self` being a
> > > +/// [`UnsafePinned`], i.e. a `&mut Self` is not a noalias reference =
if `Self` has non-trivial
> > > +/// `drop()` function.
> > > +pub unsafe trait RcuFreeSafe {
> > > +    fn drop_before_gp(self: Pin<&mut Self>);
> > > +}
> >
> > Should this have an associated type for the rcu-safe view?
> >
> > pub unsafe trait RcuFreeSafe {
> >     type RcuView<'a>;
> >
> >     /// Access this value in a manner that is safe after
> >     /// `drop_before_gp` for one grace period.
> >     fn rcu_view<'a>(self: Pin<&'a Self>, _rcu: &'a RcuGuard) -> Self::R=
cuView<'a>;
> >
> >     /// Drop this value in a manner where it may still be accessed via
> >     /// `rcu_view` for one grace period.
> >     ///
> >     /// # Safety
> >     ///
> >     /// All other accesses to this value must happen before the call to=
 this
> >     /// method, except for accesses using `rcu_view`.
> >     fn drop_before_gp(self: Pin<&mut Self>);
> > }
> >
> > The idea being that once you call `drop_before_gp()`, the value
> > immediately becomes unusable as the type itself, but you can still use
> > it via `rcu_view`. The `RcuView` type can then be a type that has a
> > subset of the type's methods that is safe to use for one grace period
> > after `drop_before_gp`.
> >
> > If you define the trait like this, then PollCondVar becomes RcuFreeSafe=
.
> > It can't be RcuFreeSafe today because you must not create new waiters a=
fter
> > `drop_before_gp()` is called. With this modified trait, it can simply
> > not provide methods for registering new waiters from the RcuView type.
> >
>
> Good point! But I guess I could keep RcuFreeSafe as it is but remove the
> `RcuFreeSafe::with_rcu()`, and this should be sufficient for
> PollCondVar. I do want to wait for a meaningful usage of `rcu_view()` to
> add that, but I think your idea of that is great. Or maybe you have a
> potential usage in mind?

For the dma fence, the fence context would let you access the name c
string via the rcu view.

Alice
