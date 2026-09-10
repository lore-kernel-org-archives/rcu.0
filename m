Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736563769FF
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010317; cv=pass; b=IW5MOdw+0oxBTvm+tRi4haZkNUtCiSl2fcQpVRk7TsSGbRSdg9aysZKph4N86hlValIDthuZOIhlpkApl3IWc9vabxFyNcHJFYEOzh0P6oGq+7wlbyupP7+m5exzIn/v2BFlaw5wQol3hQlrMS9quWoXWrqDXDw0gJ0y59pKrkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010317; c=relaxed/simple;
	bh=PK3V4pO0nQq8ImMS+8EDswh2WVF/9QziGBZ1wCEdZHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0yXrU504r0JqNpIQxa7B8ePBZj1XqUP1SHz3+9YispO+8/nXphxf33OuvXM5pKjcq2MXE7V15JR48YIWc/eFR+noIoyrzbRkqgjZLkd9LVtm0Bh8TEIktndUZxGfwGc4KsxBrz8m0DrrFi+TWS/BYe0zuqBsK8QoiYQUNfa1vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K44tEMOV; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K44tEMOV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so10826325e9.2
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2026 20:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789010314; cv=none;
        d=google.com; s=arc-20260327;
        b=p7S8FSiMy/qyzbj1DkYC+VytEovxheXqDaQNVIgOs/uLGtSQDiAVpCMksEah/wqwf5
         o2mVXioYMm3Us/gKEOGfOSg+5gGZQAjVLUS3V4c7TLY4Vza8YwdlJe6IwDUpgYpbR1Ch
         NEtBAVKdXpwWSm+wXHckrYm+wlGs54PPuUUOEEzmKO2W2KLRKk12Cq++UuAMf5hjiBvk
         F7DQxM7DugJN2fALyIniC3Sd1eNvl84D4uidtIYAqszeBivDgfxc45s6yJR4Tx4iWIpa
         LcgS0sPwRHi8QI+lh5fSn1nOQwk9r4o0NSxu3SaDQy9VJdt65vAoaNChSXZpJI4IXtpK
         Opog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bYCYo7thivgEtrRJGBtPc0MTPiaYgTaBPaROJxY94cY=;
        fh=xHUOvf9xn9UHARmQm5g85Tk1/UateClCM7ZOVZcsShw=;
        b=FaWAge/AiEAozvKGl6V3+3rPTygS1vHD2oy3t17Vh+Xgx3tvswrN2AzWly74g2o6lF
         w70X+jhEQ1HtSkaLk+6cpdR2DHTPEKvAqC23dJWUfPG0LcSYtChMEodtNfgy9whXAjmn
         Tc2NkbAlAyxJfdsDe6YerW0ZSrP8cVP1D1pNdOFfMRwVt3sSvqT9FXl0Yqxea1Cr5oaS
         RviQuqFWoV0R5X6go9m0Gv2q2t1kiWkYrvBKhkrPPBkNqG1s0VZUfKQVMmjue+nDhYci
         q+UGy2q0dabSJx0Qx/ok142wOviez7e6nxYpY53t8kc3vDWFWX2q9blQTf/RNWTuraNl
         46rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010314; x=1789615114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYCYo7thivgEtrRJGBtPc0MTPiaYgTaBPaROJxY94cY=;
        b=K44tEMOVcGuXY0iIl64h6sIoJg3eR+EH4X8mwHOHdNBoQoVFGh4NFUst1h5AGBHX0i
         dc/ulj1Y5BmqP2BwmJlpa378N5QE8QAVmiTTih5EBuGuHmfiiXceF3HxMQXcgslN4/9C
         5a8O/arzwtOhSnFzDI0eD9jEI7ypMa3ySvvYg1lTMzfxApBykR48NgSYQzHuGfvFkZsJ
         Ws3+TGLKzwiUen8CWCATSmToo38chMjDRvM5o8rPxLFbUTiYXNYsToKUXe8AwLj4YqRL
         CujB9STTKaWPhvRaRLKAzQGPVdfPmjgY3J83wP5GLshxx2t3mQQMXaxL+rCIPisqIT2m
         wEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010314; x=1789615114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYCYo7thivgEtrRJGBtPc0MTPiaYgTaBPaROJxY94cY=;
        b=svIdp/NgMwqOEs4oOCw7BWxkEAsGt6DQHo8MHVqPl8eJBfcEBkzz3D6SYWJyCKaM+U
         HVcYXFXvh4LJuY01wO//3y/f+5j2VSwWUo5eadoKdA5gsAlMuSbnkh94hzsUSUaoRaIu
         z5FW/SRt/mxXf+vTNvM9UbolM05e1ZgAsTubSgtME0698DAgdnqo+/o8dI/nStQ7WdAT
         aNH3th/7x8Ih39x5aQHoyW4fyCetQ8IzAkFsfoxhFN4McVfQZSx7ZKi8ynGFuelOFOCm
         uebxYrs9xqhz9QaBo5zDyPfx2tj0xr/O7+B6OHQQaFGElPGiS3NaiJD3IY75SCb3odbV
         fefg==
