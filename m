Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792982115;
	b=zVS2MiCch6Gibt+t+qk/mmB6dmFjZe9c+/0hK6BxLykh8S7SDvEU05EeskeSnPvgDMcO
	 3rSHWcxR43XoT4QyYypw6eEaeViT16jcD1TQeQmHCVHO52VsiGMQToHrjUteZvHJsZQvN
	 5uoTWjnYYoR5BsKjcJzr7iJfJtTNsGK3MzXWa70DsYt/3jyyDKAoVJkrz07FrRyrx99nP
	 jELOP92XsyVxE7Pt6+k4skx8y40y0thJA0sbSyNHZY+S4UEi0WXTqc7n9SQgDa+IuJVWO
	 Bf6zqJ+l0iTobdaPQS9rh+8AJv68Fe2ABa6s/ydgE/2CW2Rk+/a4KMqbFaE3PP+lcuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SVVTsCxlO9RTIRg4DXefXj5kmUOCXBODmILe7eWM7i0=;
	b=PV0CYrn6m0HL1ZTLor8ieYT9wubZTyFyo/ZAktWJwqq4eINOFY8Muf3QTItVtTWR6Vwy
	 MiN3i3EhqCrbLAbeaSksp9GzLsDPZ5vkLZnkfuVkbFjM9v4HVh4/EHz2n/QR5STgGTb5a
	 6zA8ZkckYKeXty+BvQY111n6RVqQOudB3H6P69+rzF1AEMG4/yeKaBCoJgly1dC4kB5b7
	 az2r+c0vHZ4sYwfvgABv82xgx05HCW6ujuKqG8j/HNvhGLiUlMaW+SUX3X1V2q8Jk/EJm
	 kTyQxD7Pve47V+igzfcOQaMGSq/b2A7gRmBexTA521K2BWo6oW3cDWOdKZiXgo5p0WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K2phesg/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A28606A31E
	for <rcu@vger.kernel.org>; Mon, 26 Oct 2026 02:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A28606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K2phesg/
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so16885015e9.0
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2026 19:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792982113; cv=none;
        d=google.com; s=arc-20260327;
        b=iA5m0TWuOqwBso0pA6G3UHqrEU0FEbWNI9dydHwA7EXcf+oCSq7jTcrEqqn/c6jUET
         2gXQ2aq7jmvFrLzMXnx1LmA/KQMidgYqnIoPLvwjNslzkKygqZ4HOzVFSHRP2xmq/bHu
         zjKgKKLR081LhZvqN+lahqYTowMOpKQIQS1DyElkuUp3Z1PfJMPuEapBuYWkzV7VrFPf
         oadDGzv0198Qy7cfqldvdSonnUJxYPkv/O0oyJmoLY0TLNVznJLRUdDRbPMryevy7Ycs
         JFynwPNV09Vex63o64SjGeqK4/Wha25tl7l95nvqduY+tuqKdH2QFTm4B1IbQRpmp1l4
         otuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVVTsCxlO9RTIRg4DXefXj5kmUOCXBODmILe7eWM7i0=;
        fh=jZLTd7okeid/JRgy3HXa5O9gfhfDMYFHEoMushyO9tE=;
        b=FmJBRNnlSYnVVONanYhYFgHT5Vdjx+l8N2Am21ZeCWTgzFIngvrGPFENlCFvHoVoq7
         rkfEL7Qsk2KCjg9Eun/87x1I3G7VsDCaEnXGfFRwfT0DcsXvn8rChuugAD5LhpM/dI3A
         vj+xalWn8jyw0WEQx+7XIoiwm3xwTCYlGrhNZlX2dS+CpnoRjstSkTIaNJhBnejXbu45
         zrdzgJDmERU/ey1bfqWvZa9bGag7bCIFQIeba+nBQFSpFs8Y0ZkC5tXwpPdrmOE/b3xn
         YU99+8LBYI/2iBatSsiSvPfF2EzUVTm+FXsm+RnYWJWlZ2d5J2hZp1kPmGdxxYFojLxC
         47GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792982113; x=1793586913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVVTsCxlO9RTIRg4DXefXj5kmUOCXBODmILe7eWM7i0=;
        b=K2phesg/sIZN0vhIj2yBJgZ5baiYagV0AXyQr8gt3yKJjDeRGPKYPTWbkakh6U1u5O
         7qZi8PQZpyg/YkRWfJ98dIUpWt8Fji/QBHBE06Pr46OyUEOaIpvOL25vbTjc+huLB2yT
         N1fronMppT4dscAAZ2RCVymeRF4U+UnlFidG3lFGkNOxWPAKxJUnpK1QhHOSwzKf5wgL
         NjACE1cPoZt4mC950Pkf2t+5jSXBkFWrOhxqJtLofW6mWTk1eqf+pKWupTXkGO3gHVex
         oyO0QY+kTsDnuS1SPUxX++xDPUOtnftHvYsD+JNe8fNxACrGw50tDHAL7o7GZKWvFSfy
         +f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792982113; x=1793586913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVVTsCxlO9RTIRg4DXefXj5kmUOCXBODmILe7eWM7i0=;
        b=c8y9E6p22w5QbPmkO7CXOgn3DaRqWp60CXOhQXl3R+CQZH3r0sXCbkjrBFTM/784Sw
         HVFlMXgPCLRak+vje6XByA3HsnoZsnlRNqZMQh+yJMR+F1YhOuyBtZaGKzmqE4R1/d7P
         ygQ2u+Vdmc+/8wYzQA1tD8Mc0hRWkhnyJxSn0g/Qs59pLEsAwETU6O0T/tjafIc0f+0K
         fW2yoEcdAAmBnevJXiAzGaCxV3uIyBhYD0kHpxzgUbGr5yEx3+xo1dj6W5io6Rj8cjN/
         eb8ZDGRvZD3NIW2PUMT7cVOA8DWSEqYoJ0MV1kZmiUNs7MjMaoMv5/9tD55ptsSfp/Qk
         AfFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxljqkpiTEK0PlOXmFMB6W98Mj4/TSMHtFwcXTspP6j7Yz98TStw8Cygn1980Cz27ZVbjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2PCgyt3tHyqDjDw5bltznKF+LtuChlZFWtMGvKIfF9f7wm5UF
	qv2gqDg9mDJrzk+PfsDQr1VGh+VBILUiDQYrvkbsdX+zP9BGFDJCPuhwN7IRejsHTwSCEj1zaKL
	ojIxgI/0ZJqkHtNM7NjNDbSJVTREMp+s=
