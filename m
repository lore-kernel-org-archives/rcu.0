Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501640;
	b=kEzSjJ5tPjQkf+2mwiwf3+NjlJRn08ATTbignsd9CTGQsrZ0/IQpqTtXkSvpJ4LyPe9O
	 Xz4+NtAwJegu0/uc8aVR+bM7dYzggLkQFlrZfKHALUNJObEJaHk1V+0FOkOjAYnw22JRG
	 ZeVcipzzrXklAlk2Y2klcbyvZnvlHgRI5ch3woKpclCKLHTqBSTc5u/U/QJgOXXfFOKfO
	 +DCkZf62dBfjjYu2wJ4I8XbGSpRQRbM4+COPrryefYJ5gqtsE/l0BYLxhDa5/cDirvSGF
	 nobWNNAoy+htfnV6vGrEb3UjVyRihwYtYrmsBivc+P/y9c63bgfPJQ5Vl0Q+nW5bHow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
	b=GBEXVNNrA8wHxjY7Qqq9pNBQ4G6NuWJERI7OofziM6LljL0TbfkxNqF0T2TNUyGCgJ8L
	 IiokyY0Ogtl0Zwi576OroEZjCVBJJa5NcB7TFzw09inHnpPDV15nCljzDmp0wPfD6LIte
	 0tp/kao2vQ6h8Le+k42FGEWpVmVuLIC+89JrtsVNzW70f42BcCRkWxGWoMT/vtPJJr/Ly
	 guMSJmLyPREWSP5pfAC9F0KtDTaOfjWY1jnsXYtkvvdDc3vOVpTQRKoytyNBDBkaHA7sW
	 958e0OBONn5gRFU6a6UdTS2hnz3annG4XZowQFmP91MXDDUTmwj0+Eij1ibRK0xGRkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSTRe6bc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCD606A339
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65BCD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSTRe6bc
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso48426835e9.1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501638; cv=none;
        d=google.com; s=arc-20260327;
        b=f3+Iw3T5gEBKf36QMUY8Q/s/XKvurXhdjbSda3I7LMh5t4s6vUiX9afQqqfWYffdrY
         wmoP1e/r7YmtStJA4oswextuSfd5Xqr5s1jNQulM+fSOB5CfqndyjNvDuzP03xwZJTqv
         tr2FFfLEKUfjiQyqoof8NsHsglCrj7mxo968PrFqWcJVGhPgLot9CKJ8XL6i87VQwF5o
         aM9D+3Qmed5SzxQM0wUM40uRunYbYUI1rQNX2yzk4Drdw+19NUJK9uSRAONLu0xlQ5LU
         68MmjauZEd4HVF/qPxEhW+JZECZbAsk5rm9xUnIOGw0nQQPrO8ssD3FLxPZ7EdSU46nY
         uH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        fh=mZVKYSm1W55qB9YAJp9A/ajacM57+uJB/hML7JhPttk=;
        b=EVFz7Wviik6Q4WERc2BtJDXJmJxUkcU/D9a2v/xwn82PgfV+aIvxDXXNjOALq7amhJ
         4r4vrXoC/J113fbWkxWgScT+e319e+mRyqgu9hFjBNKcOISGqOzXKp3xA3REIYvuayVh
         ptslfdjoofrWckKQgM+3GkvmIRG5whOk2E87gg3N0n2mhD2RzGosO5hUSB6rSb0rpM7e
         5PaLCUs9z8k/IE7giFeg1ZpB49pJIB2Y1PmwVtnKRL7Zvsr4Lg5M7MDvySgrLOZ6yp1P
         tbdF+qancScK1/e9h4aGyj82ND8TsOMTTGFsE+mAYLfCd39hmCnUZoTKHvp3d+a6YZAU
         4Ulw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501638; x=1795106438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        b=zSTRe6bcpEP0F6lRzme7StvyYeoHX4QkB0ipadH2vg/pjnjMLNyV84pDO0l2RsL4H3
         NiX5YYkTTQo/IbG4eKCM7ptmaQ7zGd87omyitWEWk9Uc22tWQeokvwrzEQNpPng/1/q7
         6dCDIJplhjRVyLU1DCWjS7MRw508izhA0NS80M8HAyxabXNSFR8WN7lUgm3kFRC8+KaD
         1XhAMA9Ko6pvCIAMy3pI/Up75av8t8te2PBEBGEp81c2fFIvgWYmvp0hmfWL1IjpwGdM
         B9+VZv/tm6Qk1JOFPsr5Ff1pp1Irdji+Tv8WvUcoiFhNurMwnW+zyuHax8WBwILRnr8K
         jDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501638; x=1795106438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        b=tKTAzkoiHWMdU9yFKtWTH4TB6kOpTlr5khUFieU2N0oT7N33SDWLr202hvrrVOMaXx
         zqLVU4LjrG9ORMgoGWBohL+nqM/Yg6qVU2pvbNyhmpUONgyMuSFctySddrIh6w7zKzBq
         wSuw2Ozp+R95Xy2CYF9e8hq6YlW1LFNkSteVmbphz8eWUpV03PLSA4F1IDtajdDTX5nF
         DfzMfEVx+00iyFPCw70yMILj/ND3tjjbjAdgb5FBIf/udCn4IoKUFj7ENws7qVX0NhqQ
         8b4bE3y9fSfa+yY721O28IBF8XrOwK9pl0VNnRAaN26CREOmJXk9NMfpqlTvGzGt3RSK
         aEXA==
