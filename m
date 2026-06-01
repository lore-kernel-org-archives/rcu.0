Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF8379C23
	for <rcu@vger.kernel.org>; Mon,  1 Jun 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320444; cv=pass; b=HUAHbHgyoU2U0ZiBKTh2oF2amsb4i1WVErmKh1BGQVMtyRfKrOcPao5ofuSbFGo2JqLUmYZqm5YjEepMbOe9pagfIYQpikJ0cNWh1SpM82LDbU4tDP6tQpf8r7pLvlclrnpNHs0DZLBlLpVWJ/00plR21kg1RFBF4/CscBnaElw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320444; c=relaxed/simple;
	bh=0DHOe9b8avRmAIwuEFXwH9kNoZgOYx6xrIy5spz3Blk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAtnQR8Dyqr60Tp4zCYiwOgYN2MsFIuioiZ2r4obvSFbOkSkeK5cdurt8FCyoTveqQ3lz09rgD72pmQ8OaFebZ8cpb59Tmsk6FZdzGQccp57o+iUGPlAjGdpFro9eiZ1DhuldDgAV6qBhLLtLYd4kkSpb1p4n8OC0WJl05hil3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXDg5SCS; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXDg5SCS"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137d452574cso2984562c88.0
        for <rcu@vger.kernel.org>; Mon, 01 Jun 2026 06:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320443; cv=none;
        d=google.com; s=arc-20240605;
        b=YJc7yrcV5paPatkTpFcPLDigJBJYTR8cS/MQZ5J9EeAb/XBEa0PD6ZxMSfBC5J+Q1y
         Upd6de074hlbztB58B/1Hx8sILSsbM7/2R5ToWv/cJwahf7ocAg32z+rvB51qadW6LLq
         z0MXNbZ68oqEeJVDCZAUneGjijz9ZSVmFZygdPpHqMT65xCIBmP97BK0PfXgb5Ji5XBj
         XSqDEHx+2egWYEBbRNYWnyLI7u8rYBVYZYoEpg/kXE4GUTdU7VNqr7VfRe9d9Bl+sgmd
         EDBtSkpNFPseYMkRgfwugjvYdCpECIbpux9QtZ1rL7uNoFeID+lma+4DAudVmjb+gx82
         X+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
        fh=jyeEor+QMVduI0lFL83qDKbxaM4WyM+6apykEra5fTc=;
        b=P7PEIl+zHVcdSqLLZUGkQhkJ78VBsqHTh7pk4y8q9GACogQ0SqLoYm7bQsGGKqRaXF
         NGkTyjfsjJkoF0qWOkkRF0fLxKCt6Dn5DoOJIzR+Ul5kPc8qOWpK3d3RQcfMp0I+tci7
         9Y19lSyy2RGyHJdxsGIUFD91c89kG8LMfBvdxblycPzmuy3CDbfLvjOOP+aL0v1hlA88
         HzHcasPELOHiu2Lo8nl1th1QXmJo+vTvX0nvXdoEDIf7K0OaMKEKR9W6ahIpk6PT/SrP
         /YTCwfAaNdxvSuz85cCJq4AZCIxe7xOyv5lzW9+mM+lTTO8YZecrqVUhIOLYpCZptbY5
         hPZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780320443; x=1780925243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
        b=TXDg5SCSou6mYjLgaemgpRZui+wsrunxm5OJNtHLuGhKlhLxhAmtPJKAu4D8gsJzk0
         6tskCTEPsg3mkCsBE2KEiLSkhhZdPNOL7wAgratiKRNnR9ANgUEYGhePRPlmdxo/p91K
         9WKwwF6I0SpjrNQ7Px6upPb1aFPwE8IOt8I6GQAc921fz5lFaK6PohTsl2bKPWsNoc6/
         sE+dVt4B0Ai8BJKlaWsP90Soj5ZJiIARRng3e3h3yZ04T3vv6V7C2RWLgUYaVYFzKrVS
         WWA0f3XBudqMuttATaUdI9vhYdmNpw8YL81ycbJ8wuMy29efefctmBppwCkl9Mk4qReq
         EdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320443; x=1780925243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
        b=labH5eFC1NMDH5lBPN/0uoP1W8c0uP3zyoNhShCAwrtVBAys3jZvXw/OxHJi8iiSYG
         V6vDWZgbjp1lG+OWwzd91vTa3Fq7xWDwqthjR+rsop/+C5qn0K5gHNp16Cu9+CIDc3mW
         vCPsBrYwHzXckBcLRrkS4oTr7Hl03YfySQmfL5s/vdbgeR28M+zWi9HVUs15FApF+qZo
         xCxds9HawIyNUMCC7BTzwp8wn2fN/xfqNDkTXTZ8eU/FhVdasikEWZyCQ2zgBUYIAYuJ
         BBmDbEJVgFtaRW4aBExMJZbWWuTn59H+aR6NSpG+gcXy6JtRSJ7x4Gfq9yvhwWZsKzxa
         cJZA==
X-Forwarded-Encrypted: i=1; AFNElJ9qsCj1cGr7qngxP2ypr1ww3wi5wzT2udg/fPJ64TU44n84+mFcFl89KB/u8KKr6zFa5+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKr9/VLa5t+AApVxwWZLIpgOD8CNU4hqASEY1kYBvq4uzGZbz
	NfBqhn1A5GvCOv01vzx30SlhdygbBy0pWaGLKSAFn2kZm0PLmlQcPMZfCeBCsVmOHfuPJ4gL/59
	1IC3/1yanO4HEzIYW0HxNN8MDptZwh23F+yJBFI3g
