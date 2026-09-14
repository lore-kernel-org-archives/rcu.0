Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF5214A84
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354601; cv=pass; b=HHTdNnvvkVR7UN8WxW63y1WtfxzxKEcdiuYiy9qpSuAvPci/VwX2jtHqowjo8hLoD8fqNe64mz//AX7A92Cni4RY8oQ6onfo+Py87u028JOL6QR1j4sWTFGWO2vGej/y1d56T7RaQZtXpmRFYn8Qz/vYhMDTw1IKRG+omtRzuGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354601; c=relaxed/simple;
	bh=Vro0RFl8YpGJPOlRnygiQ7jO0ulgs5SFhx90iN7YVSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grOs1IPio4FAM3nyiRK1Df5rwVjEL38/ypQZWMJLCBeNjmKI6JDNKossX8scexNSPKo7G0zafO39cQ/GaqoF9zewkWsjo1tVga/dBYgL2df1wmlOrxQPyq0EuUw2c5x+ciktFChHls1ymHGMMSNsTzm4gCocxm9exZTWfklV6/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZij9Z7Y; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZij9Z7Y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so30413105e9.1
        for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 19:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789354598; cv=none;
        d=google.com; s=arc-20260327;
        b=SZbp+Qsksj1NWgqZj+2d65s5OURlK10KD6jujUnUywqC7Qgwxdj3rjqSz6dCW1ELNe
         BoF7i3KCltyCfRL30mD6xQoDL/sjWSzsMj59G9N2xZE2qAi/Mqdgg8Hqri4Ir4DjHBPs
         qLtU15bCidt0AGpW5TBY53LTCnDMU22olMX9IvBuS8DkaBQelAYcjXvbyw5VGfEpke0r
         ZEE32k+KAo+jCG6cp/NuQ70z9pGo0VZWuPB24JtTXbGiEcKi6HwT2UHQQhh1ckKFUZU3
         oKkyQxLpwqHkw7Ge6pafkJa2FoviCK7CEXx3APNIogdpGk1IsLOwLkiymzWQ0+fxVr9t
         v9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fKicCxMIbMqKyjQQQabGvsh6ggRoBKXEKuJu8RTqL0=;
        fh=maey1rXmbxmHNVg1zVJkfUljB9G+w2ppJXHe8qPcZ1o=;
        b=F/+SY14mb7zuHKdsL5ls88eRemfVuISbOZeHkS4EYrZCpjT2paMqq1CC4NmmZaWQ+/
         R+NFTegIiQOE0ao6dmFJMhX7/o50RBUkE6cNZgEr3zslRLLVwmg8RNOW7hpGkLJ5YHbd
         Qxg//SPGIcWVRvfWyWW3nxMbGZ/SNONH6f1ee3D+ep9crBVYUxGJxeAOzx2aYFApXZZp
         b6lFVToHTwbv5WbuPLQYjYOKIxkLLdAqLfeHnhO/lyPm/Yp8y2Zf989hUFXJMOT4QRJZ
         9IVRRnXPBJ9Bl0vE5Q91H+CTh2TSDXiCQCv5gtUwjT23rd6etUiIkN5WFWnD7II1bzjj
         MrUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354598; x=1789959398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fKicCxMIbMqKyjQQQabGvsh6ggRoBKXEKuJu8RTqL0=;
        b=sZij9Z7YmnHAg7oRgBWsoiiNhLmaQsiTKYbUOjKK5A1/6WVAu33upe9mPNs+FgqKvG
         aWmltV/UBzr0FAI2HpHszHvxVOvyRioA5HN5KnQMnP4i7KhCUSxCK3w18XQunFA3IBnc
         F903uoiGdEUPn/wXaf4xgNxFz7f4HETlcxMX2qqdOGHGDoaCDuM2E8vkocIaPlcYeMp6
         0xKF+iQfeju59aMZIpJbzdLc4/xaZiPvk4Ab937fjs1QhkcEk5DPOXjSREvkEcH8pHWe
         VpdOZAia73fknSHnf20iTqKj2dAR7dlV/6hchr37TfrRlsTHGz2ugcHdQYQjV7q1YaGN
         ksFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354598; x=1789959398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fKicCxMIbMqKyjQQQabGvsh6ggRoBKXEKuJu8RTqL0=;
        b=h4QGqcUF5u8CliJj66RO8WaN6Xks8jmRhcVGAecXKIi5/TJQacNOZylWFrhv/J06Qc
         TsJ1UTr+xWvQ9IB9r3XT3Iq3aYPzMnGf3oWcnyRoIEtxSBl5CkqisFgg7GqKToybKS4y
         coTlhbGRkJtCcUcDcqokYZlORTBb3bYbNLxjugy+iAGDsqdrB0FxXmc0PUSVBfVFkKSl
         dGNTX+fA2GnPFzhL24ACvUzyKx7DFrQK37MRJNWwlPUYAsyMpVHW7nkhttvN2DOdHJHo
         No0G1xP9jZurWFtLFSBpSh5v10f3qjyUdSaq3uTULpbywZ4bafrSgkYJ2/143fYRaLVk
         YdPw==