X-Forwarded-Encrypted: i=1; AL+hErFFlvG0JOa0hQeA0RBHgsmgPx3A/K46koJgrdnWSKGpcQLV+/vl/vODC+oU4n6r4ssgvto=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZwiuLZwucyvoSn0X934weucEMd2TIyy/cLWkJPcwU7NkSJYOd
	K18aAakMm3A+oA9i7kdkEhvZ8t8tlHKmwY++rCF7n/TG0OyppJpg5VaC56pe1faI8ROhEg0XHhj
	5hPvcChCc9pVKRSZhX65/7Cpe7QDJnIA=
X-Gm-Gg: AYBFou0E7WYNy5nT5623eJz9Hza+7kciuFRnR6qDjReVH4lU4OZHesdHnYEbOuCi7qV
	L6sh3ebAgJp4zX0JHioYfz7Nhkd1wMj8fIvhOD/oZIIsmE6fAFj+jcsqmjGmF+OBZJWH9Ga2b9V
	BDWoXAhOaaRskOiAALvNIMiZG+SNW/XvI2mM9O+PzDLt2SR6IyL1njSG9W2Fj6gR4nAJVdS7GaN
	IgM++9LX9Zj0sKK65d58aMClMT8PFICACw7sPPPHDXRwt+TD6N4t18e5ihleMyR/5aP8PUsqEDG
	u4o1VqLIuN46Hrco654NUo0AqnIcFkEfSSAdUGOp2UHaRO1jaI8zR4ox/RqhhUdGL5UsKz6gOXb
	4WbyImvAE/av0lS4UIe4M6drXckTfjsStTWE+N4q0549v7zHKRMyOJE13iyQPV5ubIz/7PQ==
X-Received: by 2002:a05:600c:354a:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4ba0939cc9cmr116023935e9.6.1794501637516; Thu, 12 Nov 2026
 08:40:37 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-24-kunwu.chan@gmail.com> <c4f84631-5805-4750-a7bb-3fd5a24bbb62@paulmck-laptop>
