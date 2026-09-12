Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D347CC94
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219082; cv=pass; b=M3BGn9i3EJq58aPd3Oti2p5tBjrtMiSdf77eBWphEutGcHKV+OwtGnSrbN0it2GxacyziOpktbELzeT+zZmkPYirXYMW4SGwY8DDYM4caZBMlX01zl6pVttNKtr0Q+/moFWEVOMbmnxwUbnuqBF2gg4+AZJnJ3Q62qCbf0scoOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219082; c=relaxed/simple;
	bh=BsiF8+r5vgUuRparDjgrLB9w7U/qShYtdjOD3d2tROQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWI/1yacDYtBwb6M2GWJDyMixKHCA1Vbgn22IsGMFqh6M16xzd0tK9L0oBDefJljXII9xIvT4NUdnCp6eg2gztuC43By24qlaLIiG8Ahv1PcYzydUTms0nvhMcPDjPrm+IJBesVN26i75VnmO25mWWgW4cG5haNLo/t1pQeVmKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa93kqwP; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa93kqwP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso4519875e9.1
        for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 06:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789219078; cv=none;
        d=google.com; s=arc-20260327;
        b=O4nNJ4q4quRRncagaimicHriGbNf1SXOfqqmDq+H1Jiz2IEWdGsXMpkDGgy+rVpWkD
         fTGP53NUIpdm+IjP122KAgtov0b4B9+WtVHh3AVVCL/FjXCbon9ZYgsMEaqKjFpN2YUc
         tf6H0w3fJYMa0kpLHJKPUcpTlPkvPLsNRU2ipE8L+fnmHHSGHtxh7CV5pbOqWpSKP2zN
         dIgEyS5acZAIcQ2A7I+gXIDzFN0sqTda+ZIunBzxzlgFXNn5+m/tt6W4DzSYZQ3Kf86t
         G/XFqW/WyL7FTKGBA/NnubMHXgJ83f5aoUVgYkjGKDsrtf1obAKOA1XbDJNnKgifqrKh
         YQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPi8mMYl+gIyOrC3hZ2sXqCE+u6Vau0Qj07zs3k7gBA=;
        fh=B2s8JMrI+ab9b+Yuy8afjOioMB2BFde1sv488ewx2C0=;
        b=o5TLvl8qsCTdtENWlsQNbAnaTB4giV1cY/OkaZ8GQAR9n1cQuD73SVWFk97hi/Kvlg
         VIqQtTOuqjqr4LOuHWjuiFkhnZ1LU2Q1TWuCa81cOLZfBpDquCgBRFgcfd40X09XILhq
         ixXXeqWiltq+DcETsoCVNE17zVu3+AGx/bn8pkp32y3SNNd42USrs//LoGp4ofXydYBR
         GDcCyeiryopv/pOxZq/4+WRbdTR1wIEewsxfrzX1XQ1+Inm3m84nXxiuiLR32hdqrZkh
         +oduIvn7D8svadgE/94Z/ZbsNWDhJR/p/ugyK7wh3WVkYzASybJksOaKKwOhqXpDG20D
         Km1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219078; x=1789823878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPi8mMYl+gIyOrC3hZ2sXqCE+u6Vau0Qj07zs3k7gBA=;
        b=Pa93kqwPH/SeNFjsdCZVBPfFpttIy3qoCOSQS4W2ZvJJvB+3DIOxuYM8ZjkscBohkj
         mROx2kk1SCZfxZ9K5T1LzkevowV8Tc7JpvYO7yLCT7fsya2tDRRCCCIhjrbdQNV0o3Vc
         wjLQ6+y1V8qrCxzgcg7YX6g5tgc3qtxoBoIk82jyU1za6wLQ3qxA528iwf7AMOmKJ0qy
         nAbwwXoqayiMtCsL2vKk+TZrp9xMvh/SZv0ZJvFFGNeZYucsq20DPsMT+cJnnRlXyyW7
         0Oh6I//FZAMOXskxT6t4IYFdUp+ZZkpSGwUnTUVSdPLgyB2cofbDqkmwl5x1xLlxr3Q3
         88FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219078; x=1789823878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPi8mMYl+gIyOrC3hZ2sXqCE+u6Vau0Qj07zs3k7gBA=;
        b=re4D8/OEA5380PbTGcOsPA00o06BLgbTHh1gylmXVCof1pGtcm34ACmlQ5LTUEDtR3
         DqYQFzEsF5xqrQpw6ZOP+QDHPrFzcAdXgaxQV7OXYwa/s0WeW7Zr4kSCzU4x/hKGSbuv
         0uwyVuFzXlW4Xjol2fq3EeM40rgM8vlGtB7OsLhG9KeB+nj7ug1UHM+TWapaGZIIXC3E
         M8px5yMjKaKMNMRJ+usYBEl12BRAENqQxFIwl+VxfTKQsjnuIyPWJ2Dela1g7qie7rpB
         v8SAhImHVdhaHvMKTjl/EwWtZI3JsAq5/LSfBk/M/AbTv8RDo3aaQBrbmmT2DP4oLcaO
         xEgw==
