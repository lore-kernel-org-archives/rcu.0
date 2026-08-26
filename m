Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2E26B95B
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718014; cv=pass; b=dlA41igUQCT3WLRdsOGh0WqqPiHD3Z6XwXurk6Z+cetpWEyXtJ1imKKoBSBseZl2aCOzn6JIsyFeH8Ux4UobljGJPFSj9BvSXA/+lyQD4kHnc5atTgHIytPZJwAh9CduI4z54eV3+yAGmoe4rciS/SWxlYR0qRE/Mg4UUKtBj5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718014; c=relaxed/simple;
	bh=D1nk2qvUAEZS8QbDlL7McXKxIL+Nb4XXOhmGZeBYxLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipHzdOLnzs/K7/L9nhVD//lRrhz1wQh7xZYb4Ow1HEIZf4O6iqJh+tibY8RuZyziPLMpdxvpibIhHYFA+1uqO+tKBLKZEgxN/DXqPDV+mlljt1sljihbjXBxqTterm4gKnP+N2XiTeDWraCwItNekSPu6x1QQTpmi2w1/LyObUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qos4F/99; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qos4F/99"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482e257a23aso234647f8f.0
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 21:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787718011; cv=none;
        d=google.com; s=arc-20260327;
        b=mD4ywTrVO2bZB2MmZ9/C2+UlXEWYkuqIdMFZUNxyvMDsbPAnXjzyWqQsnVAsn7OagR
         rcFH5WozBs1c509fRjrBiKd4mT6BSNK529xIK1gjZ6KFcOhlKGrHyORmtOygZke23h5g
         M813nat8wFJdu8nxRS+Z54S0HZZbOXvWhD6FzZCBtNDLgbib4mXW3PCMHibPZOhprGxG
         kJ0Owjwnd7g6xyAf+tv3ouhGSsGeT6/GKZM29Ks6WHl30cUpzjKAELwhDYK6P6ti2X0o
         d5APleNYRx+6+b137IyIRxcYM2Cg5YRGlG92qlQXbKQcrJ3e9CL1TYl2bAc/2bL3oW5T
         Xw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        fh=Z9B48urzv5GpX2XQMfJsOfYuH39vudoO1qqgqRpmRig=;
        b=EE6CBdfDfzTrqjy5d756upHYL56yagcsZcrIrTXajh/MCmGggzUscFfLzfMRH/P5AA
         Rivf7htFGcwnzTmj6W1in6+2ckdPBxb02qMOj3XnG4acK6iK3VyeEuY2o59p+Kl7XN9i
         EmhHUSbIKPayARP/Fgf9pmbAhsstHvOXXtpOT8M8fpkpdFp7egbjyTqqtzDfKnDI01zY
         SyeCWbYIVrRCBIeBfX2y7KuYgpORGwEanP0fmE12eRhr9y0Iyxal6i4gitSRSD4UbiVU
         bPeDXMrPiWQFk/3JT1obJ7JBei1usi8gWvX7ee0dNX5JLieH/AejOO/+G2Xe33X2YHZ3
         AMwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787718011; x=1788322811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        b=Qos4F/99BxbUJc3xwYarX+r2AjD7dbp8Ku4vZdnKS8kEFntYRuOfTBcAWZYsrVEiqx
         H6w0TOnK5fv78cV6UCPWMurnkEKLAKfggbTcYn4+Pq9VZeZaCnFJtxzIaFiZ9RcIE1NI
         YWqv9jhcblldAzVi+IQL7Ezje2FuhG2E17ZRGDIO74zItzPBs8nF0e4rWxI0vwwo1KpF
         YAQSlluMDUda2fsPHSWTs/4ROQnOjc1l5zQYRfAJfEhzDJPiUmotWjokDoKPzFzpkAtY
         TcwFkkFL8IVIN6Qc844sF9NaxJCQlqU3H56sHPsk+4u7zsz5tbnKiXX/AWxImR6uYK+R
         cTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787718011; x=1788322811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        b=LW93o7JTPDzgOgpKQwN5TqdAqRQ0KwuH6pWYL64ux3+ijsiTmfeYHdYj1uNrRi9QCH
         ++j6eKv99FMe5aoBuGhzdDGv9APsOMDrwP5fmc+zTH2KZCLywN25/kQ2rlWMhlqjKlvx
         zZiTk7esQWjDKW8KegbQO56CPivUFvvBLQ4DRUB+LZS8Z4rVBWHhmXP2q5LHlKQpNCIn
         OOCwm6a9bDut5eadctQPVBXxwl899s0OHrE1b+KUwAJZX4zGdAG3KEhLx8Zj1D1+V2B9
         GaLTPgvleFtbc8vS8IggLcuB09k/ZSv5Il7/VLcSQpZrUnhepJ8Cxaaim4QkupiUBFHB
         zEdg==
X-Forwarded-Encrypted: i=1; AHgh+RrWRUa6vVlwxpNxnuWHyFEDdPs0xJAVQMb60LGMLKQ41vQElEgyzMmswgDMYIFgwUJVq4w=@vger.kernel.org
X-Gm-Message-State: AFuF++ltC/OKIfv3XSHryZ48sL0fKVVzqz/lIq4uAtOL/XvPBeGqjJrO
	ob9+cW84hK0v3xcKk8ufw3e4DXGSyUC8RGVLF2sFGriSPsbfuX17ndlMPTFdG5VQK8ekURu5FPy
	HaEh7WEIXdpjubbWVhIwAxjXM2cmr5HE=
