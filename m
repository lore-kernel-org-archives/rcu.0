Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA0381E97
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014467; cv=pass; b=AzkDGmue+vC/PQXOO7s/nlNfpKtepTvd7DgW6WmxOk3123w8/YtX8dGxT8ORAP4PKhkzbKc5rGMG5LFPyg0VYUNS7kwKbTHihhqMo1utHgRzG3FfPe4KpfO/BMi4UO7X1N/8wXzC3tF4KU1Ni02lNmp4FO0KxJo52TTTnSyALgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014467; c=relaxed/simple;
	bh=MYU9OpzBZLsQzkXTlej2bdd+H+Auq3i+G/TlNIgBvxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaEKFruSrUr9TiFl8kxgoa0Cw5YE0EvWpbPl3v6wbJOnPDMZ07dRHUAZv1RPQkDIfbMJuamvI8zSiCSJbk0QlN6vKnkyA88iq98FrVZltXUoaLF+mEYSMLMkzYin3Xd4U6v64oZCYdM07Js0ttIj0NfKEqtnwVgPHLIWtqPd8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiWlEfyW; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiWlEfyW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso10706195e9.2
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2026 21:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789014464; cv=none;
        d=google.com; s=arc-20260327;
        b=IOIcUisay/pGFomCSmuH5v7Buv+uwbE8ICyhNbvHntVg8IQgHNquSOR7ugrgwpsS6X
         F4/sqGqCmA5Fhlc+yt4a381F35c56UMqPg42JaqK9Kg+VclwBsJXNENaX1MseMWXTlgQ
         iyyE51DobuHy4nwlRgz3wqRjUCSYD5U+jTE/5Z4NC5oCd4b34naZyVCt8QnUSF7LWJqT
         RRNhH798Ie/+johWSe7bs53IaS34WD/jNIKJYUYTDhyR3bdTC9oDZ3CViBSsR9APDx46
         LNVCEDXurPazZob5C4NCHUcGDUvZ8hhddGVs1PQlYRfKGAoDNDaJzzM3QmMPB1eTWzok
         hW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tmt580Wcn8Bj1vHX81UjDGhgKre8nawir61F+yXmA4Y=;
        fh=f9r8JvIAkFVW2HWjy+Jmg+PwuExNDImxZ5MMImETXuo=;
        b=i5G5EGa2tZ7e+MPdUVOr3rB1xkFvs/PXRkCPvs/Uwpp6SHmQ22vR6vDK+BQm1kjje8
         IZD+dpAU0VQODDXCe/hvOo5OZSqaiWM3E6assVB/fWAG+kF0Y3AKDDdZVmRCyxOf+kjW
         FbeWtNFlHAttqNcqEs+sSYtgoQWZW6YfhLY/I6jDlzJUkAeylSnbz3uf1qZc+ntW8t6r
         DwbKe5rze2iErpwCJFBDmIcyTEBUJoBoITvGyTkI7R4YqFyeIJvRkbA0igLSCb+dbGYA
         juYnY2d5ETaW2x0N3BAKF8VGri2BvSeAXSHRaEcovWobG3Qc/RQmfG6uLzL40GE1NCBK
         A4Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789014464; x=1789619264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tmt580Wcn8Bj1vHX81UjDGhgKre8nawir61F+yXmA4Y=;
        b=WiWlEfyWxuGErSH0HUXX/lBKE7MB+JX2SBCZu+ONUddVoT6VNGNPOqNIa09ov8r/oT
         CYwTtXr5jqGjNaL1zAx16s92F3bikzeTsQ4PrMvKdV86sgliO6zBvUa0+a89kY94alIq
         SawSehRpz9mFgBfwGTT6l3pdfnBu7l33lX7ImT90+XRensBJiMgG15KP5nB5u85f/AyD
         tglY1/2l4q6gleVUK6N62qZszGTeeYp+ATqvmHYH030KIomwg9ToU489h06Zd95gftiy
         RLbdPZivkuXvaUCaiFeydCLpIOJmkaDVfR1vBSX5TyIMjugPqCVulA2UMX1GC4PcCM54
         VTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789014464; x=1789619264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tmt580Wcn8Bj1vHX81UjDGhgKre8nawir61F+yXmA4Y=;
        b=O0WxkjxE4mkYBlKmOZLst4ZmqF5ro5SozRrjMzx8Ud+v6wXy+trdwMDEMurmN9Dt1e
         TzfU1PbDWixpRYC+ssDRhYDoRIO0N7/L/i/TwRBUxb+0b2rgP939exgff/9MUYInE+CX
         j+oOHnqZcd5WVzNwiQQ6cdd8HXrGy8uCYTuFX822G/MTfC21IqkuIz+FiooSojHy35um
         XVLYzbtb/V1SGrAJ91iOpgfCKHOHwNC4AgkJYzDS1e3U2GtHbTHEHF1OAlEtAE80SJ49
         auKer9TkZBgS+wv4xA2EMM9UnOCiglLvpHsN0CUxDgi2QjqsH066ud125GxyPLKEH0EK
         x/BA==
