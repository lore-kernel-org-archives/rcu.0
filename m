Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA34A0F12
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143470; cv=pass; b=as19d6145BJTFHBHg0Yla+0YzqJmM55GgsMWuG+MjUQyQ27PCE4gY8Z80b/x3iXPI1X7W8KFpN/EcSAS6DDgvy2d4Jcg8jlu+PmiWqcfy5Vt4k7/TdUrztuMAK1bLa9SrJ6XD6JW4sas2VZf0+7O6zEtRJPrfzvaO66d567Gluc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143470; c=relaxed/simple;
	bh=d2NARwSM5CujWWz4RVSNUlwfPrsmtXGPc2+2aQs4Q6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbjOWG5zt1nxamrtvjZ8nlq8uQU9OzYw+54KHWKdYBYhO8uJ12hWkr+8uy3L6WHa9lwJbRIf5PPHx5MV6iFaFAKsMw3fFaxKSbPiOAFPIEbPcSDMNhJ8OplKEq0piJz0uRuUTSnVURDMzL7IWgQqtSaeMat5sp93w6Q16b/GYGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQk7VRtF; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQk7VRtF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e6b280cadso514635e9.1
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 09:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789143466; cv=none;
        d=google.com; s=arc-20260327;
        b=fnCzMjNPcZsAupnwq4PSqZQAq2jdQavT1aiimk6208omRtlYVkG7d5viTrt2aakH7/
         Pj9rakrLDRG/TAHCbFea0QuGBHpjtFgrFxKw1x17AhazoApE36hslQt2lgHhAh1o34hj
         z2p+JAa6lCjsFFpOCBDJiGartSmd61yCuxeduppjEQAg2OdoHOBXSUwdkINLiiXP8Xh4
         WMduX+tIH5t+AKfqQaoA3diknzBiq90nilKVIZ5h35QlRg3ahF3/mfurdwo7SghpQOB1
         kKIj3HyGx5jdj+N4W9sGQobWqUJLJp6eoChrhnn4xYvQ/btXp9hUkDRm+cGA2IfFRfaY
         iYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3B3jIY9BMAO73EjPySXApoH4dZwYFyO5LCD/ae6l1A=;
        fh=93WH9O7+UafJoFTCf5MNn6m7BxKTw5M0fDGf6tFbCes=;
        b=ADRv2CClMJuQQ8GrVSxiIa+84NSIW3dXIWh9mmdAeePo9HfU4ktpXzSGqADpCGFlCN
         pob0eLwCjOpqmpvVyErym5VkmcQhASm1wIElQc2l4d9uLJ2oDObFZ3nY8KXXezu/fTEH
         uQXdyyQFUyquoHImqOA66T8eRyeOYdCWlld4DiW8V+FUNfN4ofwL3EuZw4bTcyjjgbBo
         8qNVxvlEC2WF51hPZ4+CwEhRuqQMtzYpN2RS+ZrVHdx4BRYm/FPQZksAtmrneSUE7rWB
         KZ+PMch+bf6PPZ4Zted3CriWXWZgmdcJrmeA6276xozsLC5vlDPEjafQfg+D42/hY4VK
         24jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143466; x=1789748266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3B3jIY9BMAO73EjPySXApoH4dZwYFyO5LCD/ae6l1A=;
        b=MQk7VRtFSeHrBIkGZpWkjvrncaTVZvzN0RWJuZdifI2K3Y5NtnPd5Jd3nRWbOKW1ow
         9/GdIdiRKzBY3VgUUFIAeDEatuYu7MOQ/YOPaMICts7llPmLU3N9I8zz7s3Sla9iiJoy
         hFXk5c2VWdwnTbD+C2xCQKOLw31NvKZWIPbZZxcpl0OnWqaba9eob6SZjRqL9vg97uKG
         n3vNrF4vw0YbdgGFBROwczLcrZQSkCq5ljvZl1Vk3SdKBHzy07D7SLdmykNWQrbDW/NH
         HXukQtX+s5PHkfGTCIOorLUAK1/SgO2jw9WAjFm+KVCLbVZUAfs3KggQV1zi5LCkpF2n
         61DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143466; x=1789748266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3B3jIY9BMAO73EjPySXApoH4dZwYFyO5LCD/ae6l1A=;
        b=hVgZMfISEpNWpBmyF0e+57D9xEeNj8wr4BbwMz+38mTUWHWFnIruK3u120+o7r3LBn
         EW41mH0HFI6XssTn4jS4Fwedse05mfqWe9r6V70n2JSplEcxyhyovFA2AHoTeLASbsdZ
         7u/cdQ6hAQwVwYYvgfvVfEKAA8EzQXuTjskq7F35GgFMV4xFAhUJCswarSWI6uFVWImf
         9SMpYxEBWRBVSfFV3jc5oT7/LT36xVLhWRZgr19E6NKqjonwhVi/cOmtAH+qcymIOFfp
         REAOtgYX6dfUo8I4KJUkYigovczUtcYdM3GCgmAYtYWHSUzsYPO5E+sr3JIc7FjtnrmD
         h2Gg==
