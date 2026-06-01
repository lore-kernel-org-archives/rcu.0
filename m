Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BC3A5E64
	for <rcu@vger.kernel.org>; Mon,  1 Jun 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320140; cv=pass; b=tqfCivYgBQ20zXVqKfP6UP5yNSmw6ps6H8DWhIQHNj/oYREy/2r1GaL9PMSR5jYar8L7wpvFCuezvgVamh62zIp3VxJmOMNBVYKsRVKQD6JdMzqz8PJyMM4G4lzeLav5H+0dh7GvBoUlnpaojfSK3n9TL4nSC2jHzq0qhR3TAx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320140; c=relaxed/simple;
	bh=hooQptWzIagr10ERwCvMM3wIaAqGBRqHrg5Oq8PcGtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nweP5ZOpElsWWmyqlLL0D++jURD2/bn/WyR2oeROYpuy+pgjHQWPb95UNSn86Jtfvyd2FtXJD871nuKT9W7fNRlyFtUm+ENjVFgV2KXUN63IWKMs8eB75XDG9NuigSb3+Xystd7znbR9FreU9eUrIN+lyr9CHsNmyEjPzsizeY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fn8WIA5Q; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fn8WIA5Q"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137bd9ed2b1so984775c88.1
        for <rcu@vger.kernel.org>; Mon, 01 Jun 2026 06:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320139; cv=none;
        d=google.com; s=arc-20240605;
        b=QcjFcQzV9apZwcJfddPnKm8x6ZN4WsspPv+rzRCz7ixM2d64zEfGKT1c9Vfsr5s1Me
         1P7fZcdoFtVWkNpL02wWkeCiuy/ViYzaRVljTiSEcr/ZxoJTmvXErkNZ7HERXEx5OJ9e
         XmK8yOJCXC/dRFFbodJfyFzmN1fbqY5PbCFjgQwqJvuQDGKiQ6duQZiIxoh7cVUjWRbL
         /RtqDaDJuEKFJSU7d2Z73i0qLMyM5wzgP5qLR3TgCCa81scAFVo0dABHVjxVxQ0/AB3X
         XuCwV69Hw43gKFYPVXF+3O6tHF4MnlEBSgrUXcoB1oSRGhSwa3WAMl6ZX5a2TCxfvXv3
         h+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
        fh=iQ6uRbM2XkoNx3UnNf441sBSQws4Z4LnB6gTnROjM+s=;
        b=MQ7gwPhNC0AiePX0NsObbEtat7wTyezLkiooqSPCbJ0ww427X1WEAWIJeX7lByQkmI
         jHM9heZNJprwskDcnjB2WSYIGci54UvrqL8kSbCXqtFM90M+H4deSsP7ooOSPdOQHubZ
         ibcudzHSjT9WYA+1Z8lQGyvj7wrjzRcPWVph0U8Thwn9iNGPGTCyfLugRxfAf4LDDIIj
         T3i+rswn9QhqSKcAY1vzCOsCz+WuNh8OYRwdFPUG6kilchSr6I6XGkXA+OHrkGyO4GoG
         PJX9Ng+RzUKvE09ws149X3gWrbJ2YjFZfNFNGXkj0rVa/20a5sBT1Rlwcv22UCpgqjya
         4VJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780320138; x=1780924938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
        b=Fn8WIA5Q+Y2ClGXgyIdeUPVzxGWnsfQuzt3WFISNhOntumBd1Iay+qddrddPo+TxEy
         HF0YYQMv690pWfrPZ4ycnKX3Qe41U4KQMzIHMj1CElsGdeEqwlhPOzOxkh/9HeiINwiL
         W6wSfasw2EtlGOLUB9I3573yFXT0QHFja5RGLiamH03qcpglRxle+S/PhAV5tjp1XL0V
         XiODihY6jkUrVmaMvvCmoKaCVWvs+4A4HP5HYVxws9uHBKhuVNyjj8IUAWByTsN1hDPn
         3dWuxmuHQ8vE/RypioTniKLXYusHDUqs8UBdi0wUoEGotRTVb9/WcXG/PHOCedgm6YhS
         ZD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320139; x=1780924939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
        b=aBVqfwWmknfzrDc5FcCmyyU/46cZ2nBbkyyafSGRtKRUEzzx5Uh7cEnIUQl4fOytgE
         pMp91Ge4JfzH4dI36x/dJ4otpAqKOaDnjF1mTvVcQzJQ8cVocwYM/pRC0aOQT46N6PdI
         nLRQezHG9ZOj2+wlDjyLO//SnbLuCqtjlVKWE3T5P9gKG6a7G4+NusYuPMTq7/iVlLl7
         i3vjPJxn/hmOp1r/GYDFSm28lHJHORexkHIJVO4BxTApUIJD+JU4TepbL3f785dVrxhH
         Va8+jVTV89FmODVWAzqsdflLhfxb6OO07525+LmcZ0e648Y6lz/cNguM5k4TiY84WUPt
         0gnA==