X-Gm-Gg: AR+sD11vpN+XGFfuy3dxl4gemLDiHnN9ZEQGu3rd0PENJpu8fmodlLUPQUfHkSYxh0/
	8rJHCjYK1X0XG/o12Y9m0Nli6GykFBWQ2iM9ZZpLOqZAgVohcAfla+FY1P7hr6YssoVXqmJYCBa
	QOfW6NfGeWYcNNbd5hV+ypcmS8Wd8Gc4pegcmqCaWmsavPAFa3O1xvkydYNoyNK6Y2rdsjM8Zuk
	dhA9i9OLO9MmuZHSVXHjGfUT4r1R12P3yzwlsYUqQ9oY+7jbeaK8FgnAq1XM8lEeyWRVrpe1fwb
	4mbW+E6arvlGaOMi3jLpIUO8lEdP/x+DqsOrMGYM/TF/Mx0wo0jNPZQuPUWDc3wlTEcfqNnqL/l
	P9w==
X-Received: by 2002:a05:600c:a0d:b0:499:bdf1:7578 with SMTP id
 5b1f17b1804b1-499dc6e9b00mr31193105e9.3.1787718010248; Tue, 25 Aug 2026
 21:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821032210.792451-1-kunwu.chan@linux.dev> <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
 <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop> <ef7c880f59eedf0cd2f2b26842016bbbc2b68a06@linux.dev>
 <d2bc6a2e-37da-495b-b27a-30324f327b9d@paulmck-laptop>
In-Reply-To: <d2bc6a2e-37da-495b-b27a-30324f327b9d@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 26 Aug 2026 12:19:58 +0800
X-Gm-Features: AcwNN1Vy-Kcef335itiOvd7r2OGI51aoY7vQkrbyMxmvvgeQjBDdDhEM7DLNSg0
Message-ID: <CAN_Opa_=_S=mjDW4_b6Q_4x3LQ3WSV3iVZkT3ZSebZaFRkm8Jw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
To: paulmck@kernel.org
Cc: Kunwu Chan <kunwu.chan@linux.dev>, David Woodhouse <dwmw2@infradead.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:53=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Aug 26, 2026 at 03:26:18AM +0000, Kunwu Chan wrote:
> > Hi Paul,
> >
> > I'd be interested in helping with one of these. Are there any items
> > that are not already being worked on and would be useful for me to
> > take on? I'm particularly interested in the Tree
> > `synchronize_srcu_atomic()` fastpath, if that part is still open.
>
> Please feel free to give it a shot.  The similar fastpath in Tiny SRCU
> is a partial guide.  The trick is that get_state_synchronize_srcu()
> and poll_state_synchronize_srcu() need to keep working.
>
> The commit that I just pushed to -rcu on branch "dev" seems to have a
> working rcutorture.  Seems.  ;-)
>
>                                                         Thanx, Paul

Thanks Paul,

I'll start by looking at the Tiny fastpath and how the state-based
synchronization APIs depend on the SRCU index, then work through
the corresponding Tree fastpath.

Thanks,
Kunwu


> > Thanks,
> > Kunwu
> >
> >
> > August 26, 2026 at 7:49 AM, "Paul E. McKenney" <paulmck@kernel.org mail=
to:paulmck@kernel.org?to=3D%22Paul%20E.%20McKenney%22%20%3Cpaulmck%40kernel=
.org%3E > wrote:
> >
> >
> > >
> > > On Fri, Aug 21, 2026 at 12:53:22PM +0100, David Woodhouse wrote:
> > >
> > > >
> > > > On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> > > >
> > > [ . . . ]
> > >
> > > >
> > > > When applying this to current rcu/dev, the patch also needs to acco=
unt
> > > >  for the additional bool is_atomic argument to
> > > >  check_init_srcu_struct(). Please rebase accordingly.
> > > >
> > > >  Ooh, shiny, I hadn't spotted that the atomic thing had landed. May=
be I
> > > >  should retract my 'if we get that' above... but let's see how it
> > > >  survives.
> > > >
> > > It is starting to shape up. Here is what is left, that I know of, any=
way:
> > >
> > > o A bit more work to get rcutorture to put up with atomic SRCU.
> > >
> > > o Tree synchronize_srcu_atomic() fastpath.
> > >
> > > o Disable preemption.
> > >
> > > o Reorganize commits to fix the Tiny hunks that got applied
> > >  in Tree commits, and likely other similar issues.
> > >
> > > o More work on error checking for use of banned primitives
> > >  with atomic SRCU.
> > >
> > > o Update documentation.
> > >
> > > Not that it matters, but atomic Tiny SRCU seems to be doing quite wel=
l.
> > >
> > > >
> > > > I also have more than just this patch to rebase onto rcu/dev =E2=80=
=94 unlike
> > > >  some, I'm not just hacking RCU for the fun of it; I get my jollies
> > > >  elsewhere :)
> > > >
> > > >  Btw, the current commit c68271c3f83a message says "no index flip, =
no
> > > >  grace-period sequence update" but that isn't true of the implement=
ation
> > > >  any more, is it? In fact, it *always* does those things, and doesn=
't
> > > >  take the try-path optimisation by counting both epochs, that I'm d=
oing
> > > >  here?
> > > >
> > > The current "dev" branch is here:
> > >
> > > dc5bf5c8fb26 ("fixup! srcutree: Add an atomic Tree SRCU").
> > >
> > > Tree SRCU always does an index flip, though a single index flip can
> > > serve multiple concurrent calls to synchronze_srcu_atomic().
> > >
> > > Tiny SRCU has the fast path, but must advance the index anyway for th=
e
> > > benefit of get_state_synchronize_srcu() and friends. It just bumps it
> > > in one shot.
> > >
> > > Tree SRCU will also have to bump the index, but will be able to
> > > do so manually, without doing all the grace-period processing.
> > >
> > > >
> > > > Thanks for the careful review.
> > > >
> > > What David said! ;-)
> > >
> > >  Thanx, Paul
> > >
