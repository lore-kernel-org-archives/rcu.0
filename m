Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C853E3C5A
	for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294999; cv=pass; b=Aekl+12Ijt/vvNOK8fX+AY+csEMhuZKNw/mrLGBQ3ahXVEzZJtsQcZ297moITXk6JeFh9AH2ojgZH+gBaaptrODOtIq4TLG+6XCQHofHYKP3QrW+mQaVaAAVTD4WIFdfOf1YU2SGihYXXXRoT/0YLvDDM8Swwo0nWu407rGjQok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294999; c=relaxed/simple;
	bh=/da4xkkbWlUHDywNO7yl9JugHyvKv1izVJBOYQ0OiJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFHQxCA9JWz4FaekTurFY180NRh52mg3+dF/tql3pLRG8l364GHqe3rYAO5O+OkUTPbz8gZnLfcX+SuVuRpxAh8msWDlPnkoO7yD8PENWBKfySvEXI/CnoVOziM8nYGiAxwfOo9m0GLshQt+0P2fJyY1D4CgqVkbSVYI/OeC7sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skQSwERv; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skQSwERv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so4652805e9.0
        for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 03:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789294994; cv=none;
        d=google.com; s=arc-20260327;
        b=NzjPbYPHl1dmu0AeJxeJTFYX6LMNxEgq2hsOXAXmqkMO0pYzNt+Xi5LciyIwWYPjFD
         a3RlInOhIy83+r5a8xImG8Qs0bg4AEvYdbn2AwQFXMyQYuGsNPIX7Dnz+BMAqS18kIiP
         QR0pF3QwbMtJdKtHczQe1Dn4pmh1+krQKn9HIzMMU82oiQmmJ9rvI1KD+6/StlpcjJ9z
         LWq55R82cI5iTzRxiVXkfGqTQOIeVAANQcaB52ugur5DomFD6g34PMkLQF5TrSVqfIql
         89BS0lBeR5x2VxTadU5P11CQ1CAZaygGOIUCRvC0fCtke+H1poSVTXC+Sr/7/SNeiovS
         b9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VeM8lzHtsZzkcva1GsyD3J3hMDsbPZApqdfMt/qqPl0=;
        fh=mnFEiEApRg2G/EDx6lRe1P+ekVZupWGPbNp9jw7EeM0=;
        b=VCOS+8lYePOczoPu084YsGlAtioH/9gwPNTW0fy32VpkW0ph4LldZZlU5Hvd8BQYwQ
         XeNH+AwbCT034EeWaDzeXUIRbEH+GoqziF7Sst0XCqws4CoMrUESlSpn4Eagm0TkPwtq
         Diapk3VDcG1PGumL6133jrlgGVfs7OU0ZZ99hgPJv9s7psT1QZ5Xk8EpQuMfkx8E3x7b
         WN/T3RDcOnYG1WLER3nHjMP1C4GBzkL6QkuiI9CLVi3j5ZmLjFk5tb0CUvpjwT7HxmQP
         rQZHxkeNnJhQaPICr37sKjLDOXq3v+m4InBwEfIMSxU4muoywnDQUWF90XHdNgcFDlR6
         Ot1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789294994; x=1789899794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VeM8lzHtsZzkcva1GsyD3J3hMDsbPZApqdfMt/qqPl0=;
        b=skQSwERvYlWccqJGkZx6nj/wjIhO4THnr2OGkrGl9cq+PiSVo++5k3ISUoDiPPTk1E
         6dy7lOXqMFsKSUQYEM01dp21F5lJ+Y1pXBhhld1LDyIslRK6ZGbEofZHnQ2y3dtQ9W7w
         RJbc6zj8uVg52cUe9fkIeOVwKCNYN+9Db4xEss6/eSpztrvfeusF4PqmOLhGQfdxyDFe
         jg7RuW0iy1BTFwMfBEjPKRjUD8pfbAhqCmECKq8Jt54/zfWLK885l5y1i2SLH4deH4nu
         Ys5my4AXgysGNf30YSqUUE201RZr43AjTHo9OzjmelaijGQlHDvVZhQztn0SmIHcmisd
         YJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789294994; x=1789899794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VeM8lzHtsZzkcva1GsyD3J3hMDsbPZApqdfMt/qqPl0=;
        b=LCTcKU5Rpcx+QdgJrVcszQ4eHEeq+b0ChqLF62nnDaDEmfYcplZuEqIOcXlt7NayEw
         WlqvYnLmXB/soge/7/Xqj3o1Vwt4vzO1Fjyf9MHsP3jrYPfPK23QOuFsEaM96OlmZ7gB
         3Dw0NEIBcbc8mTZ28Bh39eqhWnMkyVeqWrYQCfSDKoA15f9LYSKP4I+c/vCsYb2fkEOo
         RwvUl8hdA2qj0iGlCfDMaqqQd7lw/jW+MwDze53pws405IlT0LEEEf6kIYwVDV+vFbFb
         ouuBN/OAJ8kE3+1pFf6FC7+qvCKKxAqP7WP+DH/+TgDDgN6WHbbJP890fORrfejX52Xg
         cyxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYJrt2BMKFP2B9dZkECqkBKp3ol7jPbmiPdGZ48pRiSbwB+49PniC8wQjCFjVq15P+6v0=@vger.kernel.org