X-Forwarded-Encrypted: i=1; AFNElJ8tammDpFEbuh87kf5ytDYZ4gATPQX3tjpd2Ek2FW5wnKZfDrt7s99NBlB2uMqJe+PA45U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8sopINTQBoGsNLdBHjGa/aI60AE3RAhipATOsk4jLEEuDrQ4
	H1Cdvwy/4ufqun7/qzSc9S8XB4O7qAUuOZ0lNqyu7lqALeH3mJre1jR3Rr2fCLOjjHwFQPUCCbk
	dNrY2rxSjpfxP3TG9OKN/GKt2NsU5Pl3sfDTh2PMo
X-Gm-Gg: Acq92OHj3wET5ljp6LbJKGQdDg8etnV7IkQ3Q6E8nfz83ScWUeee91i2qF/Tcnrl7SP
	aH41HN0HCH+vmlcp+hofiM+VaOru8f8b4CFR8LVckYFHszQz9dQeGQLS1D7d9H/5/ULRpgpWuCH
	FippN9qKspioGmqFe3NQXYTB9WWnaziERImfIsbrlh53IvN9dtOjR1dVheFlCM4IamoiqE3hMV2
	wZlzmi4osjd95UE2HgRGWl4s4f4STfMo+Gd8oTglOqRcyMV4ouKWnMSYYNxahpAdqiIJ/iMe0y/
	M1sEoZQuFKgploZEnuuWXYlmnvSrYxcwxkTy0ZR872rYlORmr+U+UzZa8bMGlZzxY2BxZsu0LwR
	ysTA=
X-Received: by 2002:a05:693c:2c86:b0:2de:cc07:e99 with SMTP id
 5a478bee46e88-304fa49ce00mr5489017eec.7.1780320137881; Mon, 01 Jun 2026
 06:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org> <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com> <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
 <ah19ZVkr7b3m7V_u@google.com> <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
In-Reply-To: <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Jun 2026 15:22:02 +0200
X-Gm-Features: AVHnY4LWfDXXY2MTx1DqLyh8Hxwl3ZS8C8Evk9p1Nisz1mt4W-Tdk9DBxhQXUfk
Message-ID: <CAH5fLgiZb5fqfXGQMicPp+UbBi3JMN8ZNG_Ldt5KiSk+btVCSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Mon, Jun 1, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> On Mon, 2026-06-01 at 12:39 +0000, Alice Ryhl wrote:
> > On Mon, Jun 01, 2026 at 02:26:17PM +0200, Philipp Stanner wrote:
> > > On Mon, 2026-06-01 at 10:36 +0000, Alice Ryhl wrote:
> > > > On Sat, May 30, 2026 at 04:35:11PM +0200, Philipp Stanner wrote:
> > > > > +/// A trait to enforce that all data in a [`DriverFence`] either=
 does not need
> > > > > +/// drop, or lives in a [`RcuBox`].
> > > > > +pub trait DriverFenceAllowedData: private::Sealed {}
> > > > > +
> > > > > +mod private {
> > > > > +    pub trait Sealed {}
> > > > > +}
> > > > > +
> > > > > +impl<F: Copy> DriverFenceAllowedData for F {}
> > > > > +impl<F: Send> DriverFenceAllowedData for RcuBox<F> {}
> > > > > +
> > > > > +impl<F: Copy> private::Sealed for F {}
> > > > > +impl<F: Send> private::Sealed for RcuBox<F> {}
> > > >
> > > > Why sealed? Just make the trait unsafe and require the things you
> > > > require from the user.
> > >
> > > This is far better. We definitely only allow the user to pass A or B,
> > > and only then it compiles.
> >
> > What if I have another type that I want to use here? For example, maybe
> > I have a struct containing a copy field and an RcuBox. Or maybe I have
> > an ARef<_> of some C type that uses rcu for cleanup. Then I must edit
> > this file to add support for it?
> >
> > > The unsafe implementation could be messed up.
> > >
> > > I thought that's what Sealed is for. Or isn't it?
> >
> > Sealed is for making 100% sure that downstream crates/drivers cannot
> > provide their own implementations. But I don't see why you need that.
> > All you require is that the value remains valid for one grace period
> > after cleanup begins. As long as the type satisfies that, you are happy=
.
> > An unsafe trait can require that sort of requirement from the user.
> >
> > I think what you want is expressed well by `RcuFreeSafe` from this
> > thread:
> > https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/top=
ic/Consolidate.20.60PollCondVarBox.60.20into.20.60Rcu.2ABox.60/near/5987267=
24
> >
>
> I guess this is a question of design principles. If you demand an
> RcuBox, you have a guarantee that it's safe.
>
> If you demand an unsafe trait, you open the possibility for people
> messing up.
>
> Due to the unsafe-contract you'd have moved the responsibility for the
> soundness to the driver.
>
> I would not want to block your suggestion, but I am not sure whether
> that's really the better design idea.

Yes, it's a design principle. You are saying that if someone needs to
do X but might get it wrong, we should take away the ability to do X?
I fundamentally disagree with that principle. Unsafe traits is the
tool Rust created for the exact problem you have; marking places where
you should be careful is the entire point of 'unsafe'.

Alice
