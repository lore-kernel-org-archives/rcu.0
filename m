Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C423B14C4
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014683; cv=pass; b=uel4VPXoKdp02dPv+wvHmmuiBMJbluAn0pzbPSb2hBZFd1cx3qZwssBSxZ/7j9zWd9rrTIg4NUp8ZxY26pFSmXu5E9glpTyCbhjcHwHtV6yhxPKjRfT8gJM4tildW2rqTfeMmzj9Mprs1jLBFKOlsY0tCUW7gH7c5sw2a4WBspo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014683; c=relaxed/simple;
	bh=nGWKaqyr24Wy2YZw8DdG/uOhViINSSIsWNtLN5gDkYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6NEAlrhUDEBML3prWKSrHWVs0Jtb0DKjKpbpO8Y0thbZ9cqZdEP/FZyC0AInYV0l9yryYDRmDPNuJON5X/B0SXw2jClklJGgcesJT6ecLwq54dc/+OSYwAWKVBLl1bln8eFH83zqJPjuZphjwvs27F9S9QPiFqZVQrjbnMZh+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3SODCeV; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3SODCeV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso56122255e9.3
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2026 21:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789014680; cv=none;
        d=google.com; s=arc-20260327;
        b=IeFXkhczBtnfsZVBqHu9IVXj7dDaBUQ2WeDdyNkkjNw80KDyr+PNOp+Kg87ThFn760
         AJQR7/8d3avY9Li91qiZ6W3mPov1DNm4hRlg33yV5fO8qoUQPmEGRFsQKug9OMO9bwVe
         ont4YEXipIyOFj2FmsipST8KGWwZYwv7RcDwkSmeOVLbYWYPNr8VADq36ZO40Zev01ss
         9lvZXBq+MI0XUUUyrcf6YXFzTcsS+rLyebGtYSLn/MVYSNcIiwbPhvVmCbEvNKnp/2ah
         JHpbgQHMTb+zQ7hlblmzitbSgdt3bSvm6Fmv+LBNIohyoQqKbLwr1d6VD2S/N2FTd3sv
         KViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogeS1d1lUjwpzULBQnx1xn71a+aSrJ9QM6Mrgrln7po=;
        fh=/Dbx0vPnooMmy9MkPu782pTZUVG4rmSxblTFZmV91/k=;
        b=rdlByBbxDSAxZtpgvAJncJiUz4wKxGqSirIl51cwaAP+fOLWYyiDHNtTUVGEexdpEJ
         me1Bg2HHDk0uxCY9VZwOeKwMysIPKcURVL7Ah2WqwTgMVmOVfwTywLPqGuSWddAhvx9I
         wL9kJuyQ2hVrfpfGEleLXX0R7cekucxSXUAEFW1yGZM8IjNaDuuFB8YFSuQrU5QavtAZ
         sPWrlf96lMq5zqzIftbJ95WVxvcL5z5umJRhlnxHTXtkfqgx1+BzUFoHXwro9hMEUHvN
         rOHitveVUNLUbAovan3Vpoyma6QaoOTjYjnTcUE00Co+qGEj7Nj97Obm3SXlwHPpSSc8
         8lxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789014680; x=1789619480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ogeS1d1lUjwpzULBQnx1xn71a+aSrJ9QM6Mrgrln7po=;
        b=l3SODCeVhF2OXWYpnGgog9bWquVvBQh3oK8QsdseMroxMuwi/lExmnvfAHKqj74Fqt
         mAuNcwnhS5on3gjlHRDr0H4R9MUh29ieJ/YbqCR1ay6MSWJnRCzLMkMioMOtCO9DVzFQ
         OK9fsdMZCKT+RocQApMDrnqWR7b5or5wA+yQBWygD6MgcLno8sHXjhN9uQMiJPLk3Hkl
         /LHK5F3F/vfI/jJEYmTSYQYzLoo5FUWLqbBcUeNjOlX9va/erg51o1Fzdj3WDDY8ylTm
         JrPwEfXFo6U4owmLnEQTzkdwoxSD8qJmvPk+9t2HKDS2pVNOhKFvSJkCXg1/4TuYnTVc
         Uu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789014680; x=1789619480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogeS1d1lUjwpzULBQnx1xn71a+aSrJ9QM6Mrgrln7po=;
        b=XAjUvF8H+J+9iDyl7joIyQaFfmp21XnYYe+XYqMeFDZOdoWBJ8/1N7cUuB7Ffd/mOk
         qlUflJjA3+9ohiPCLRwv7Pxawowo8IG9CwL0HlbMvNEXWJGUK/ZND7ZfUH1R0acQ5bqT
         xMHqCPr0KtTXiGpWLECS6zLZzzGJQhniHbqDnwvPYQsL/0Xmo7LRXsSU1nV00h2O3RpF
         3E0TYU6vty8odtKorqlNVFRb8TN8els8Xw40kQ5PlRxBpEzCWqz6XK1dV9C1SoJfR/sI
         TKJgmsUR/uywcaDIeA/CqYgJehRiFLxKfrBE83gcFkGdyQyWu68hM3iUGNUy1WfpPTOs
         tpYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAqd3wykQLhqr5j0+oU+cTwGbtAEkF2nBxPtvTByy76RE9Fx/kh5QVvjcH0AUFp1XSaTE=@vger.kernel.org
