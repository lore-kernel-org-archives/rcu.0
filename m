Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0B44C652
	for <rcu@vger.kernel.org>; Mon, 24 Aug 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586694; cv=pass; b=Mgu3ETTc/qzE3/ZbhOef7AFMYmbjQiRFENKPC2/Y7v8WuqeL2WErFGbo9Z/lBVKLMyVugN1DFB0iC71R4MMT/EsKAAPFov1b5wmvEgUZwCyRnhRTyMAuUs8rVWdbla7ZMI3otYJQipN2T9HQedP6RnTrh441DNMciVLqitooHUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586694; c=relaxed/simple;
	bh=sBSAv4EkTd8DKEcxJQbtwQ6P4wI0iZ+8eiNq8EFTT0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2lg2bnvT1M23vSPuGGHSJEOwXx7e6U4sFUnsKsE1hLHhdsF8PebijjqLxApOlJYqKfOHCZ3QI+FgWVfyycZkqFmTxxPq6PCfUwDP2wDixO4fvLDJT8pGH5moXUCGWVblwjlIc78shAZND+liTshp3o9idrnZ1su/NHe8LNBxsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS145Y8D; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS145Y8D"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so650661666b.0
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2026 08:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787586690; cv=none;
        d=google.com; s=arc-20260327;
        b=ndsz+8q9QDW2xUTldP2sVolOVK0E/fnJOr0HfgxEZ4ZBJs/DRx1u5Adko6od+s3iXA
         M8Z/CD8JdnhfO45zBJHQd3SuzPrIp6wIqp1AHHTVpMaK3M5JqcMY64FwE5iUkokkHCZn
         hxUCJpvYkkc9Q0Hwdn9AdYJ2b4e1jmSpPJtQj8yeyDdkD01RBLdf69e+DLu7Dy8u8Pog
         2xOq7djqmfB7VgBz1amCJNCMkoSZCXi0MpkTUDIWmDZpNEkd6v8vw5T3ZOpnOolbx51r
         NAV9LgtjXiXVVeciN3fgR4gMkYwETEJ0PTBTgg7co4wDrikGuM+z8E8NgkpR279YvH4Y
         ClMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQiW2ywPDLYfrD3ul9Z5RDPRzs1zZ4Pk+mj/Dzx2uhI=;
        fh=mkDehLQK4pdJ6BZ9KGim5ABsBolNjNdltJVdctbHvp4=;
        b=dNhaTS2EyV22hWrYu2xL6WJo9onzzlRJeH5/R1XQ+8T8jtla/wc6a8rNbQxBDvkPFx
         OpiW5R9fHnkisUqOEIyurRtpvMRPBWn9VrK5JA5yQfrxnglfcP06HZNU/ZFsYmiEWrz+
         JFa0hoM6VpvZ4TxE9ubwPC3WMHWar6qi3TrALIBZAATx7GxvueQ/IsQyXkS1El3iLqzH
         EDH9tmyzcmqoUoFo7pO/43dvloRyhFy+LKpgBND/gzHD7wHfQy9Mf0XBVW60DkODpwQ4
         SjNKnfYcbW/GfKKh6ONaA3cUQ+4w7UW/Anmejbw7bYqxsj5FeDg7CiPl6CYb/PIKboPQ
         qzXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586690; x=1788191490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQiW2ywPDLYfrD3ul9Z5RDPRzs1zZ4Pk+mj/Dzx2uhI=;
        b=XS145Y8DZnVG3rTeNPsmT9IQ4S19bIH1qsYOXItqtvQb4orkKJHWAIhyS400Dmr8Ab
         oU55Za76UsflALzg0S5j8BZVfrq91bJOoGGo+ohrHbduH0HPNs8WbjS25MAFXW9cjFpB
         VHrjmka/NKf9HzFitma6tq5n3hqObRBfSF+tNRuAgbFYrfHeT+r+e7bxbz3km0vFV3GN
         j5zFOa0jk12h+qiWQTD6cZxtoeRzWBimwk24xFdmbDB3m//8wlGIiVpnjmX3IdoJE6oT
         rbGPcX4M1zgdA2zfJERdyLv7Xfz0/dYgyiBo0Y1YPfo4D6PmGSC6xHaq6LDDOyCseUe5
         KMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586690; x=1788191490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQiW2ywPDLYfrD3ul9Z5RDPRzs1zZ4Pk+mj/Dzx2uhI=;
        b=AmI2lBXUgntwEiISg0efGslYmdnTLxP1BmKlFyxoJqyafdy1YoJFG8I5Kgc27DdV2+
         ykQT0J2JeU3mkzcNcvlwCvbKVoKsc5ycq1R3sZbDn7Mr/Jbrxf9AkqEmEn95CMpxd/cC
         dbGkOs7Q6gv86ZUiFyREAo+b/iouuwfMaJVlXCijcNB4TUdNW5r5erqDdvGbOqtT4Zmf
         DiG+MS8/UeFQNB0FRhFSWuZ/T/91PYrlCwGUbUUU9qPB8Tk+4hq9aOb7DFtemRGta6ov
         95NaTyN4Gw/87z/3mtZB87ksA6tHLwDlyfXlxTLT22IgLzz/SpRyM9ljO6oKcHbGoEQZ
         f/dA==