X-Forwarded-Encrypted: i=1; AKwUvByiWj3NJn8zLq4pDtYPcPWnKzoNbTsxUI9NDfW9IV2WdiXu7wjWJcNtyughCh92piCfJ6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kPZ7w9+iNgtxVtEStfjNPblqY8yRyM7VGVkkp29eB6VuUlllUF
	ePcR1E1iXcFCKOLgeifznfehKpWFztdlkQi/BlWQz66xbkP7eFLkcMIVOQPv96P0z+suaVW3+TA
	qNxRcFAbv9iCMNLR8jOWfRLl8JQibaOo=
X-Gm-Gg: AYBFou1vkXqcn3kJZoG3iHEeB7+SkbC+GomnmaVsgHlQPvNifFI48nE3hils2Ckt2mK
	eht7fC542t93eihrtLFcrEc66CB7PtHI2ZXQCn7eW2l1iYEjXaZ2eYzqveMEmytw3PONUUIgCMs
	bmDDRRAKeiSc/pMwGaXNKFPIGO4zptTWywSebU4nDIW6F3SOykk5uBGoXMgJKSGd5zM7/zA81Kg
	dNFKvdNt2YpJTHcni+3kmuvtaWWrAx1LEgvHJOGLih3N83l1cL3AT0hiDEtBSYheFT6KzF2p7Cb
	IHQ+mvRJnRvTNU+IYcpnCQpky/4+SV3zGHP/pUVIshcmqzBRopUjq56x+D0L7H1EaFnqcophH0m
	7BCNnqtj6y0ZB
X-Received: by 2002:a05:600c:4fd4:b0:49d:462:6eda with SMTP id
 5b1f17b1804b1-49e619d1ff0mr51367345e9.28.1789143465554; Fri, 11 Sep 2026
 09:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35d6d803-41d9-48d6-a8d0-b8d0f6f67efd@paulmck-laptop>
 <20260909030253.2430897-1-kunwu.chan@gmail.com> <e5b02d91-feb6-4dd7-b67e-8faaa662a610@paulmck-laptop>
In-Reply-To: <e5b02d91-feb6-4dd7-b67e-8faaa662a610@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 12 Sep 2026 00:17:31 +0800
X-Gm-Features: AcwNN1UivAboB_X_FFkAi7v_7v2lCZi4Gop_-JJ3SFIKGoWYCFPJMHz09G1Rd2c
Message-ID: <CAN_Opa-nwU8TWLmGTLuOH0zYnxGVsWdTUrK29M9MfVhxJBYL4Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] litmus: Add SRCU fastpath anchor-before-scan test
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:51=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Sep 09, 2026 at 11:02:51AM +0800, Kunwu Chan wrote:
> > On Tue, 8 Sep 2026 16:58:31 -0700 "Paul E. McKenney" <paulmck@kernel.or=
g> wrote:
> >
> > > On Mon, Sep 07, 2026 at 03:58:17PM +0800, Kunwu Chan wrote:
> > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > > synchronize_srcu_atomic() may end its grace period immediately when
> > > > its scan of the per-CPU lock counters finds no readers.  Correctnes=
s
> > > > requires the grace-period anchor written by srcu_gp_start() to prec=
ede
> > > > the smp_mb() ordering the lock scan.  This ordering ensures that an=
y
> > > > reader whose lock increment is missed by the scan cannot have
> > > > incremented its lock counter before the grace-period anchor, and
> > > > therefore cannot be a pre-existing reader of this grace period.
> > > >
> > > > This litmus test models the key ordering between the grace-period
> > > > anchor and the lock counter scan, where "seq" models the
> > > > grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > > > ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > > > smp_mb() and the lock scan.  P1 models the reader-side counter
> > > > increment, with the smp_mb() of __srcu_read_lock() following the
> > > > increment.  P2 models an observer that sees the reader's increment
> > > > before seeing the anchor.
> > > >
> > > > The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > > > SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > > > which permits this outcome.
> > > >
> > > > Tested with herd7 7.58 using linux-kernel.cfg.
> > > >
> > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Litmus tests!  Very nice!!!
> > >
> > > Could you please put both of these in Documentation/litmus-tests, in =
a
> > > new "srcu" subdirectory?
> > >
> > > One thing for your consideration is use of the "filter" clause for th=
e
> > > first term of your "exists" clause.  Not a big deal at all for this s=
mall
> > > of a litmus test, but the idea is that this litmus test only cares ab=
out
> > > the 0:r2=3D0 case:  If that condition does not hold, then P0() and P1=
()
> > > aren't the beginning and end of a valid SRCU read-side critical secti=
on.
> > >
> > > Use of the "filter" allows herd7 to abandon a given execution early,
> > > so it is a big deal for larger litmus tests.
> > >
> > > Again, what you have is fine (or will be when moved to the other
> > > directory), just pointing out the additional feature.
> > >
> > > If you would like to see a use case, please see:
> > >
> > > Documentation/litmus-tests/locking/RM-fixed.litmus
> >
> > Thanks, Paul.
> > I=E2=80=99ll move both tests to Documentation/litmus-tests/srcu/ and us=
e a "filter"
> > clause for the first test as suggested.
> >
> > I=E2=80=99ll send the two litmus tests as a separate follow-up series, =
so this won=E2=80=99t
> > hold up the current atomic SRCU series.
>
> That sounds good, thank you!
>
> > I=E2=80=99d also like to continue maintaining the SRCU litmus tests as =
they evolve.
> > If you think a MAINTAINERS entry for the SRCU litmus tests would be app=
ropriate,
> > I=E2=80=99d be happy to prepare that as well.
>
> Why don't we take a longer-term approach and work to get you up to speed
> for maintainership of SRCU, rather than just for a couple of litmus tests=
?
>