X-Gm-Message-State: AFuF++m6dFPh4mSoSV9XcIgDVW8dgsad5Y45u7WNaxADAeFA2styMtF7
	gUZ8oV9yjcyuH+n+bk5pocp5FivpLn8uTQ7voKTuayiUYuBode2SqsQhjicm1AuOoqC73/4YvHr
	isu0peRUd/O9iYOTjwA1684F8ceUA7sY=
X-Gm-Gg: AYBFou3OncalF+NDJyXZda+GZuQAVVhSeko7GdL4e9Coui+Em5q8rNiJVKFZY5AtjNd
	zE0gezkhbyyLdWYP7Z1pGF0TxkQ3hkFsMeamj+d2vic1FnINgCwyc0LpkPwL+gzRqVw9Soo2vpa
	Rx9+RPpr5zmbmizgM8i5euY15SiwFVEKJ1c/yPVyBVdWubcrd8/wcjJLBRjGIYHrWbvBPO5NcPk
	w7wdxRbRRnan6DXo/jquQTVZxYoDy8pPh0uYRqHXMIMidRFkQqlbgGuTpX4/HJjq/FOCKWTHfyB
	E/tMaoxhGMDeDGwlKRHI9na07lTUTohBHtxAsBc6gTqyAT3eF4yugejTfvNUkbNgmke+01fUR4S
	zo2/AGol33fYxiw==
X-Received: by 2002:a05:600c:3495:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-49cf8279f41mr341820965e9.14.1789014678976; Wed, 09 Sep 2026
 21:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-5-kunwu.chan@linux.dev> <fc49190e-6cec-435d-b853-db906a1e33e3@paulmck-laptop>
 <26b68ec0-2f21-4dc2-bfcf-20cbc38f4ceb@paulmck-laptop> <CAN_Opa-M=qs=ofqdQWikkVRh2mNzKMO5qrtOSn_jMyF+TkMKNQ@mail.gmail.com>
 <9b0ac5fa-98ef-4ff0-9f96-9194f1eda442@paulmck-laptop>
In-Reply-To: <9b0ac5fa-98ef-4ff0-9f96-9194f1eda442@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 10 Sep 2026 12:31:06 +0800
X-Gm-Features: AcwNN1U5qVrUjk9gb4KVFN6vmzZjDt3Kofz7nE6PKHWOW0MsHwSNHKCgtQc9pws
Message-ID: <CAN_Opa-gc=hUpiTSgKpSepzTaUNnHaWaw+CcH5WiBbzHTpf3UA@mail.gmail.com>
Subject: Re: [PATCH 04/13] rcutorture: Add atomic-SRCU support to torture.sh
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:47=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 09:30:48AM +0800, KunWu Chan wrote:
> > On Thu, Sep 10, 2026 at 6:35=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Tue, Sep 08, 2026 at 04:34:41PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Sep 07, 2026 at 03:58:20PM +0800, Kunwu Chan wrote:
> > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > >
> > > > > Add the --do-atomic-srcu argument to torture.sh, which runs the
> > > > > SRCU-N, SRCU-P, and SRCU-T scenarios, thus covering both Tree SRC=
U
> > > > > (SRCU-N and SRCU-P) and Tiny SRCU (SRCU-T), with
> > > > > rcutorture.reader_flavor=3D0x10 appended to the boot parameters s=
o
> > > > > that it takes precedence over each scenario's own reader-flavor
> > > > > setting.  This exercises srcu_read_lock_atomic(),
> > > > > srcu_read_unlock_atomic(), and synchronize_srcu_atomic().
> > > > >
> > > > > As with other torture.sh tests, the --do-kcsan argument runs a
> > > > > KCSAN+PROVE_LOCKING variant of this test.
> > > > >
> > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > > Queued for testing and review, thank you!
> > >
> > > I did take the liberty of changing "do_atomic_srcu=3Dno" to
> > > "do_atomic_srcu=3Dyes" in order to increase test coverage.
> > >
> >
> > Thanks, no problem.
> >
> > I also found a couple of data races in other subsystems while running
> > the tests. I=E2=80=99m still validating the fixes locally and will Cc y=
ou if I
> > send patches for them.
>
> Sounds good!  Note that some maintainers are more friendly to such
> patches than others.  But it shouldn't hurt to send them.  ;-)
>
> Just please carefully check the design.  For example, blindly applying
> READ_ONCE() and WRITE_ONCE() is not a strategy to win.
>