X-Forwarded-Encrypted: i=1; AKwUvByY1ZrC0+t0br8Dadtujyl1MJY70JRHhPchRMQTE6pJdZYF/8lt4mLyelWjmecfSd3M1WE=@vger.kernel.org
X-Gm-Message-State: AFuF++nv7seZwjZ7Vdgmst18wry5gBmscKtCJEmb836YVeSdmba3xTZg
	PAWVywqsi31M0m448c4sRmKUuR8/liGrTU5iXhYv5jRTB9JdMlVVVEpsmg0dSwtqOUsOEF3UAV4
	+wzB43lZTroC0b+YaQrJKoDvo/8tKrzQ=
X-Gm-Gg: AYBFou01LKylNWleA0P1Jj/KlxpGLYY/MJCFobE1/HP5szg2tAOR27VMjV0U/EmoXG1
	BpaSz7q1e55o1QJERXfzkLhtezjNfQWy7lZVseBMEXZEsa9W2IrdzAxVuB+IlagdKCpy4AhGPH5
	U5e63bHWIeF/m7a49/JoasraKb04tGg6rF54N5iHZRqVm6CDVLEDmcp9iS9O1M01mGw4tcBfjl4
	UynTag5EfZPZpgaro5jinKx0963zu9kqZvLKU1dZuX45xtVeZv0f5G04UrgX4oxTJ7824Cd6LX8
	8ozK/KXKrUxRWk/REMRJ5kwq0KQCKy9fzJP1UnOpn5QhGhDEA7IxGYcxOlS0JEH4aCzwOlEGK7z
	ydRRsLrfz6zM=
X-Received: by 2002:a05:600c:6216:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49e6ca350camr24650915e9.0.1789219077551; Sat, 12 Sep 2026
 06:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev> <CAN_Opa-cvXVJeMxniuarq+2mE9EepjzTCgii1bW6mmSnaCKKxQ@mail.gmail.com>
 <4298908f242e82d54e0f462307ee18fa777b0935@linux.dev>
In-Reply-To: <4298908f242e82d54e0f462307ee18fa777b0935@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 12 Sep 2026 21:17:45 +0800
X-Gm-Features: AcwNN1WZzQfgiUds4j9elCw2mdpkAUcvPuBlha1DBx4yXy8ULrk4CMRYin5AjcY
Message-ID: <CAN_Opa_AVXF=+0FbTccTQU_vrQ798Y0HBynmH8qpKickDnS55Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] srcu: Round out atomic SRCU support
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, 
	josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 8:41=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > On Thu, Sep 10, 2026 at 8:16 PM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > >  This series rounds out atomic SRCU support with a reader-free fastpa=