X-Forwarded-Encrypted: i=1; AKwUvBxEZBO+ZGFg1twKCp5jeC8hvjkS5C/o7UySUg4+V8swLs9tImDdGvwiK7OJsucD75u0PzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k1JMuyKubbHmbffsgEvMHwYoo8IIln7XCFafX4qL+IZGGj1wDf
	jiqb09mTGCl0SwRlQgHAhCMhltvxZCF+7viatvtyXe4LbEWaTfbYl23m982KdCacc6tjm6FrkOn
	UEfxGADTSb8gbQIkiLUzaUwf1dxB7Z4Q=
X-Gm-Gg: AYBFou3toDJw3VvdFwz5AnC6zrKgxiqq1M0ED9rWDCYuyj/S6ctKfSBp1nMkBJ+0ZXy
	FLS08FFDIaie4aZbE9xgPX6/3CJBuyp8blUM+HFe1BgJfcQraycQUpK4C+kRLeJ5+v+AZlXmD6Z
	aOY9g7WOAHmm8zMFfXdxNOsoKXficdfclwr251Ey4u6qGj2puC8O66nV1GQah4Hz1AlLa/Snzbu
	UuBqbqBp7gNDBp5V+le8wBsmCVPqbA1P76uRBsWqnSGn3r96xjnL1hyS/fA3Oi107U857e1FPmb
	BuhuyYGQNa5R5cN13rh+UIQn8JmNiaizqNLotgeHvqws4hokGDlCCJJl5BOKfDMDdpk1ZHZSNA5
	QKFucgR9oeR6NbGjJ514+7Fc=
X-Received: by 2002:a05:600c:83cd:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-49d1f21ae99mr119577005e9.3.1789010312835; Wed, 09 Sep 2026
 20:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
 <20260909024515.2429893-1-kunwu.chan@gmail.com> <8d5c8d6f-6788-43bc-b5e3-c8bca8e984be@paulmck-laptop>
In-Reply-To: <8d5c8d6f-6788-43bc-b5e3-c8bca8e984be@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 10 Sep 2026 11:18:20 +0800
X-Gm-Features: AcwNN1VUdC9e2QkYyY4TGz91uSqz4ZMlQL4Cku5cqOiYtnuh8aPNtTInEfiXpM0
Message-ID: <CAN_Opa-FsrNsQM5WPCGBkQ43ECps36e_KyTzG9niEnm6KpdBEw@mail.gmail.com>
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 8:13=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Sep 09, 2026 at 10:45:14AM +0800, Kunwu Chan wrote:
> > On Tue, 8 Sep 2026 16:38:19 -0700 "Paul E. McKenney" <paulmck@kernel.or=
g> wrote:
> >
> > > On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > > The transition-to-big code path in srcu_gp_end() calls
> > > > init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
> > > > atomic context reachable from synchronize_srcu_atomic().  Atomic SR=
CU
> > > > has no use for the srcu_node combining tree: it has neither callbac=
ks
> > > > nor srcu_barrier() operations, and its grace periods are serialized
> > > > by ->srcu_atomic_gp_flag instead.
> > > >
> > > > Skip this transition entirely for atomic SRCU, which is also defens=
e
> > > > in depth against any path that might wrongly set ->srcu_size_state =
for
> > > > an atomic srcu_struct.
> > > >
> > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Again, given that we have this commit, is this patch needed?
> > >
> > > 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")
> > >
> > > And again, if so, please tell me what I am missing.
> >
> > Yes, this is a separate transition path. That commit suppresses the
> > initialization-time transition, while this patch prevents the transitio=
n
> > from srcu_gp_end(), which can otherwise call
> > init_srcu_struct_nodes(..., GFP_KERNEL) for an atomic SRCU.
> >
> > So this is defense in depth for the atomic path.
>
> Fair point.  But is there any additional pathway other than the
> SRCU_SIZING_IS_TORTURE() check at the end of srcu_torture_stats_print()?

I checked all transition-to-big pathways for atomic SRCU.
Atomic SRCU can reach srcu_gp_end(), but its srcu_size_state remains
SRCU_SIZE_SMALL,
so the transition condition there cannot be satisfied.

The contention path is also unreachable:
synchronize_srcu_atomic() calls srcu_gp_start() directly and never
goes through srcu_gp_start_if_needed().
The other callers of that path reject atomic SRCU.

The only remaining explicit transition is SRCU_SIZING_IS_TORTURE() in
srcu_torture_stats_print(),
which currently lacks an atomic exclusion. I'll send a follow-up patch
to add a srcu_reader_flavor check there.

So I agree the srcu_gp_end() patch can be dropped.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > Thanks,
> > KunWu
> >
> > >
> > >                                                     Thanx, Paul
> > >
> > > > ---
> > > >  kernel/rcu/srcutree.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 01f224a56b41..74acd5645d4c 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *s=
sp, bool is_atomic)
> > > >           raw_spin_unlock_irq_rcu_node(sup);
> > > >   }
> > > >
> > > > - /* Transition to big if needed. */
> > > > - if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG)=
 {
> > > > + /* Transition to big if needed, but never for atomic SRCU. */
> > > > + if (!is_atomic && ss_state !=3D SRCU_SIZE_SMALL &&
> > > > +     ss_state !=3D SRCU_SIZE_BIG) {
> > > >           if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> > > >                   init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > > >           else
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
> > Sent using hkml (https://github.com/sjp38/hackermail)
