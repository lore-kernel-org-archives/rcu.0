Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF937DAA8
	for <rcu@vger.kernel.org>; Wed,  3 Jun 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479346; cv=pass; b=SDbfQ4ii7IJFRb721yA9lYMHQriH7TrQKeBdeCu+uj+KgPuDIcNk9VCaWeIGH32Q3BQviLvG+XFINh1YQUf2V6UPYFvR0kicDvYMzHzEqq2eWprlTIvBibNQDArQlqZTPKQbnXU5l4ICIW+k+3EuvsCx701RTLffMOJWpFT2WOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479346; c=relaxed/simple;
	bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Boq0uwG7ruD3jMnRu9BL4D+lPEGbn7x18c1SqOxYX5t0hZ1mRQz0K6Bz+rtrRu6+7FNh5uUuE57Jj/sgPEu2JlJ+qhJf/RHbjcLQZ6czL6vteV+Kh0NwCsNvDPrXIWCxS9Z+D7ejZcUzXtRsvc2j+fDjaLF41ayLho7OtLoPJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiV2P4f3; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiV2P4f3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so8581655e9.0
        for <rcu@vger.kernel.org>; Wed, 03 Jun 2026 02:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780479343; cv=none;
        d=google.com; s=arc-20240605;
        b=OZV0bu/KSRA/wXRmpIB6HG1Suex5AgSGQ/VLHacwEd/SkiTxbhLvOBCDaCwXvTeUqk
         k8dJfyXhGYsd7BVoe04yedQjMJVuRz3UbHOgscXR5i8pam8z1qCpNYkZqzmTffHSMoD6
         786vgY3jrfvvnPfcsJ/hC1bxLV+/GtTMR0WvPJS0AfeEbo+W/DeeCGjbvHnFtA0+hSPv
         TV617uDCAhnmTn9bUQFstKua4Zu+CqOmhPw0rhL7XgcsLdBRY40hjuzUTGPCL+b1Nq5f
         RHQQYF3hmJy3zR7azGFjwqkv1DNWKZzSbSo3yXp8vJ8CPT9XvkOIkAGekLRog2Oudq3b
         NyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
        fh=OQLPBLx4zlTA49UTXugt6+86jHusW6IhVh0n6f3ed3U=;
        b=XOVJScpXhkszjJ5BX4DFYpvX98rL5CFrx0GCjGuGMzfH5lAJKTUE1/nmchvlhJdxY2
         iYmyOhXUGssXls67EaUOe7nL/NxsHv1gTciylV9j9A5uD89cHGfiZmHgNnjoif2crzRP
         0c5GphG1DGUzN2EeJwoWLcpjjbs225mQc8Qa+wvq9HJc+31J1MKO8TGcttGvLf6ghcOL
         dDRNhgad+jSea3q6ycbJu7lMG8M+aq10/VoV9BxDZVHnIEJBE1b5g1uqpI73x3He6rVG
         E1ZIYTBqgumytZAWfXsi2mg2ZmQbJM9GTa5ryvnAmVSzTPfOLO4+EHmVqWG7xBtQzWzk
         0r6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780479343; x=1781084143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
        b=GiV2P4f3PopCt4Y3ZQchR9NalsW55dkf2SjcvmJGXIYL71soDe6I7mW5dqve9FlqFE
         GOL1V6LhpSuHQsjNOHvy3BXc708CCd+HmZtuV6hQbBI9N5aRRzL2U+0bjW5BTQumMph9
         GG9+4jSZOSUPxVhYpNhLwKNI6vuQ4DtVRZUHiKIqheF1BVAdjnUhvOJz2bLTVmydCAGr
         iYE/DDYNRtMAf8Sxq1XB1IvgHlZBdfJ010h5AazpE2PhnDEchXhXwFLsMoLh6UMU4RFe
         1suDTdsGtchHFLd6nyWxFzQHcCWYr27K6NeCzYSOvFlrypOmZMC8zYQwORsE6zPU/1qu
         V6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479343; x=1781084143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
        b=R9VLPZfKSCW+9+s3OZPzCniM9WbCR2i+jetssCmc/TRVjnrG8iWgzhLbkbrvSBdKOM
         DWuyjMjM/ovXuQLTBkbRV+gnEbW4GqpiC41Oq9adWm7MUWKUuohusDyYJbT5tJX7GTgm
         X2QVJeAD7mc/P+BxxLT62+lIsiwqXprSCnXc3hZwFIJoo6o+ZQuAaK15z/27Mb7fdIdG
         zW1bFshBYkPXbQXNkghc3/nnswWp3PSCPaKBpYs3mQKZP87kpMMFjNR+9wdAnSWy7Z5o
         fMI3Yv8wWe19mhcP0aQW+G02C5sUQ1iE/ErBkyZvmYUxBZ2vfDbff/xOrY32Uqhcl9dl
         YkRw==