Thanks, Paul. I really appreciate the support.

I agree that taking a longer-term approach toward SRCU maintainership
makes much more sense. I=E2=80=99d be glad to work toward that and take on
more SRCU development, review, testing, and LKMM work as I get up to
speed.
I=E2=80=99ll keep building on the atomic SRCU work and look for opportuniti=
es
to contribute more broadly to SRCU.

Thanks for the guidance.

Thanks,
KunWu

>                                                         Thanx, Paul
>
> > Thanks,
> > KunWu
> >
> > >
> > >                                                     Thanx, Paul
> > >
> > > > ---
> > > >  .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++++++=
++++
> > > >  1 file changed, 56 insertions(+)
> > > >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-a=
nchor-before-scan.litmus
> > > >
> > > > diff --git a/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-b=
efore-scan.litmus b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-be=
fore-scan.litmus
> > > > new file mode 100644
> > > > index 000000000000..8200a75e15ef
> > > > --- /dev/null
> > > > +++ b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-s=
can.litmus
> > > > @@ -0,0 +1,56 @@
> > > > +C SRCU-fastpath-anchor-before-scan
> > > > +
> > > > +(*
> > > > + * Result: Never
> > > > + *
> > > > + * The synchronize_srcu_atomic() fastpath may end its grace period
> > > > + * immediately when its scan of the per-CPU lock counters finds no
> > > > + * readers.  Correctness requires the grace-period anchor written =
by
> > > > + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> > > > + * This ordering ensures that any reader whose lock increment is m=
issed
> > > > + * by the scan cannot have incremented its lock counter before the
> > > > + * grace-period anchor, and therefore cannot be a pre-existing rea=
der
> > > > + * of this grace period.
> > > > + *
> > > > + * This litmus test models the key ordering between the grace-peri=
od
> > > > + * anchor and the lock counter scan, where "seq" models the
> > > > + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-C=
PU
> > > > + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before =
the
> > > > + * smp_mb() and the lock scan.  P1 models the reader-side counter
> > > > + * increment, with the smp_mb() of __srcu_read_lock() following th=
e
> > > > + * increment.  P2 models an observer that sees the reader's increm=
ent
> > > > + * before seeing the anchor.
> > > > + *
> > > > + * The outcome is forbidden by LKMM, and herd7 reports "Never".  S=
ee
> > > > + * SRCU-fastpath-scan-before-anchor.litmus for the reversed orderi=
ng,
> > > > + * which permits this outcome.
> > > > + *)
> > > > +
> > > > +{}
> > > > +
> > > > +P0(int *seq, int *ctr)
> > > > +{
> > > > + int r2;
> > > > +
> > > > + WRITE_ONCE(*seq, 1);
> > > > + smp_mb();
> > > > + r2 =3D READ_ONCE(*ctr);
> > > > +}
> > > > +
> > > > +P1(int *ctr)
> > > > +{
> > > > + WRITE_ONCE(*ctr, 1);
> > > > + smp_mb();
> > > > +}
> > > > +
> > > > +P2(int *seq, int *ctr)
> > > > +{
> > > > + int r3;
> > > > + int r4;
> > > > +
> > > > + r3 =3D READ_ONCE(*ctr);
> > > > + smp_mb();
> > > > + r4 =3D READ_ONCE(*seq);
> > > > +}
> > > > +
> > > > +exists (0:r2 =3D 0 /\ 2:r3 =3D 1 /\ 2:r4 =3D 0)
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
> > Sent using hkml (https://github.com/sjp38/hackermail)