X-Gm-Gg: AYBFou24mGMOudwwBl4gJbCub1GAUISe9L6irtMf3X0uPeCEQ9798QcEchTynJ3OTXL
	EOZ2zEnntDDAr1DJCc7n0ZnQPJpBe+aOZAivom47svHUXnOW9BbZJV8/j50G4C4Dr9P2GRzWQcq
	bH+KjG43cx+IoBc3NwZBYQXliLbnTPMri1KyzxsTOaRbDsNNDsQQqyYIKeBqTFY9pz9j30FQCIw
	A04Dt3OSh3o87JtBgwiH9iGvvuk40b6hv4n/6wtP0cmCtqZ11vUMDRwE//Kix8mLwnDfe8ugPFZ
	EKTX6G3/ZEzJliuY21LnmptpePBjl/iP7rfKJKIv++234rNRj8SkiQgMECmU53U+C2s6s96Dd7n
	30g6YfeKdlyqsmNvC1wUabU4VZQiAoX+EnCWqQ3ITNpmTJ2+HuW//59/VVYjSYSAVyYrCRw==
X-Received: by 2002:a05:600c:4746:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4a35ac8bb3fmr104333465e9.7.1792982113228; Sun, 25 Oct 2026
 19:35:13 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-8-kunwu.chan@gmail.com> <60e6148e-b7e1-4f2f-a665-24567305956f@paulmck-laptop>
 <b5c84b27-5e66-44f1-b95a-d7c1655df69d@paulmck-laptop>
In-Reply-To: <b5c84b27-5e66-44f1-b95a-d7c1655df69d@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 26 Oct 2026 10:35:02 +0800
X-Gm-Features: AclHuK9c9zrzG9Nt-ZVNvTMCRDudA2gvPQD-2SIBWE5m7zqo9uzPr4bzScrDxIY
Message-ID: <CAN_Opa9MvTvLemY5DYNHu-yXy9xZvJJiLXigknP-qM=bK0Xw7w@mail.gmail.com>
Subject: Re: [PATCH 7/9] srcu: Detect duplicate callback enqueue at registration
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Paul for the detailed review.