In-Reply-To: <c4f84631-5805-4750-a7bb-3fd5a24bbb62@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:40:24 +0800
X-Gm-Features: AclHuK9v_Y77arVgZcVVGwgCPDnh2ZgjQdSu0zI-cG-aALJ_JZ_d5zP_ayWkNKk
Message-ID: <CAN_Opa-z5mmmw-OB7bU3xuKJAHp0L4Tp8a9A7tjqiaY4s9V5+A@mail.gmail.com>
Subject: Re: [PATCH 23/28] rcuscale: Add hazptr scale type
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:45=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:41AM +0800, Kunwu Chan wrote:
> > Add a hazptr scale type for per-writer hazptr_synchronize()
> > cost and per-reader hazptr_acquire()/hazptr_release() overhead.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/rcu/rcuscale.c | 67 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 5659eaebc5c0..6e3e3f296f85 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/rcupdate_trace.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/hazptr.h>
> >
> >  #include "rcu.h"
> >
> > @@ -460,6 +461,71 @@ static struct rcu_scale_ops tasks_tracing_ops =3D =
{
> >
> >  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
> >
> > +#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
>
> Ah, maybe this is why you want hazptrtorture and rcuscale to be built
> into the same kernel.
>
> But what you really want is hazard pointers to be built in, right?
> As opposed to the torture test?  But this patch will be on top of the
> patches providing unconditional hazard-pointer support in the kernel,
> so you can just omit the above #ifdef.
>
> The reason for the CONFIG_HAZPTR_TORTURE_TEST #ifdef is that it is
> possible to build kernels that do not support Tasks Trace RCU.
>

Hi Paul,

Yes, that guard is what led me to enable hazptrtorture for the
rcuscale runs in patch 26. rcuscale only needs the hazptr core,
which is available unconditionally at this point in the series.

I'll remove the guard and add &hazptr_scale_ops directly to
scale_ops[]. This also removes the need for the torture_type=3Dnone
workaround.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > +#define HAZPTR_SCALE_NR_OBJS 8
> > +static int hazptr_scale_obj[HAZPTR_SCALE_NR_OBJS];
> > +static atomic_t hazptr_scale_sync_idx =3D ATOMIC_INIT(0);
> > +
> > +struct hazptr_scale_state {
> > +     struct hazptr_ctx ctx;
> > +     void *addr;
> > +};
> > +static DEFINE_PER_CPU(struct hazptr_scale_state, hazptr_scale_state);
> > +
> > +static int hazptr_scale_read_lock(void)
> > +{
> > +     struct hazptr_scale_state *state =3D this_cpu_ptr(&hazptr_scale_s=
tate);
> > +     int idx =3D smp_processor_id() % HAZPTR_SCALE_NR_OBJS;
> > +     void *ptr =3D &hazptr_scale_obj[idx];
> > +
> > +     state->addr =3D hazptr_acquire(&state->ctx, &ptr);
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_read_unlock(int idx)
> > +{
> > +     struct hazptr_scale_state *state =3D this_cpu_ptr(&hazptr_scale_s=
tate);
> > +
> > +     hazptr_release(&state->ctx, state->addr);
> > +}
> > +
> > +static unsigned long hazptr_scale_completed(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_sync(void)
> > +{
> > +     int idx =3D atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCA=
LE_NR_OBJS;
> > +
> > +     hazptr_synchronize(&hazptr_scale_obj[idx]);
> > +}
> > +
> > +static void hazptr_scale_sync_exp(void)
> > +{
> > +     int idx =3D atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCA=
LE_NR_OBJS;
> > +
> > +     hazptr_synchronize(&hazptr_scale_obj[idx]);
> > +}
> > +
> > +static struct rcu_scale_ops hazptr_scale_ops =3D {
> > +     .ptype          =3D 0,
> > +     .readlock       =3D hazptr_scale_read_lock,
> > +     .readunlock     =3D hazptr_scale_read_unlock,
> > +     .get_gp_seq     =3D hazptr_scale_completed,
> > +     .gp_diff        =3D NULL,
> > +     .exp_completed  =3D hazptr_scale_completed,
> > +     .sync           =3D hazptr_scale_sync,
> > +     .exp_sync       =3D hazptr_scale_sync_exp,
> > +     .name           =3D "hazptr",
> > +};
> > +
> > +#define HAZPTR_SCALE_OPS &hazptr_scale_ops,
> > +#else
> > +#define HAZPTR_SCALE_OPS
> > +#endif
> > +
> >  static unsigned long rcuscale_seq_diff(unsigned long new, unsigned lon=
g old)
> >  {
> >       if (!cur_ops->gp_diff)
> > @@ -1140,6 +1206,7 @@ rcu_scale_init(void)
> >       static struct rcu_scale_ops *scale_ops[] =3D {
> >               &rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
> >               TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> > +             HAZPTR_SCALE_OPS
> >       };
> >
> >       if (!torture_init_begin(scale_type, verbose))
> > --
> > 2.43.0
> >
