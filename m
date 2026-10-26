Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792982176;
	b=Qn4DYINmP8sDdHyMJ+mGVbZmwvNUmRYIiKbz4vCGeeDLWC/74+PAJ7Yer4ikFzCjzSuO
	 nmDXQ7r7HTK7AlwdR5rpQB+qnf6IxCJrPfLgXFgZbULe7xhItKWuF1RZptBmcjZV9h4UV
	 tnrArtEIHZCkh7uu3NUEbgC1bedKCCBgSzk35EnHEFWw8CVRAaVRbbyKQqDPiNXtyN4Ov
	 LiJphYOQH59W7PI+X4aC/R++KnArmKZlKnR8VAJPCMHz+IGLE89s0lI9P4EdQIZwb99r+
	 038GOkykonqkMJI5sEd/Iwn6ho4svgG2YXOkqZLkWbJNMbwYZA+wsWWYq6mMVSD7qOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iAk23gi97Bh3E2+QZ3E4niRePEWiOsVcJhq4RJVVZpc=;
	b=eE8VuOjHZBxW8b2yKO3zKLGgYA4Jn6SNpk1lTnAMoIsbDNJaiMqwAI+wEnjfQZRkDuKV
	 ne12kFc/2LoVnT6BnZzgYQvq6HtwG8FbYiWSlUjcoaM/nOYgTNd+T0hAFASnFRB0H0SHO
	 HKPCW9AejaCdtsUeuMWOqFE32QOvS+O9IG1eLINO1t8vIuOTKFyU5n7ABtp4I4DR4yJhI
	 y4snJdBfWw1W2PJTwYQGchXh36ggeY3PqtFYmcagDHT2Y9QxqSzsKTjMB3qh/AN5lv8G/
	 YbGlMAbL3EL2RhHhqKf/XuqtbieXShWc+riW7My0RoJcTE/ca3zIMZzR9KP0KwtZBvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ofwUcJCk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BD606A31E
	for <rcu@vger.kernel.org>; Mon, 26 Oct 2026 02:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ofwUcJCk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso19910825e9.1
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2026 19:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792982174; cv=none;
        d=google.com; s=arc-20260327;
        b=Uncxi11FfxRMFuxO3WPR3Yd70p9eNxStAIj36QN647N1ikBGZlK5lDtl4uwG4iOkxr
         NGdkveXoIizTuaQOJaPMj/p3Takq2JRbHCDAQCY7vUPzNFMosBbIVytBVwpPrnOPXf+E
         gI896BEga9Eq8jyZ3sV8eSX8QqphuM+blq2beHpiajTplXIslq0NVc2AwbmrRHBdDWRf
         ZtDWjpXAPlt1VFJe5yg2rWhPtGeAatXf/UmJWkpuZv3vA3/X5kC4fm9YABGiJyYOHuwx
         +Yde9jzLLtW0IdzeXBbHOOBLOTnO3VO5pr1DmUwAyy6cB8k5RmjNuHvV7rE//6Ih+iVy
         gCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iAk23gi97Bh3E2+QZ3E4niRePEWiOsVcJhq4RJVVZpc=;
        fh=ZD/+duXzFmnNAdX7TFCOUhXqnih13lNO4RDaQz/z2tY=;
        b=SPSZBRMPrhKk/yAkGfHvIbSGzK3bWsQwJiLj37SVSfYC91bREJqiJQ8SciyEB1c2O/
         2ZD30CUeFxqp1D6CcM9AxMAK+KP12RWTfWlULchUxDYzSA3x5ENqtAI57ISclqjRAQPb
         e8aptZdCfAtyS4MsuLNL94BckbA+alymi22vvVwrPHnS2c965O7mJuODSe5OnmfRH1Fx
         fAKRZHfw/6tgRVWcO6MEYIHvVWXc3PBWf5sBD3WARcjZ0KNRFX35QkSRepByOMwKAH3/
         SHFYGY3jPSrTkdt6kfGMhf2y/iVkKOerNACJo9MqRRLgpLJv8iKEokEqDpqO8JlLqmJs
         aVgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792982174; x=1793586974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iAk23gi97Bh3E2+QZ3E4niRePEWiOsVcJhq4RJVVZpc=;
        b=ofwUcJCkVBq+dP5gJkQOnwrdg5TYbPF/qPRb0A8VwtIB5at85L1RSTwNh5W0mqDBzh
         J94jvIwEphAGegNFqLajeAgELfmfnL/u4rzpxl2pTpINfNXVGoPhuYQwwuO2w7/sgrP1
         OOFAoWhsonuX++lHhd4eE35U9sFcM4Pwj+1+4UcLMOGtTxmhwOM2cwOWF7ZQsyGLznPj
         hE6d9vGLJvsrL2ZKiA+fPYsaRqnypf7MCIxWkrwR+yN1m799tfxv8lE+VOI6UH1w/BuP
         E5pqNbTpdkCZXiiQ0PwI+o1ukeby31z5a3LOzc3OcwLMPasfHbtWc6F00stjh5oongXp
         rVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792982174; x=1793586974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAk23gi97Bh3E2+QZ3E4niRePEWiOsVcJhq4RJVVZpc=;
        b=e3ayXK7gL89huToEOEF2BcyVMlkgCClQy3qO2UdYcwvhVylWHYfWiPqsIB4fJtmmT2
         a5H8RWaTOOSniaY2G0faONqXstlmhtSH8xTXyq3w8E2Vb6O6WR7M/nb98iSAejblnUKG
         b4k0pu1aebWjRVzVRsRb2tzsE+kFSqXr3II75FbusKNxk/bHK+3/ZPCMxbqmD8oCB/tl
         OoY6/m9I8wPmDcXdE9sKW2/aDTCdk2ACHDweA1oJjECqCcfxmsQ5F6n/G1LG1qttI6Sq
         LEJ3SYbpAqzqSE9E3SVJxply70lmp0cY11vX4nCaFkzJUMUyT2uxP1r3TQURechJi7MF
         rpLg==