X-Forwarded-Encrypted: i=1; AKwUvBxkuLqiKtVgcYBgzdMWMXupOKWWlPiwixPpXzCbZ9w4kS11SB9OmEBWwUlv6FHG+rU0BBc=@vger.kernel.org
X-Gm-Message-State: AFuF++lcymjKRzAMfM0Gwdi4TMKZyFC/HDSgpFVR4pu5OV4dpeE3RgXs
	DXdjqytZrNy/HcDtIrdwNq7SBov0sAwL1GSWI2AaanCIIZc8YS1AB1qfgMQAP/6mCLzdRYsuE9Q
	xZmHdv2ncmAu9qfPDZSRwSnCs9ZjTe6U=
X-Gm-Gg: AYBFou0x2gufRswRaUzaHesbz2YihOOI/xuZbHQUmg5KpOjXqIYRqah1UjeqnWoXgIw
	0x2vveKrEIIKwVQ+VymGRiOhmZ26ZPw3mc6rLcMuOacH9eIoPW4bj6Muz0LnZ0p82a/YK3oP7Xm
	h0YLFx+mLfDJq5FJ4F/a5765KDrrxkCoQpY0B9o2rih9KTum0T6FdISdO/Lgl7u6cxxBpuSosAh
	v/+gx82Qv/XjSxoWgOe2B+1uiT6mIOWgqwhG72NSkfsxajJ6XAlqqjeih/McytewhGcA1wLG9wx
	2kIK1ryFeL+2et7Eopr/XPrKjGivdOctC3TnFeQOzUSD9De2t+j9VfcZL8J8KNjdx1w9caJB/RY
	xmHIg6sMQonys
X-Received: by 2002:a05:600c:19cf:b0:49e:73d3:78ad with SMTP id
 5b1f17b1804b1-49e7a6859femr5586485e9.18.1789354598480; Sun, 13 Sep 2026
 19:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop> <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop> <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
 <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com> <ab4b7feb3d7ab68ce0de1d1d93d6272b355d7d5d@linux.dev>