th,
> > >  some atomic-context fixes, and additional test coverage.
> > >
> > >  The core change is a reader-free fastpath for synchronize_srcu_atomi=
c().
> > >  Atomic SRCU's read-side critical sections disable preemption, so whe=
n
> > >  the summed lock and unlock counts match for both ranks,
> > >  synchronize_srcu_atomic() can end the grace period immediately, with=
out
> > >  the index flip or the srcu_advance_state() scans. Correctness depend=
s
> > >  on the grace-period anchor written by srcu_gp_start() preceding the
> > >  lock-count scan; two LKMM litmus tests (patches 1-2) verify that
> > >  ordering.
> > >
> > >  For synchronize_srcu_atomic(), the following items maybe also
> > >  need to be added:
> > >
> > Hi Zqiang
> > Sent as: https://lore.kernel.org/rcu/20260911093515.2802551-1-kunwu.cha=
n@gmail.com/
> >
> > Did a small late_initcall that enters an atomic read-side critical sect=
ion and
> > calls synchronize_srcu_atomic(). srcu_lock_sync() catches it:
> >  WARNING: possible recursive locking detected
> >  swapper/0/1 is trying to acquire lock: (&ss) at:
> > synchronize_srcu_atomic+0x28/0x380
> >  but task is already holding lock: (&ss) at:
> > srcu_lockdep_test_init+0xd0/0x170
> >  *** DEADLOCK ***
> > Rcutorture SRCU-N/P also pass.
>
> Hi, kunwu
>
> You can add srcu_atomic lockdep test to rcutorture to verify
> your change, and I also saw that Paul suggested the same thing :)
>

Hi Zqiang,
Thanks for the suggestion. This is very helpful.

I saw Paul's suggestion too. I'll use your example as a starting
point, verify the atomic SRCU lockdep cases, and check the
--do-srcu-lockdep handling in torture.sh, including the normal RCU
read-side case Paul mentioned.

I'll add a Suggested-by tag for your contribution when I post the
changes.

Thanks,
Kunwu