X-Forwarded-Encrypted: i=1; AKwUvBw43AgZI2WIxc3khWqlLjsBY5qgrtDCpdzzolR1HXyKSTWZ1oFzer/R10+MH8P/qUuSJPs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR2WSRxsQrp3nkKZ+KrVBOHi26aYtsQ71jdFLnTl4+sAiXO1IV
	bX5QLTyJSPW63wtNbXaIdkvMgVpWoYw8cfhV3Cp7M7VNd27xOgZ+tn/MXzOvqHy+tWYVtfC7CrP
	nGCP/dni0i3wVzDrOZmZMJvWGrr/vmPk=
X-Gm-Gg: AYBFou01WoGz0LTaTPcQcR4o4YKM+cLrd5dfUFg1fJhMmSjU++3bEmw+KFcxsf1NqOU
	EarVj7O8pVki07R/BceqdAY2NW4P5pcDO1/6yC7DQjrTghBqCKD/WUMkZrUUu52AjYND1VgkLOI
	BHb1u2g0A+6AYDk8WIxnm7JT9IJdQnwpZZcB70OQ0TGcufleoz/DFwI2xmakbxaVIi80hl4bl8y
	5Y+bJWdTzV1lAR0DoWjCBsjvHwHPLK+AJMyZPBPLm9M310uemYbO7aX2kInJX9cHJCia6dKl80Y
	zoNePkTwCbQxML8z788sXj7DNvw0irO/yq/TCSgW5n1S7B2NrAlTBBT2VUi2i7yBjpkACKruh3r
	ooHesYUhMzM3J0dpYWcH+B/YVjsgXNtPR0Wfq0cYBWk9XUPPya5AihHxVo2d++NTw77dVXj94
X-Received: by 2002:a05:600c:3e86:b0:4a2:cbe:bebc with SMTP id
 5b1f17b1804b1-4a35aca5f94mr95517015e9.23.1792982174353; Sun, 25 Oct 2026
 19:36:14 -0700 (PDT)
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
 <20261023101841.2910719-10-kunwu.chan@gmail.com> <cdd3f35d-9e9a-4b87-bea7-59ff3e1a7390@paulmck-laptop>
In-Reply-To: <cdd3f35d-9e9a-4b87-bea7-59ff3e1a7390@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 26 Oct 2026 10:36:02 +0800
X-Gm-Features: AclHuK-dNDX8dRPchF6C9mpMkMHM9t09-8qvMf53mQYiOJQpdnXUdDfEsPaIb0s
Message-ID: <CAN_Opa_eWF27jfz_HfXjUEw_raQb-j8Q1TMHLr9cx0P=N2-s6Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] rcu-tasks: Detect duplicate callback enqueue
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 3:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Oct 23, 2026 at 06:18:41PM +0800, Kunwu Chan wrote:
> > Detect duplicate callback enqueue attempts in the generic
> > RCU Tasks callback registration path.
> >
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>
> And the same questions for this patch as well.  ;-)

Same changes applied: pr_err_ratelimited() and dump_stack.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/tasks.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 5d7f234795b4..49b716feb31d 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #ifdef CONFIG_TASKS_RCU_GENERIC
> > +#include <linux/mm.h>
> >  #include "rcu_segcblist.h"
> >
> >  //////////////////////////////////////////////////////////////////////=
//
> > @@ -339,9 +340,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_wo=
rk *iwp)
> >  }
> >
> >  // Enqueue a callback for the specified flavor of Tasks RCU.
> > +static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
> > +
> >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_=
t func,
> >                                  struct rcu_tasks *rtp)
> >  {
> > +     static atomic_t doublefrees;
> >       int chosen_cpu;
> >       unsigned long flags;
> >       bool havekthread =3D smp_load_acquire(&rtp->kthread_ptr);
> > @@ -358,6 +362,16 @@ static void call_rcu_tasks_generic(struct rcu_head=
 *rhp, rcu_callback_t func,
> >       if (WARN_ON_ONCE(!func))
> >               return;
> >
> > +     if (debug_rcu_head_queue(rhp)) {
> > +             if (atomic_inc_return(&doublefrees) < 4) {
> > +                     pr_err("%s(): Duplicate call_rcu_%s() CB %p->%pS(=
)\n",
> > +                            __func__, rtp->name, rhp, rhp->func);
> > +                     mem_dump_obj(rhp);
> > +             }
> > +             WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
> > +             return;
> > +     }
> > +
> >       rhp->next =3D NULL;
> >       rhp->func =3D func;
> >       local_irq_save(flags);
> > @@ -586,6 +600,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *=
rtp, struct rcu_tasks_percpu
> >       raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >       len =3D rcl.len;
> >       for (rhp =3D rcu_cblist_dequeue(&rcl); rhp; rhp =3D rcu_cblist_de=
queue(&rcl)) {
> > +             debug_rcu_head_unqueue(rhp);
> >               debug_rcu_head_callback(rhp);
> >               local_bh_disable();
> >               rhp->func(rhp);
> > --
> > 2.43.0
> >