On Sat, Oct 24, 2026 at 3:38=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Oct 23, 2026 at 12:30:57PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 23, 2026 at 06:18:39PM +0800, Kunwu Chan wrote:
> > > Move the duplicate-callback check from srcu_do_enqueue() to
> > > __call_srcu() entry so that detected duplicate registrations
> > > are rejected before they reach the deferred-list enqueue path.
> > > Report the callback address, function symbol, and object
> > > information, rate-limited to the first three occurrences.
> > >
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >
> > Getting the stackof the call_srcu() once double-enqueue is detected
> > would be a very good thing!
> >

I'm also working on the rcutorture support and will send it out separately.

> > One question below.
> >
> > > ---
> > >  kernel/rcu/srcutree.c | 20 ++++++++++++++------
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 1993ddbdb828..3838d9fdf532 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/smp.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/module.h>
> > > +#include <linux/mm.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/srcu.h>
> > >
> > > @@ -1511,12 +1512,6 @@ static unsigned long srcu_gp_start_if_needed(s=
truct srcu_struct *ssp,
> > >  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head=
 *rhp,
> > >                         rcu_callback_t func, bool do_norm)
> > >  {
> > > -   if (debug_rcu_head_queue(rhp)) {
> > > -           /* Probable double call_srcu(), so leak the callback. */
> > > -           WRITE_ONCE(rhp->func, srcu_leak_callback);
> > > -           WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
> > > -           return;
> > > -   }
> > >     rhp->func =3D func;
> > >     (void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
> > >  }
> > > @@ -1529,6 +1524,8 @@ static void srcu_do_enqueue(struct srcu_struct =
*ssp, struct rcu_head *rhp,
> > >  static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rh=
p,
> > >                     rcu_callback_t func, bool do_norm)
> > >  {
> > > +   static atomic_t doublefrees;
> > > +
> > >     /* Misaligned rcu_head! */
> > >     WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> > >
> > > @@ -1539,6 +1536,16 @@ static void __call_srcu(struct srcu_struct *ss=
p, struct rcu_head *rhp,
> > >     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_=
ATOMIC))
> > >             return; // Leak the callback rather than corrupt SRCU sta=
te.
> > >
> > > +   if (debug_rcu_head_queue(rhp)) {
> > > +           if (atomic_inc_return(&doublefrees) < 4) {
> >
> > Why this hard-coded 4?  Why not 3 or 5?  Should this be adjustable via
> > Kconfig or kernel boot parameter?  Or, alternatively, should the below
> > pr_err() instead be pr_err_ratelimited()?

Regarding the hard-coded limit, I followed the existing code in tree.c when
choosing 4. Thanks for pointing this out. I'll switch to pr_err_ratelimited=
()
in v2 and make the same change in tree.c as well, so the two paths are
consistent.
> >
> > > +                   pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\=
n",
> > > +                          __func__, rhp, rhp->func);
> > > +                   mem_dump_obj(rhp);
> >
> > Does any of this automatically dump out the stack that was recorded
> > in earlier patches in this series?
>

I'll also add dump_stack() to all three duplicate-enqueue patches
to capture the current stack when a duplicate is detected.

> As in shouldn't there be a kasan_print_aux_stacks() in there somewhere?
> I did not see an call from mem_dump_obj(), but I could easily have
> missed it.
>

As for kasan_print_aux_stacks(), as mentioned in my reply to patch 1,
it is called by the existing KASAN report path, which prints the auxiliary
stack recorded by patches 1-3. It does not need to be called directly
from these patches.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > > +           }
> > > +           WRITE_ONCE(rhp->func, srcu_leak_callback);
> > > +           return;
> > > +   }
> > > +
> > >     /* Record the caller: the irq_work's stack says nothing about it.=
 */
> > >     kasan_record_aux_stack(rhp);
> > >
> > > @@ -1554,6 +1561,7 @@ static void __call_srcu(struct srcu_struct *ssp=
, struct rcu_head *rhp,
> > >             if (READ_ONCE(sndp->draining) && !in_nmi()) {
> > >                     WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > >                               "call_srcu() re-entered during callback=
 drain; leaking callback\n");
> > > +                   debug_rcu_head_unqueue(rhp);
> > >                     return;
> > >             }
> > >             sdp =3D this_cpu_ptr(ssp->sda);
> > > --
> > > 2.43.0
> > >