> For example, as shown below (I am not test or verify it):
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d795e07a12ad..d4f7399acbd5 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -4662,6 +4662,17 @@ static DECLARE_RWSEM(rwsem7);
>  static DECLARE_RWSEM(rwsem8);
>  static DECLARE_RWSEM(rwsem9);
>
> +static DEFINE_RAW_SPINLOCK(spin0);
> +static DEFINE_RAW_SPINLOCK(spin1);
> +static DEFINE_RAW_SPINLOCK(spin2);
> +static DEFINE_RAW_SPINLOCK(spin3);
> +static DEFINE_RAW_SPINLOCK(spin4);
> +static DEFINE_RAW_SPINLOCK(spin5);
> +static DEFINE_RAW_SPINLOCK(spin6);
> +static DEFINE_RAW_SPINLOCK(spin7);
> +static DEFINE_RAW_SPINLOCK(spin8);
> +static DEFINE_RAW_SPINLOCK(spin9);
> +
>  DEFINE_STATIC_SRCU(srcu0);
>  DEFINE_STATIC_SRCU(srcu1);
>  DEFINE_STATIC_SRCU(srcu2);
> @@ -4673,6 +4684,17 @@ DEFINE_STATIC_SRCU(srcu7);
>  DEFINE_STATIC_SRCU(srcu8);
>  DEFINE_STATIC_SRCU(srcu9);
>
> +DEFINE_STATIC_SRCU_ATOMIC(srcu0_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu1_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu2_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu3_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu4_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu5_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu6_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu7_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu8_atomic);
> +DEFINE_STATIC_SRCU_ATOMIC(srcu9_atomic);
> +
>  static int srcu_lockdep_next(const char *f, const char *fl, const char *=
fs, const char *fu, int i,
>                              int cyclelen, int deadlock)
>  {
> @@ -4702,6 +4724,13 @@ static void rcu_torture_init_srcu_lockdep(void)
>                                           &rwsem5, &rwsem6, &rwsem7, &rws=
em8, &rwsem9 };
>         struct srcu_struct *srcus[] =3D { &srcu0, &srcu1, &srcu2, &srcu3,=
 &srcu4,
>                                         &srcu5, &srcu6, &srcu7, &srcu8, &=
srcu9 };
> +
> +       raw_spinlock_t *spins[] =3D { &spin0, &spin1, &spin2, &spin3, &sp=
in4, &spin5,
> +                                       &spin6, &spin7, &spin8, &spin9};
> +       struct srcu_struct *srcus_atomic[] =3D {&srcu0_atomic, &srcu1_ato=
mic, &srcu2_atomic,
> +                                               &srcu3_atomic, &srcu4_ato=
mic, &srcu5_atomic,
> +                                               &srcu6_atomic, &srcu7_ato=
mic, &srcu8_atomic,
> +                                               &srcu9_atomic};
>         int testtype;
>
>         if (!test_srcu_lockdep)
> @@ -4812,11 +4841,48 @@ static void rcu_torture_init_srcu_lockdep(void)
>         }
>  #endif // #ifdef CONFIG_TASKS_TRACE_RCU
>
> +        if (testtype =3D=3D 4) {
> +                pr_info("%s: test_srcu_lockdep =3D %05d: SRCU_ATOMIC %d-=
way %sdeadlock.\n",
> +                        __func__, test_srcu_lockdep, cyclelen, deadlock =
? "" : "non-");
> +                if (deadlock && cyclelen =3D=3D 1)
> +                        pr_info("%s: Expect hang.\n", __func__);
> +                for (i =3D 0; i < cyclelen; i++) {
> +                        j =3D srcu_lockdep_next(__func__, "srcu_read_loc=
k_atomic", "synchronize_srcu_atomic",
> +                                              "srcu_read_unlock_atomic",=
 i, cyclelen, deadlock);
> +                        idx =3D srcu_read_lock_atomic(srcus_atomic[i]);
> +                        if (j >=3D 0)
> +                                synchronize_srcu_atomic(srcus_atomic[j])=
;
> +                        srcu_read_unlock_atomic(srcus_atomic[i], idx);
> +                }
> +                return;
> +        }
> +
> +        if (testtype =3D=3D 1) {
> +                pr_info("%s: test_srcu_lockdep =3D %05d: SRCU_ATOMIC/raw=
_spinlock %d-way %sdeadlock.\n",
> +                        __func__, test_srcu_lockdep, cyclelen, deadlock =
? "" : "non-");
> +                for (i =3D 0; i < cyclelen; i++) {
> +                        pr_info("%s: srcu_read_lock_atomic(%d), raw_spin=
_lock(%d), raw_spin_unlock(%d), srcu_read_unlock_atomic(%d)\n",
> +                                __func__, i, i, i, i);
> +                        idx =3D srcu_read_lock_atomic(srcus_atomic[i]);
> +                        raw_spin_lock(spins[i]);
> +                        raw_spin_unlock(spins[i]);
> +                        srcu_read_unlock_atomic(srcus_atomic[i], idx);
> +
> +                        j =3D srcu_lockdep_next(__func__, "raw_spin_lock=
", "synchronize_srcu_atomic",
> +                                              "raw_spin_unlock", i, cycl=
elen, deadlock);
> +                        raw_spin_lock(spins[i]);
> +                        if (j >=3D 0)
> +                                synchronize_srcu_atomic(srcus_atomic[j])=
;
> +                        raw_spin_unlock(spins[i]);
> +                }
> +                return;
> +        }
> +
>  err_out:
>         pr_info("%s: test_srcu_lockdep =3D %05d does nothing.\n", __func_=
_, test_srcu_lockdep);
>         pr_info("%s: test_srcu_lockdep =3D DNNL.\n", __func__);
>         pr_info("%s: D: Deadlock if nonzero.\n", __func__);
> -       pr_info("%s: NN: Test number, 0=3DSRCU, 1=3DSRCU/mutex, 2=3DSRCU/=
rwsem, 3=3DSRCU/Tasks Trace RCU.\n", __func__);
> +       pr_info("%s: NN: Test number, 0=3DSRCU, 1=3DSRCU/mutex, 2=3DSRCU/=
rwsem, 3=3DSRCU/Tasks Trace RCU, 4=3DSRCU_ATOMIC, 5=3DSRCU_ATOMIC/raw_spinl=
ock.\n", __func__);
>         pr_info("%s: L: Cycle length.\n", __func__);
>         if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU))
>                 pr_info("%s: NN=3D3 disallowed because kernel is built wi=
th CONFIG_TASKS_TRACE_RCU=3Dn\n", __func__);
>
>
> Thanks
> Zqiang
>
>
>
>
>
> >
> > Thanks, Kunwu
> >
> > >
> > > srcu_lock_sync(&ssp->dep_map);
> > >
> > >  RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > >  "Illegal synchronize_srcu() in same-type SRCU read-side critical sec=
tion");
> > >
> > >  if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> > >  return;
> > >
> > >  Thanks
> > >  Zqiang
> > >
> > >  The series is:
> > >
> > >  1-2 LKMM litmus tests for the reader-free fastpath ordering.
> > >  3 srcutree: add the reader-free fastpath.
> > >  4 rcutorture: add --do-atomic-srcu to torture.sh.
> > >  5-7 srcutree: honor and propagate is_atomic so atomic SRCU never
> > >  transitions to big.
> > >  8 srcutree: forbid srcu_expedite_current() on atomic SRCU.
> > >  9 rcutorture: disable srcu_expedite_current() for atomic SRCU.
> > >  10 srcutree: skip callback scheduling for atomic SRCU grace periods.
> > >  11 srcutree: drop the srcu_barrier() sleep for atomic SRCU.
> > >  12 srcutree: remove leftover debug pr_alert()s.
> > >  13 srcu: restrict the non_block annotation to task context, fixing a
> > >  KCSAN data race.
> > >
> > >  The KCSAN race in patch 13 is a data race on the interrupted task's
> > >  ->non_block_count when a timer callback runs atomic-SRCU readers in
> > >  inline softirq context.
> > >
> > >  Tested with herd7 7.58 (litmus tests), torture.sh --do-atomic-srcu, =
and
> > >  torture.sh --do-atomic-srcu --do-kcsan (KCSAN+PROVE_LOCKING).
> > >
> > >  Kunwu Chan (13):
> > >  litmus: Add SRCU fastpath anchor-before-scan test
> > >  litmus: Add SRCU fastpath scan-before-anchor test
> > >  srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
> > >  rcutorture: Add atomic-SRCU support to torture.sh
> > >  srcutree: Honor is_atomic in check_init_srcu_struct()
> > >  srcutree: Make init_srcu_struct_atomic() prevent transition to big
> > >  srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
> > >  srcutree: Forbid srcu_expedite_current() on atomic SRCU
> > >  rcutorture: Disable srcu_expedite_current() for atomic SRCU
> > >  srcutree: Skip callback scheduling for atomic SRCU grace periods
> > >  srcutree: Remove srcu_barrier() sleep for atomic SRCU
> > >  srcutree: Remove debug pr_alert()s
> > >  srcu: Restrict atomic-SRCU non_block annotation to task context
> > >
> > >  include/linux/srcu.h | 10 +-
> > >  kernel/rcu/rcutorture.c | 1 +
> > >  kernel/rcu/srcutree.c | 95 ++++++++++++++-----
> > >  tools/memory-model/litmus-tests/README | 16 ++++
> > >  .../SRCU-fastpath-anchor-before-scan.litmus | 56 +++++++++++
> > >  .../SRCU-fastpath-scan-before-anchor.litmus | 53 +++++++++++
> > >  .../selftests/rcutorture/bin/torture.sh | 24 +++++
> > >  7 files changed, 229 insertions(+), 26 deletions(-)
> > >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anc=
hor-before-scan.litmus
> > >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-sca=
n-before-anchor.litmus
> > >
> > >  base-commit: ef15070f96c5f07de3a9b593c36f6e83bc9e3d58
> > >  --
> > >  2.43.0
> > >
> >