X-Forwarded-Encrypted: i=1; AKwUvBzNr9HVj5Kbbgamg1pmYb7xpJ9LrijzwLbl4hrhfP8q1lhEWiJedpDWm38n/gyB2Go7Vm4=@vger.kernel.org
X-Gm-Message-State: AFuF++kSGQiFTZUPjKhE8Ezi8Y0Jv0oXhZmesyH25upXoGDMGaXhklJ3
	dXUecUIZwzJqLUrhg7ByEM1O6eJp8qdAGHtF5eYBhjaknLaspgQNMjtAV5sEk3hZYNKDA9Nwxj0
	pt5+QjIjlhNJhTmky/kJYHRrIbT+Tcso=
X-Gm-Gg: AYBFou0/dCGdhYARHJ4oa0YskuAJj0vHVCmoFZ+H70y3U2KCmiHXGqou+A/D6/nu7uk
	1VeYsrKysLyol9VszhM1at7m6J1lC/SX1cIusCmN+t4Tn90J/a9e0iAFtZpYHRZmMovqJaBa1Jd
	UCVvGOupqW2fVepnWestK+UhRmIo73c8973CPtlPC2Fqvscj0MyJBzpYNP4hHMYx0pgT8MevVWb
	ORFwNe36cEzRYBt719EOqR9bha+lrb29rIjQdwAP34bqfJPY/sr19EQ5i6jSZ+40kR8PWyVejeZ
	m/Updvwv/O+kAMIdbFFkogi7Y8vG3P9u4WZhYDOcnZNcvi0eMDLZOTbfiaf8khOnt9frIjk2e+O
	B23XixomOeoq+Qg==
X-Received: by 2002:a05:600c:5307:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49d25871d73mr98713615e9.0.1789014463535; Wed, 09 Sep 2026
 21:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
 <20260909024515.2429893-1-kunwu.chan@gmail.com> <8d5c8d6f-6788-43bc-b5e3-c8bca8e984be@paulmck-laptop>
 <CAN_Opa-FsrNsQM5WPCGBkQ43ECps36e_KyTzG9niEnm6KpdBEw@mail.gmail.com> <f093346c-4eaa-4faf-9a18-f1ec43247290@paulmck-laptop>
