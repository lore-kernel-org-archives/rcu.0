Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982754CA26E
	for <rcu@vger.kernel.org>; Tue, 21 Jul 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646400; cv=pass; b=ClLwIdkylUZEfr7pJ/ibbeV3c2uLV8M8nlKVZMSgMiq8sggXwQ9L43ZqVagdIhkUVww8yePXPNmqLe/LYk+ZoasldkC9h+T6MbEWDDKQhuWSL69AWt9ty3/zw0uR7sHRQYqq8ZACt3YlE4X10NZegnQx4ka9Gy5qFEElKZ9INo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646400; c=relaxed/simple;
	bh=ho46wttfZTO7K04O0d4Ml5ZXrzDwso/tV+4SlWbvjus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeVdAvOmYRF4b4E2drOn68ULhgw49RWbXppEs5w4xErEzYKE/YYooGC5fUq0mzrYQ1EmyRylfw/CDI07sBL3um9wKwlwMXjkskFKCg2DEIQHBzKdamGLYCYKJnkOIWqMF4dE4gy6+62RLeGYAPMY0NFb1Z1HQvVllO1wIpO3m9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehfAPw+0; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehfAPw+0"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f47e6297so835019766b.0
        for <rcu@vger.kernel.org>; Tue, 21 Jul 2026 08:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784646397; cv=none;
        d=google.com; s=arc-20260327;
        b=rBM+Jum1Lvf4+iKHCEthBH/5hke/y+iXwYptw7XaYr/eTTg7796jVwP020BonHlbph
         v4C5GttMkqV4B5iHM9vQUjOSPAO7IFOtv1OB6hiRlItkT9O54JQ+ak5i0Cg0FnenmsrD
         S1UNFRTuyPsWU2QYwkxlbkSi5HO3UXk7m/XEj2WN+2QgD2+mXyIoF1jJkuQw2eJpwBcu
         q/Ml9/gnHWwl7IZAE9ojCzWBq6M1AGFOqyiW6KHddzkcJOiU7WRmMlquZ13VN7d1x10E
         zmt01/SUV8zxhsJyJt3dZXY3k5jF4IO8CGvPU6Vp5FLKGjfLh9IoVQxtuN5n7MrDqVd/
         RCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        fh=0a32sBVml1HIh/QBMwCUfYAd9Sn2D0eKAeJB6PxXdAA=;
        b=au9ZTVN89COfvndA6trfNt2k92R0vzCwxcHxs4YGfef73wRRhci4SBYkyHQ7QB/kQl
         d6f0soOGOsWoNJg6Uw2yiBFSXV1P4Ol8AwrDjFQ76BTBTn7H5VE9anmHpTE3iCq+O7is
         1VDNj0gJqRWmCU0fadGdBetsJIitDDwfeF0IftX584ozpHiJErYieAa0AwCyO1YszDSg
         UQ+A6MCxGgcVLtZ80PlUQdnKW6LmRw6qIW1AzqFhNrQfkU+q4l+qNLEz10pI7IGdmNkZ
         CSqCfcu+5t/bezU/RiKmeD+P+k4rzREAS2fh51dV93+b2im6X7kVPI5QbiceTpN5Fxel
         9KXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784646397; x=1785251197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        b=ehfAPw+0jSsxb7nN8116nYzzhoSEuDK2FayEU2nHfruP9g6plk9dkZIaryF3uKdafl
         eAqoPvwqeQOjCt2kPqhlB9z/pIijRmXafqoqE//v1KwOuMoOn9ccaqlREyABRgtWkIgV
         2zBPpWETQNz0un+vqaqZSJ7hTXjYeEfdWDpD3jADDtRJ+n7gqJlR8WXrgd5RHkPBVZZG
         LBB5qzyJvAYWfaKjO+nAFn0pUyXtVvUuhx2J0Ng2dEIw/Y9DqLUJlBy9Yi7AnDGOMD02
         NwiUhhgZ5EJoWl+QrDD87qhGNWIs0ftVzJFRyRcJC2Kh0Fg6ToDFQYqAncAdUIBkuyzg
         yPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646397; x=1785251197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        b=a1BbuMhkRQOm+rtpFB3GNe7zWeovogM8Ui0aBKlXI71ExlPH7+fyN21KI8ROyeCLQj
         LBausXk4zmeptbpS/1hkDCzKGmakeqm3n/nh4uQR63KkhylLZWbk6cYsbYG+X7fJSjR4
         eREZkcbcDZjRRhnqaaoPZYC3Sm4hklN0+J+YIHNvADXTokIlKHLuvqe8PkpqK13JFzI0
         X/rT1WWYaP2s392URQM+5Sp6svr2+uoUmeerXf9qjVxWlNFNM7p1jsWvx+D/HVvLboCk
         EtcxtjnrFsxE3xHdVQJfT0ELxjmGcwy2tLnk4eSvkvq8LL5YYYVPtlsSTm5Enx2p07uv
         FOMg==