Thanks for the reminder, Paul. I=E2=80=99ll keep that in mind and make sure=
 to
check the design carefully.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > Thanks,
> > KunWu
> >
> > >                                                         Thanx, Paul
> > >
> > > > > ---
> > > > >  .../selftests/rcutorture/bin/torture.sh       | 24 +++++++++++++=
++++++
> > > > >  1 file changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/=
tools/testing/selftests/rcutorture/bin/torture.sh
> > > > > index f0083891ee81..8885812d866a 100755
> > > > > --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> > > > > +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> > > > > @@ -68,6 +68,7 @@ do_clocksourcewd=3D"${ifnotaarch64}"
> > > > >  do_rt=3Dyes
> > > > >  do_rcutasksflavors=3D"${ifnotaarch64}" # FIXME: Back to "yes" wh=
en SMP=3Dn auto-avoided
> > > > >  do_srcu_lockdep=3Dyes
> > > > > +do_atomic_srcu=3Dno
> > > > >  do_rcu_rust=3Dno
> > > > >
> > > > >  # doyesno - Helper function for yes/no arguments
> > > > > @@ -103,6 +104,7 @@ usage () {
> > > > >     echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust=
"
> > > > >     echo "       --do-scftorture / --do-no-scftorture / --no-scft=
orture"
> > > > >     echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-=
srcu-lockdep"
> > > > > +   echo "       --do-atomic-srcu / --do-no-atomic-srcu / --no-at=
omic-srcu"
> > > > >     echo "       --duration [ <minutes> | <hours>h | <days>d ]"
> > > > >     echo "       --guest-cpu-limit N"
> > > > >     echo "       --kcsan-kmake-arg kernel-make-arguments"
> > > > > @@ -148,6 +150,7 @@ do
> > > > >             do_kcsan=3Dyes
> > > > >             do_clocksourcewd=3D"${ifnotaarch64}"
> > > > >             do_srcu_lockdep=3Dyes
> > > > > +           do_atomic_srcu=3Dyes
> > > > >             ;;
> > > > >     --do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
> > > > >             do_allmodconfig=3D`doyesno "$1" --do-allmodconfig`
> > > > > @@ -183,6 +186,7 @@ do
> > > > >             do_kcsan=3Dno
> > > > >             do_clocksourcewd=3Dno
> > > > >             do_srcu_lockdep=3Dno
> > > > > +           do_atomic_srcu=3Dno
> > > > >             ;;
> > > > >     --do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal=
|--no-norm)
> > > > >             do_normal=3D`doyesno "$1" --do-normal`
> > > > > @@ -212,6 +216,9 @@ do
> > > > >     --do-srcu-lockdep|--do-no-srcu-lockdep|--no-srcu-lockdep)
> > > > >             do_srcu_lockdep=3D`doyesno "$1" --do-srcu-lockdep`
> > > > >             ;;
> > > > > +   --do-atomic-srcu|--do-no-atomic-srcu|--no-atomic-srcu)
> > > > > +           do_atomic_srcu=3D`doyesno "$1" --do-atomic-srcu`
> > > > > +           ;;
> > > > >     --duration)
> > > > >             checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*=
\(m\|h\|d\|\)$' '^error'
> > > > >             mult=3D1
> > > > > @@ -497,6 +504,23 @@ then
> > > > >     torture_set "rcutorture" tools/testing/selftests/rcutorture/b=
in/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_r=
cutorture" --trust-make
> > > > >  fi
> > > > >
> > > > > +# Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny=
 SRCU
> > > > > +# (SRCU-T).  The reader flavor selects srcu_read_lock_atomic() a=
nd
> > > > > +# synchronize_srcu_atomic().  Tiny SRCU requires SMP=3Dn, which =
aarch64
> > > > > +# does not support.
> > > > > +if test "$do_atomic_srcu" =3D "yes"
> > > > > +then
> > > > > +   torture_bootargs=3D"rcutorture.reader_flavor=3D0x10"
> > > > > +   configs_atomic_srcu=3D"SRCU-N SRCU-P"
> > > > > +   if test "$ifnotaarch64" =3D yes
> > > > > +   then
> > > > > +           configs_atomic_srcu=3D"$configs_atomic_srcu SRCU-T"
> > > > > +   fi
> > > > > +   torture_set "atomic-srcu" tools/testing/selftests/rcutorture/=
bin/kvm.sh \
> > > > > +           --allcpus --duration "$duration_rcutorture" \
> > > > > +           --configs "$configs_atomic_srcu" --trust-make
> > > > > +fi
> > > > > +
> > > > >  if test "$do_locktorture" =3D "yes"
> > > > >  then
> > > > >     torture_bootargs=3D"torture.disable_onoff_at_boot"
> > > > > --
> > > > > 2.43.0
> > > > >