In-Reply-To: <f093346c-4eaa-4faf-9a18-f1ec43247290@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 10 Sep 2026 12:27:31 +0800
X-Gm-Features: AcwNN1XhvE57L4UNELOYOl-j5GVVFtVed7RTvIvW9yPwvKk4l63MZgA59RSJkHY
Message-ID: <CAN_Opa8OybZ6Ea9LCKPGN3Ntx-ObJ+owTawnP_vvgFzqQe=s8Q@mail.gmail.com>
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:46=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 11:18:20AM +0800, KunWu Chan wrote:
> > On Thu, Sep 10, 2026 at 8:13=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Wed, Sep 09, 2026 at 10:45:14AM +0800, Kunwu Chan wrote:
> > > > On Tue, 8 Sep 2026 16:38:19 -0700 "Paul E. McKenney" <paulmck@kerne=
l.org> wrote:
> > > >
> > > > > On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> > > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > >
> > > > > > The transition-to-big code path in srcu_gp_end() calls
> > > > > > init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in t=
he
> > > > > > atomic context reachable from synchronize_srcu_atomic().  Atomi=
c SRCU
> > > > > > has no use for the srcu_node combining tree: it has neither cal=
lbacks
> > > > > > nor srcu_barrier() operations, and its grace periods are serial=
ized
> > > > > > by ->srcu_atomic_gp_flag instead.
> > > > > >
> > > > > > Skip this transition entirely for atomic SRCU, which is also de=
fense
> > > > > > in depth against any path that might wrongly set ->srcu_size_st=
ate for
> > > > > > an atomic srcu_struct.
> > > > > >
> > > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > > >
> > > > > Again, given that we have this commit, is this patch needed?
> > > > >
> > > > > 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SR=
CU")
> > > > >
> > > > > And again, if so, please tell me what I am missing.
> > > >
> > > > Yes, this is a separate transition path. That commit suppresses the
> > > > initialization-time transition, while this patch prevents the trans=
ition
> > > > from srcu_gp_end(), which can otherwise call
> > > > init_srcu_struct_nodes(..., GFP_KERNEL) for an atomic SRCU.
> > > >
> > > > So this is defense in depth for the atomic path.
> > >
> > > Fair point.  But is there any additional pathway other than the
> > > SRCU_SIZING_IS_TORTURE() check at the end of srcu_torture_stats_print=
()?
> >
> > I checked all transition-to-big pathways for atomic SRCU.
> > Atomic SRCU can reach srcu_gp_end(), but its srcu_size_state remains
> > SRCU_SIZE_SMALL,
> > so the transition condition there cannot be satisfied.
> >
> > The contention path is also unreachable:
> > synchronize_srcu_atomic() calls srcu_gp_start() directly and never
> > goes through srcu_gp_start_if_needed().
> > The other callers of that path reject atomic SRCU.
> >
> > The only remaining explicit transition is SRCU_SIZING_IS_TORTURE() in
> > srcu_torture_stats_print(),
> > which currently lacks an atomic exclusion. I'll send a follow-up patch
> > to add a srcu_reader_flavor check there.
>
> Very good!
>
> > So I agree the srcu_gp_end() patch can be dropped.
>
> It might not hurt to have a WARN_ON_ONCE() there, just in case someone
> implements another pathway.

Thanks, Paul. I'll send a v2 of this patch separately, dropping
this patch change and adding the WARN_ON_ONCE() before the
transition check:
+ WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_ATOMIC &&
    ss_state !=3D SRCU_SIZE_SMALL);

if (ss_state !=3D SRCU_SIZE_SMALL &&
   ss_state !=3D SRCU_SIZE_BIG) { ... ....

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > Thanks,
> > Kunwu
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks,
> > > > KunWu
> > > >
> > > > >
> > > > >                                                     Thanx, Paul
> > > > >
> > > > > > ---
> > > > > >  kernel/rcu/srcutree.c | 5 +++--
> > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index 01f224a56b41..74acd5645d4c 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struc=
t *ssp, bool is_atomic)
> > > > > >           raw_spin_unlock_irq_rcu_node(sup);
> > > > > >   }
> > > > > >
> > > > > > - /* Transition to big if needed. */
> > > > > > - if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_=
BIG) {
> > > > > > + /* Transition to big if needed, but never for atomic SRCU. */
> > > > > > + if (!is_atomic && ss_state !=3D SRCU_SIZE_SMALL &&
> > > > > > +     ss_state !=3D SRCU_SIZE_BIG) {
> > > > > >           if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> > > > > >                   init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > > > > >           else
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > >
> > > >
> > > > Sent using hkml (https://github.com/sjp38/hackermail)