X-Gm-Gg: Acq92OGIz4E/i0I8ntSoZuGI/kVV7A+zEkysC1BGqxnaPb5qmDuUIY/Z0rw+mjcolU8
	AskdhRfdkF06uixal5r6ajr3YPeVWb+TMItH6iw2qqIEAevj8VOLSUyujNrPuj2+GB23ebAL+gU
	5tC6J4vd71DgMvOMLX9n7VLcShmUvjphj/Xs7lUkWjxeOuHckFadEP7Sr5IQrcR7qHyKNq/SQIp
	+l8gQXW05BYDDq4eGVJ5qqVSfYbPRQXL3Yh8BgupbLKDeFthZZpSPFxvbclqvNtpaRgGEv+uQ/h
	TpkYTk8XX3n8v2dTj0oMlwHX5MArTaDbwICMm5Hcq6TBQCzB4SDfqcn5GIYnieOCQgQficbsVL9
	yh20=
X-Received: by 2002:a05:7300:2201:b0:304:d8cb:8424 with SMTP id
 5a478bee46e88-304fa546886mr4919952eec.9.1780320441610; Mon, 01 Jun 2026
 06:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org> <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com> <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
 <ah19ZVkr7b3m7V_u@google.com> <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
 <CAH5fLgiZb5fqfXGQMicPp+UbBi3JMN8ZNG_Ldt5KiSk+btVCSA@mail.gmail.com> <3829028571be1886b99018040782ef94369b9523.camel@mailbox.org>
In-Reply-To: <3829028571be1886b99018040782ef94369b9523.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Jun 2026 15:27:06 +0200
X-Gm-Features: AVHnY4IJXBoMvh-rw5Yz6dkN_FCzB34R7ldudBtNs3IR1XQFjKtmqNv3cEC-Bt4
Message-ID: <CAH5fLggFHp6bLZ-g8aTQKY_sHRJ0aEmB+-2XWG3RMS1yBXO+8A@mail.gmail.com>
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

On Mon, Jun 1, 2026 at 3:24=E2=80=AFPM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> On Mon, 2026-06-01 at 15:22 +0200, Alice Ryhl wrote:
> > On Mon, Jun 1, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.=
org> wrote:
> > >
> > > On Mon, 2026-06-01 at 12:39 +0000, Alice Ryhl wrote:
> > > > On Mon, Jun 01, 2026 at 02:26:17PM +0200, Philipp Stanner wrote:
> > > > > On Mon, 2026-06-01 at 10:36 +0000, Alice Ryhl wrote:
> > > > > > On Sat, May 30, 2026 at 04:35:11PM +0200, Philipp Stanner wrote=
:
> > > > > > > +/// A trait to enforce that all data in a [`DriverFence`] ei=
ther does not need
> > > > > > > +/// drop, or lives in a [`RcuBox`].
> > > > > > > +pub trait DriverFenceAllowedData: private::Sealed {}
> > > > > > > +
> > > > > > > +mod private {
> > > > > > > +    pub trait Sealed {}
> > > > > > > +}
> > > > > > > +
> > > > > > > +impl<F: Copy> DriverFenceAllowedData for F {}
> > > > > > > +impl<F: Send> DriverFenceAllowedData for RcuBox<F> {}
> > > > > > > +
> > > > > > > +impl<F: Copy> private::Sealed for F {}
> > > > > > > +impl<F: Send> private::Sealed for RcuBox<F> {}
> > > > > >
> > > > > > Why sealed? Just make the trait unsafe and require the things y=
ou
> > > > > > require from the user.
> > > > >
> > > > > This is far better. We definitely only allow the user to pass A o=
r B,
> > > > > and only then it compiles.
> > > >
> > > > What if I have another type that I want to use here? For example, m=
aybe
> > > > I have a struct containing a copy field and an RcuBox. Or maybe I h=
ave
> > > > an ARef<_> of some C type that uses rcu for cleanup. Then I must ed=
it
> > > > this file to add support for it?
> > > >
> > > > > The unsafe implementation could be messed up.
> > > > >
> > > > > I thought that's what Sealed is for. Or isn't it?
> > > >
> > > > Sealed is for making 100% sure that downstream crates/drivers canno=
t
> > > > provide their own implementations. But I don't see why you need tha=
t.
> > > > All you require is that the value remains valid for one grace perio=
d
> > > > after cleanup begins. As long as the type satisfies that, you are h=
appy.
> > > > An unsafe trait can require that sort of requirement from the user.
> > > >
> > > > I think what you want is expressed well by `RcuFreeSafe` from this
> > > > thread:
> > > > https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/Consolidate.20.60PollCondVarBox.60.20into.20.60Rcu.2ABox.60/near/598=
726724
> > > >
> > >
> > > I guess this is a question of design principles. If you demand an
> > > RcuBox, you have a guarantee that it's safe.
> > >
> > > If you demand an unsafe trait, you open the possibility for people
> > > messing up.
> > >
> > > Due to the unsafe-contract you'd have moved the responsibility for th=
e
> > > soundness to the driver.
> > >
> > > I would not want to block your suggestion, but I am not sure whether
> > > that's really the better design idea.
> >
> > Yes, it's a design principle. You are saying that if someone needs to
> > do X but might get it wrong, we should take away the ability to do X?
> > I fundamentally disagree with that principle. Unsafe traits is the
> > tool Rust created for the exact problem you have; marking places where
> > you should be careful is the entire point of 'unsafe'.
>
> I mean, fine by me if the others don't disagree.
>
> But when then do you ever really want a Sealed trait?

Sealed traits are a very niche feature. The main use-case is
forwards-compatibility. It's not a breaking change to add a new method
to a sealed trait because no downstream crates could implement the
trait.

Alice