In-Reply-To: <ab4b7feb3d7ab68ce0de1d1d93d6272b355d7d5d@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 14 Sep 2026 10:56:27 +0800
X-Gm-Features: AcwNN1Vr9uy0VeobIrFPAZncEAHXBsnAekHunjfGPGNOcbvHf26v4qpcGZ3p1zs
Message-ID: <CAN_Opa_HoUyzuj=h7faDh57JRS-vy746VF0YYjDuXpaiftr46w@mail.gmail.com>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 8:12=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > On Sun, Sep 13, 2026 at 2:21 PM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> > >
> > >  >
> > >  > On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> > >  >
> > >  > On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > >  > > Add the lockdep annotation, same-type SRCU nesting warning, and
> > >  > > early-boot check used by __synchronize_srcu().
> > >  > >
> > >  > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > >  > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >  >
> > >  > Queued for review and testing, thank you both!
> > >  >
> > >  > Interestingly enough, it is now the case that there is a grace-per=
iod
> > >  > wait that can be placed in a normal RCU read-side critical section=
.
> > >  > Does this mean that we should also adjust the --do-srcu-lockdep te=
sting
> > >  > in tools/testing/selftests/rcutorture/bin/torture.sh?
> > >  >
> > >  > Thanks, Paul. Good point.
> > >  >
> > >  > I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, inclu=
ding the
> > >  > case where `synchronize_srcu_atomic()` is called from a normal RCU
> > >  > read-side critical section, and follow up with the necessary tortu=
re
> > >  > testing changes.
> > >  >
> > >  Sounds good!
> > >
> > >  Perhaps you and Zqiang can work together on this. Co-developed-by,
> > >  for example.
> > >
> > >  Hi, Paul and KunWu
> > >
> > Hi Zqiang,
> >
> > Thanks for pointing out these cases.
> >
> > >
> > > Should we also consider the following situations ?
> > >
> > >  idx =3D srcu_read_lock_atomic(srcu)
> > >
> > >  by interrupt run hardirq context:
> > >  synchronize_rcu_atomic(srcu)
> > >
> > >  srcu_read_unlock_atomic(srcu, idx)
> > >
> > For the same-CPU interrupt case, the existing check in
> > synchronize_srcu_atomic() already catches it:
> >
> >  synchronize_srcu_atomic(ssp)
> >  RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> >  "Illegal synchronize_srcu_atomic() in same-type SRCU ...");
> >
> > lockdep_is_held() resolves to __lock_is_held() (lockdep.c:5612),
> > which checks current->held_locks[]. The interrupt handler runs with
> > the same current, so it sees the SRCU dep_map acquired by
> > srcu_read_lock_atomic().
> >
> > >
> > > or:
> > >
> > >  CPU0: CPU1:
> > >
> > >  idx =3D srcu_read_lock_atomic(srcu)
> > >
> > >  smp_call_function_single(CPU1, som_func, NULL, 1)
> > >  to send IPI to CPU1, and sync wait complete.
> > >  hardirq context or ide task context:
> > >
> > >  some_func()
> > >  ->synchronize_rcu_atomic(srcu)
> > >
> > >  srcu_read_unlock_atomic(srcu, idx)
> > >
> > The cross-CPU case is different. current->held_locks[] is part of
> > struct task_struct (sched.h:1302), so the existing
> > __lock_is_held() check can only see the current task's held locks.
> > It cannot see the SRCU read-side lock held by the task running on
> > another CPU. The same limitation applies to the
> > lock_is_held(&rcu_lock_map) check in synchronize_srcu() at
> > srcutree.c:1665.
> >
> > >
> > > Add WARN_ON(irqs_disabled()) to synchronize_rcu_atomic() ?
> > >
> > >  Any thoughts?
> > >
> > WARN_ON(irqs_disabled()) wouldn't help with the cross-CPU case:
> > CPU1 could be running in process context with interrupts enabled, so
> > the WARN would not trigger. It would also add a false positive for
> > legitimate hardirq calls. synchronize_srcu_atomic() omits
> > might_sleep() (compare __synchronize_srcu() at srcutree.c:1676)
> > because it is designed to work in contexts where sleeping is not
> > allowed, including hardirq context.
>
> If runing in hardirq context, we should use raw_spin_lock_irqsave_rcu_nod=
e()
> and raw_spin_unlock_irqrestore_rcu_node() to replace raw_spin_lock_irq_rc=
u_node()
> and raw_spin_unlock_irq_rcu_node() in synchronize_srcu_atomic().
>

Thanks, Zqiang. I'll take a closer look at the IRQ-state handling and
consider the change. If a patch comes out of it, I'll add the
Co-developed-by tag.

Thanks,
Kunwu

> Thanks
> Zqiang
>
>
>
> >
> > Whether a general cross-CPU read-side-hold check is feasible is an
> > open question. It would need to account for the read-side state across
> > CPUs without adding too much overhead to the SRCU read-side fast path.
> >
> > I'm happy to discuss and explore whether there is a reasonable way to
> > handle this cross-CPU case.
> >
> > Thanks,
> > Kunwu
> >
> > >
> > > Thanks
> > >  Zqiang
> > >
> > >  Thanx, Paul
> > >
> > >  >
> > >  > Thanks,
> > >  > Kunwu
> > >  >
> > >  >
> > >  > Thanx, Paul
> > >  >
> > >  > > ---
> > >  > > kernel/rcu/srcutree.c | 8 ++++++++
> > >  > > 1 file changed, 8 insertions(+)
> > >  > >
> > >  > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >  > > index 6a9c432a3bd0..6c729e805fb3 100644
> > >  > > --- a/kernel/rcu/srcutree.c
> > >  > > +++ b/kernel/rcu/srcutree.c
> > >  > > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_=
struct *ssp)
> > >  > > unsigned long rdm0, rdm1;
> > >  > > unsigned long unlocks0, unlocks1;
> > >  > >
> > >  > > + srcu_lock_sync(&ssp->dep_map);
> > >  > > +
> > >  > > + RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > >  > > + "Illegal synchronize_srcu_atomic() in same-type SRCU read-side=
 critical section");
> > >  > > +
> > >  > > + if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> > >  > > + return;
> > >  > > +
> > >  > > // Initialize. Either init_srcu_struct() was invoked or
> > >  > > // DEFINE_SRCU() or similar was used. Therefore, no allocation
> > >  > > // will be done here.
> > >  > > --
> > >  > > 2.43.0
> > >  > >
> > >  >
> > >
> >