X-Forwarded-Encrypted: i=1; AHgh+RqhSzDyfSzuZ+P0Smgqxi0k0Lh13otDIDjLuoxzUt/iiStCsknq2OrwSleKjlWBKwd+EMY=@vger.kernel.org
X-Gm-Message-State: AFuF++nO7D9+jyitBbZP5OPU20hwO2PGg8NiTGivX1PgTdEG+7TvnbYD
	ZKwknVgrzgaK7yPFJlYFd+3bEIbn1NwxO7nMAzD2ScOlQnS6q7sfw7sxG0d8NBzbMi8MhFY15qC
	Iq3+7Y92ZHoZYA/bcTE2ZJyMCZnjfheSisUaO
X-Gm-Gg: AR+sD12xVlplqHeKO6HhCXNgEHTVcjTYacggfWv+QYDCtaZUDYiXWNBM+PvjrKTaYNn
	FDW2MjRxH7KgFrIvcuIfOmJq5VKQ1Kin1O3/tpnTNUyDN6AAenrdpDC5v8kQ6Xxt2JRiJfiW27J
	/w4B89SGOIHADkmTF5l5GYRgWIsMb+Pml9q4cupN8I9qvjbC3oXxiCRYPYom+9VpDu88Po07qIb
	h6aMELpyIv5P4YoVoO6TMM87oJp5VroLRCx9OWhQSYykK7B15EfsjLDTKSIU0TzYHAo5mc+Fh42
	yTabj3PR94c/2K963gvjiqfJifzCaD+PYgFBcjwpgeMOsw==
X-Received: by 2002:a17:907:9607:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c24924b8575mr2254111866b.9.1787586690042; Mon, 24 Aug 2026
 08:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821032210.792451-1-kunwu.chan@linux.dev> <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
In-Reply-To: <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 24 Aug 2026 23:51:17 +0800
X-Gm-Features: AcwNN1Uq-eRgOY9GNoEPoa7dv086UlNsCEHedj9wcGeXWfsWr1sK6Ylb8-nGreE
Message-ID: <CAN_Opa_osKeScHG1h4L4XZ9CwUGtDkRFLzvJp5KfSAKPz3-iaQ@mail.gmail.com>
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the detailed explanations and for addressing the review
comments in v2.

On Fri, Aug 21, 2026 at 7:53=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> > If the common case is that there are no readers and the new fast path
> > is intended to avoid the SRCU grace-period machinery, could you explain
> > what property of SRCU is still required by the proposed users that
> > prevents using ordinary RCU instead?
>
> My original version did use RCU, but Sean asked me to switch to a
> dedicated per-vm SRCU=C2=B9 because a system-wide grace period doesn't wo=
rk
> well on large KVM hosting systems.

The rationale for the per-VM SRCU and the no-reader fast path is much
clearer now. In particular, I understand that the per-VM SRCU is mainly
about having a dedicated synchronization domain, while the try path
avoids the unnecessary workqueue and scheduling latency in the
no-reader case.