X-Gm-Message-State: AFuF++kKaeDxXzdhPASD4o738Z4Vi1IVtXvTNkQxcpKj94NfcIMbOLDI
	s5KQVESVn9a604nudkh9KHTYjtu8h3e6zkGmd2u/jEDgd0ItXM/yUvf9HR56y7TsOF5eBVc0+bC
	GnR8QEItZfqZqZ8Tp+o0J82yP7iXiVJU=
X-Gm-Gg: AYBFou2wiCwMmUtwulv0jK+goMDaSXZZ7+JjeERQdIZJda7r7QnGzEH0B0VnQaiNeEX
	Dj7ZjZukU2sdyoZfv/oZR8FvDwdlZViFfnrqFKGzzRPvh9yWpVfVfTq1iWVMfRd8f7boeMLYt8x
	UNDU7Wc7ShBaE2yHL2DoopY3ivYhvAe04jgis9J09RxMpWYwGEybAPPwvajhSo1LBOgKRxhItxx
	anKv/l8YDii7bt0doH7DTfpPXCBJAJxuzqP1js5kKXZrXoCBymqzJTHVG41vGIvyICE9qYTUXzW
	Qf/AvnzUbRU0Ik8J86RkOKa6BSLDXLluuyr5URVUD0FPCiZACO3ZUXdEBOLFNWdEJKMOMMnZmQd
	FThlxG7lLYogGVg==
X-Received: by 2002:a05:600c:540e:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49e66922810mr204293965e9.2.1789294994225; Sun, 13 Sep 2026
 03:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop> <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
In-Reply-To: <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sun, 13 Sep 2026 18:23:01 +0800
X-Gm-Features: AcwNN1WLPFwN4p6tzjGquIodVYiq-ve1ku2FdgLQ3j_nNSAf-QvPE_xuEryTmjk
Message-ID: <CAN_Opa88oCHV+TGUmAzDLdfnmZ78oT+_vFttkMQEQ8uHuW8-ZQ@mail.gmail.com>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
To: paulmck@kernel.org, Zqiang <qiang.zhang@linux.dev>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 2:50=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> > On Sat, Sep 12, 2026 at 12:47=E2=80=AFAM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > > > Add the lockdep annotation, same-type SRCU nesting warning, and
> > > > early-boot check used by __synchronize_srcu().
> > > >
> > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Queued for review and testing, thank you both!
> > >
> > > Interestingly enough, it is now the case that there is a grace-period
> > > wait that can be placed in a normal RCU read-side critical section.
> > > Does this mean that we should also adjust the --do-srcu-lockdep testi=
ng
> > > in tools/testing/selftests/rcutorture/bin/torture.sh?
> >
> > Thanks, Paul. Good point.
> >
> > I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, including =
the
> > case where `synchronize_srcu_atomic()` is called from a normal RCU
> > read-side critical section, and follow up with the necessary torture
> > testing changes.
>
> Sounds good!
>
> Perhaps you and Zqiang can work together on this.  Co-developed-by,
> for example.

Thanks, Paul. I'am happy to do that.

@Zqiang, your suggestions on the additional lockdep cases got me
started, and these are now incorporated as testtypes 4 and 5.
Paul's observation that synchronize_srcu_atomic() can legitimately
be called from a normal RCU read-side critical section led to an
additional regression test (testtype 6).

In particular, testtype 6 verifies that calling
synchronize_srcu_atomic() from within rcu_read_lock()/rcu_read_unlock()
does not produce a false-positive lockdep warning.

The atomic SRCU same-type nesting cases are covered by testtype 4
and are expected to trigger the RCU_LOCKDEP_WARN() in
synchronize_srcu_atomic().

The changes are in rcutorture.c and srcu_lockdep.sh; torture.sh
does not need to change. The testing changes are basically complete.

@Zqiang, I'm happy to add:
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>

if you're OK with that.

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
> > > > ---
> > > >  kernel/rcu/srcutree.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 6a9c432a3bd0..6c729e805fb3 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_str=
uct *ssp)
> > > >       unsigned long rdm0, rdm1;
> > > >       unsigned long unlocks0, unlocks1;
> > > >
> > > > +     srcu_lock_sync(&ssp->dep_map);
> > > > +
> > > > +     RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > > > +                      "Illegal synchronize_srcu_atomic() in same-t=
ype SRCU read-side critical section");
> > > > +
> > > > +     if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> > > > +             return;
> > > > +
> > > >       // Initialize.  Either init_srcu_struct() was invoked or
> > > >       // DEFINE_SRCU() or similar was used.  Therefore, no allocati=
on
> > > >       // will be done here.
> > > > --
> > > > 2.43.0
> > > >