X-Forwarded-Encrypted: i=1; AFNElJ9tyoz8wtwBFvGngvDUGM9VQZPd2l8UCON91P4wayqJ4oT0uRryjmPkw1bRjCTxa33k3gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84/Qa6zmSUQyA/u8KT0R1Kc+Xgewrk+4fVgOcDtwLvlbG7R9I
	6qRafiMVDsUQRN4u0DRrMdnDhcYk5Z0jDMc9tQgNXYXB+/C0h7tnTLEWpMEYOIRvUfnEPh96mt9
	0Ox/OZDVAk6X7Y4yurr60nRwbw6AvQOztfh+QXlQn
X-Gm-Gg: Acq92OErdkCgF1FZsbf2osfPZzEh87XmoN8JzJsV+CzARpi38WOSVrBanfsE07iicLT
	igKIttX+Xp6GYmwhwyuZyOwUzQAfGiEJpJBziOKaiq7yIPTiehEaYbSZJKvm5jyTfw8x2B1vhJ7
	q0y/g0qzdynBdKG3jSyqJZYTTPe1ugmspPy9MKZHZH5R7WB4bGCSey2amM6lwFSwdQesoJEbp8O
	Mcw+VJZnqn0TNGQK0PhlpJwDE1/oxpvHwgFFPPirCV+em2R/9mu7CsnovU1FnSnrBZO+gIMaK8a
	LeQFyqD+l5+seVeK1jyizyPXE2cTRr1DNlK/0s9FXrS7BTXRSZ2wQTljrXCcVUgCAsI0ZH/FYqE
	3gA1w
X-Received: by 2002:a05:600c:8184:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-490b5eb44f8mr43679475e9.15.1780479343116; Wed, 03 Jun 2026
 02:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org> <20260530143541.229628-4-phasta@kernel.org>
 <ahr9gtzQLSbPeBx_@tardis.local> <e8b16f3b40d42f3b0a8814180fa9b06f82c9d901.camel@mailbox.org>
 <ah2L-TMT5UHSd_Hs@tardis-2.local> <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
In-Reply-To: <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 3 Jun 2026 11:35:28 +0200
X-Gm-Features: AVHnY4JfNUks84z0WqzXiLep0aUyPzGhK0pYIVWREZIpQzivqBZzfg4IE8o75iI
Message-ID: <CAH5fLghA5LfV+=r4-LbX+gaNo6v_-gSdcXOJHa76Lc74WCJ5JA@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
To: phasta@kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai <prafulrai522@gmail.com>, 
	Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:33=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> On Mon, 2026-06-01 at 06:41 -0700, Boqun Feng wrote:
> > On Mon, Jun 01, 2026 at 09:56:23AM +0200, Philipp Stanner wrote:
> > > On Sat, 2026-05-30 at 08:08 -0700, Boqun Feng wrote:
> > > > On Sat, May 30, 2026 at 04:35:10PM +0200, Philipp Stanner wrote:
> > > > > From: Alice Ryhl <aliceryhl@google.com>
> > > > >
> > > > > This adds an RcuBox container, which is like KBox except that the=
 value
> > > > > is freed with kfree_rcu.
> > > > >
> > > > > To allow containers to rely on the rcu properties of RcuBox, an
> > > > > extension of ForeignOwnable is added.
> > > > >
> > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > > ---
> > > >
> > > > I have the following on top of Alice's patch. @Alice, @Danilo, thou=
ghts?
> > > >
> > > > Then we can have:
> > > >
> > > > type RcuKBox<T> =3D RcuBox<T, Kmalloc>;
> > > > type RcuVBox<T> =3D RcuBox<T, Vmalloc>;
> > >
> > > No objections by me.
> > >
> > > I just think we have to decide how the treat the namespaces, though.
> > > Probably Alice wrote it like that so that it's very apparent that thi=
s
> > > is not a normal box. It still breaks the naming convention in my
> > > opinion.
> > >
> > > rcu::Box vs rcu::RcuBox
> > >
> > > With all other subsystems, naming like that seems not allowed.
> > >
> > > dma::Fence vs dma::DmaFence
> > >
> > >
> > > I probably would allow the user to decide whether he wants to just us=
e
> > > it as `rcu::Box` in all his code.
> > >
> > > But no hard feelings.
> > >
> >
> > For this I think that rcu::RcuBox is a bit different than dma::Fence,
> > because Box has its widely-accepted meaning through all Rust code,
> > while `Fence` doesn't. Hence my current thought is rcu::RcuBox and
> > dma::Fence. My personal preference is using namespace as much as we
> > could until there might be some misleading.
>
> Yoah, probably better we're safer rather than hyper-consistent.
>
> >
> > >
> > >
> > > >
> > > > and Philipp can use the `RcuKBox` in this patchset. We also need to=
 impl
> > > > InPlaceInit for RcuBox, but that can be added later.
> > >
> > > So shall we merge my series with Alice's patch, and later we add your
> > > patch and other features, or would you prefer to have the additional
> > > boxes from your patch from the get-go?
> > >
> >
> > I would like to have it from the get-go mainly because of RcuBox vs
> > RcuKBox naming. Thank you!
>
> Fine by me. Just process-wise: how should we do it?
>
> I could include your patch on top of Alice's. Would be a bit more
> consistent regarding the git-workflow if we'd squash the two patches,
> but then you two would have to agree on authorship.
>
> All is fine by me, but I wanted to ask instead of just do A or B.

Squashing is fine with me, thanks.

Alice