>
> =C2=B9 https://lore.kernel.org/all/anS8C4Cxqy6ehCo3@google.com/
>
> > Could this use case instead be addressed by making exp_holdoff
> > configurable per srcu_struct, or otherwise allowing a dedicated SRCU
> > domain to use a more aggressive expedite policy?
>
> That doesn't help much; the other concern is latency. And the mere act
> of bouncing to the workqueue only to realise we can wake up again was
> adding 100=C2=B5s or so every time for nothing. *Plus* once you schedule =
at
> all, you start to see really high tail latencies of >20ms too =E2=80=94 w=
hich
> is why we've also started looking at synchronize_srcu_atomic() to
> eliminate that completely. If we get *that*, then maybe I don't
> personally care as much about try_synchronize_srcu(), although it might
> be a useful extension to synchronize_srcu_expedited() =E2=80=94 this *wou=
ld* be
> the 'more aggressive expedite policy' of which you speak, for the case
> where there are no readers.
>

In particular, tuning exp_holdoff would not address the workqueue round-tri=
p
and the resulting tail latency.

> > Could you also clarify why observing no readers during this
> > check is sufficient for the reclamation/happens-before guarantee
> > required by the proposed callers?
>
> Both halves of the grace-period guarantee are provided when it returns
> true. For any reader, either:
>
>    =E2=80=A2 its lock increment was observed by the sums and its unlock w=
as
>      too =E2=80=94 the reader's final smp_mb() then orders its whole crit=
ical
>      section before the caller's subsequent accesses (that reader has
>      completed), or
>
>    =E2=80=A2 its lock increment was not observed =E2=80=94 in which case =
the
>      store-buffering pairing with the smp_mb() in __srcu_read_lock()
>      guarantees that reader observes every store the caller made
>      before calling: it is a "new" reader for the purposes of the
>      grace period, exactly as if it had started after a real
>      synchronize_srcu() returned, or
>
>    =E2=80=A2 its lock increment was observed but its unlock was not =E2=
=80=94 the one
>      case where the reader may still be running with no guarantee it
>      saw anything. But that reader inflates the lock sum above the
>      unlock sum, so this is precisely the case in which we return
>      false and the caller takes the real grace period.
>
> It's the same argument srcu_readers_active_idx_check() makes; the only
> novelty is summing both epochs so no flip is needed.
>
> > Since a successful try_synchronize_srcu() does not advance srcu_gp_seq,
> > flip the SRCU index, or process callbacks, could we document more
> > explicitly that a successful try provides the required
> > reclamation/happens-before guarantee to the caller, but does not
> > constitute an SRCU grace-period completion for the state/callback APIs?
>
> Yes; done in v2.
>
> > What ordering edge does the first smp_mb() establish that is not
> > already provided by the middle and final barriers?
>
> Er.... none? :)
>
> We need the caller's prior stores ordered before the *lock*-counter
> reads, but the middle barrier already does that for us. Dropped in v2,
> and the comment on the middle barrier updated.
>
> > Would it make sense to perform the same lockdep check in the try path?
>
> Ack.
>
> > When applying this to current rcu/dev, the patch also needs to account
> > for the additional bool is_atomic argument to
> > check_init_srcu_struct(). Please rebase accordingly.
>
> Ooh, shiny, I hadn't spotted that the atomic thing had landed. Maybe I
> should retract my 'if we get that' above... but let's see how it
> survives.
>
> I also have more than just this patch to rebase onto rcu/dev =E2=80=94 un=
like
> some, I'm not just hacking RCU for the fun of it; I get my jollies
> elsewhere :)
>
> Btw, the current commit c68271c3f83a message says "no index flip, no
> grace-period sequence update" but that isn't true of the implementation
> any more, is it? In fact, it *always* does those things, and doesn't
> take the try-path optimisation by counting both epochs, that I'm doing
> here?
>

The v2 changes address the points I raised, including removing the
redundant leading smp_mb(), adding the lockdep check, and clarifying
that a successful try does not constitute an SRCU grace-period
completion for the state/callback APIs.

I'll take another look at v2, in particular the two-epoch counter proof
and its correspondence with srcu_readers_active_idx_check().

Thanks again for the detailed explanations.

Thanks,
Kunwu

> Thanks for the careful review.