X-Gm-Message-State: AOJu0YxiiLP8NrQ5mdZ8xT403flKS0NpPydDTp7w7KQIZoONWSNZW84b
	71oUrwfY+ArhABBywc2jtz/RRtsHaYRwyQl8HjOgLu48mMaZLrwDg5WAuoonh02jPQz0uioWonj
	91r8ztg4dKVoY1IPYa3d0WDLmDfUG7KVwvxOIBPo=
X-Gm-Gg: AR+sD10a+E08IuLxBLHIf0giz0mWln+oK4kBTU9Xavx0Xx7INbNCrvvFsBFM5pMdFrw
	jcIdzzYCb4Dz9kGfvp3ZF1hE8zU2RxrgvNsHsktX4na/pd7Wknhlq3zJbUIBaB9gDev/sMOHHew
	fk/o6M6Odouven9Cs64Fs6kTupqwTIU7D9Ld4+xhunSxA4L/iGTogWNEaGMdEiqT34FqYc0G5TZ
	O0KBS5UZkMqwzWyQOnJwHSmgg3Fnj3csAL4CVIQmF6gDm6I1KaKVEd7LWEa0uTB+bHGPv2VQPKF
	iw==
X-Received: by 2002:a17:907:3d45:b0:c16:5dbd:8210 with SMTP id
 a640c23a62f3a-c16b487dccemr839458066b.44.1784646396456; Tue, 21 Jul 2026
 08:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <20260624132356.516959-11-puranjay@kernel.org>
 <al-DopVEIe2FvLnv@localhost.localdomain>
In-Reply-To: <al-DopVEIe2FvLnv@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 21 Jul 2026 16:06:24 +0100
X-Gm-Features: AUfX_mygNiKl7k5PKNcYxKWmZDstqHm_LMPoAPOfcq1BpHj7wCOU9ddgC3MI19k
Message-ID: <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:35=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 24, 2026 at 06:23:52AM -0700, Puranjay Mohan a =C3=A9crit :
> > Even when rcu_pending() triggers rcu_core(), the normal callback
> > advancement path through note_gp_changes() -> __note_gp_changes() bails
> > out when rdp->gp_seq =3D=3D rnp->gp_seq (no normal GP change). Since
> > expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
> > called and callbacks remain stuck in RCU_WAIT_TAIL.
> >
> > Add a direct callback advancement block in rcu_core() that checks for G=
P
> > completion via rcu_segcblist_nextgp() combined with
> > poll_state_synchronize_rcu_full(). When detected, trylock rnp and call
> > rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wake th=
e
> > GP kthread if rcu_advance_cbs() requests a new grace period.
> >
> > Uses trylock to avoid adding contention on rnp->lock. If the lock is
> > contended, callbacks will be advanced on the next tick.
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b01d7bf6b57b1..f42e01ef479c4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
> >       /* Update RCU state based on any recent quiescent states. */
> >       rcu_check_quiescent_state(rdp);
> >
> > +     /* Advance callbacks if an expedited GP has completed. */
> > +     if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->=
cblist)) {
> > +             struct rcu_gp_seq gp_state;
> > +
> > +             if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> > +                 poll_state_synchronize_rcu_full(&gp_state)) {
> > +                     guard(irqsave)();
> > +                     if (raw_spin_trylock_rcu_node(rnp)) {
> > +                             bool needwake =3D rcu_advance_cbs(rnp, rd=
p);
> > +
> > +                             raw_spin_unlock_rcu_node(rnp);
> > +                             if (needwake)
> > +                                     rcu_gp_kthread_wake();
> > +                     }
> > +             }
> > +     }
>
> Should that go as an improvement to note_gp_changes() instead?

note_gp_changes() only reconciles rdp->gp_seq against rnp->gp_seq, and
the expedited path never advances rnp->gp_seq. So the gap this closes
is exactly rdp->gp_seq =3D=3D rnp->gp_seq, where note_gp_changes() and
__note_gp_changes() both short-circuit, the expedited completion isn't
visible there at all. It's detected from the cblist's stored gp_seq
(rcu_segcblist_nextgp()) confirmed with
poll_state_synchronize_rcu_full(), so hosting it in note_gp_changes()
would mean running that in the lockless preamble for every caller,
including the off-tick call_rcu_core() path. In rcu_core() it's
already gated by rcu_pending(), which does the barrier-free detection.
