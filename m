Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B43B7742
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120199; cv=pass; b=W9lVRnnKvgMP7+fXyOl77bOeD+d2V9xKWRC2MP4O2i6UAv6DCLSifrqUZudRqjxPW5+nbo+BXppGQliseQHFHglK9hcyPCfAYx77WQTPKAGXX/D6oGPCGFKnO49Pa6mKz0wckTHs8GWt+5KzmJSOJGHE2MLMvWm4gswkdSkNesI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120199; c=relaxed/simple;
	bh=w5BCY+Altqrl2z+KInkTE2HJzyoRga3lLbsK4NkbGZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAFUo8zrgo0bLxoHSE4bcp9BvI+0JEhcoxMy50KpTRXIXzFKxnTo3LAuba2kWyj+O8WxnzGGlYHDHCHE5gIrz50zJRlCPPZs8g4aLrDRL+brtdcDt0LA3gkP9pomb4kOHbuno7MAUUTj6sCW5HR4X1TUhWNYWNvWuOcs9/JoRDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e22eWa9u; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e22eWa9u"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso5308895e9.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 02:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789120195; cv=none;
        d=google.com; s=arc-20260327;
        b=IlKSXJ+HKHWyyKCO0r06XigeLWKqOY5U2ZcFrWjItEWodTWYqXkRORnXcWBTcywMtM
         mv2k6+VgPthk26PLKr4zexIMhTP8R0iPlD9yo7R4EbbmProeJ40qRUNKe+xqvdCq7+G1
         Vcvlli3pqbr/gd3ZzOPGDRupKyXMJXGT2WLc2W7eVGCTPlNiw4bsU8Fx6kFD5II4YJf9
         3vKDmWnop5E0NAVCxvcoUZ3kTSwtlzz86XIPezSODZ1kbMUIPjSrKMdnpJEwOFcDnknw
         Al/u8DweovT1Su26xhXWMzaQ0qIfkpXBlpG45au4Waev6WeXyYsCwKuy4N5KMA6Z7vnq
         tdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XmO8P+ChMoFawAYjtFDVo7MOu50AybaSOeGB/ttRwB4=;
        fh=CCRV4uRZshLBeWX6/MAnQWEotujM4F838X3KzqkiyZQ=;
        b=ITDwPonPceL6jDRbN3XszrGFCJw0wbU6KcOR5vSHZH/HVC6xYw+b8G+vEX32nvG9+a
         qG/hH8K+BunKN36rxoXsQL6QaALl/fXWtgIf0D4GCKNg9Y6rMeWf9RnzF40jEO0k7o2A
         DtkGrMPgXx7rTtG7EXIfH/SjLY7GKtF3AUYu0EX6wS5g6s51m+oYGKsvejIcpWMtOCvC
         fR927k4mZAlD/jCYg7hMLeD0GYacIC1ejMaIvovKVg5Rci8kOIlgpbXxD6DjCmkZLSyN
         eDwibQq/dhKSBRRMLl4cioC1R52FNKr/tz4lrV7YAvHUEzlOXlEnnVYKrOSmc3gKfLmp
         hN0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789120195; x=1789724995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XmO8P+ChMoFawAYjtFDVo7MOu50AybaSOeGB/ttRwB4=;
        b=e22eWa9uGH97TD4ApTY8m6YFBTAuAXV38SC4Rr2Ckj+sfPMLr67MRyoG4qrk0CtcxT
         MzvtPe0RaNt9TcUK2RHkYuJaA4Q2GDOW3aDSi1Kh/Wh3wCe+it5kXoNbi/X6dXmGx5kN
         OY4H+UpTdMhF+hE0bGbjiIDIritAsqJjnFjqu7mS38k73v/IIBA2feauMjJFlGxk6ivk
         9jKVBthF1AquQjJdpqdocrRPPQC+F+pBjlFKaMoly9WMht8BjEueFFYtqSO3/2X1mXRA
         ulaOYSCHHwyevG0z25m8ZXeVHPY1/dYccXhd/Yov9rrxHGoaON9YScAo7jCftyl5DZJS
         PTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120195; x=1789724995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XmO8P+ChMoFawAYjtFDVo7MOu50AybaSOeGB/ttRwB4=;
        b=FdxGGl0/8b2Qvk0bWN2J+bJQ1gjtL+O1fQpWLp3Nusbl90OZY8hhcTSK8bJmxTv2iv
         dyGNUeTpiOVLm9n0vX46sTUWkKNPAl+Jyhdc6iCoibHq8q10SNJQ08m1blzHoicoXity
         pWqm0+fePt22LPKRhgfWdP4M/U7QRXXW+HmlWG+939T4GsUo6TAovErFMnuhu3oTRMlL
         GUNsziS8Xy95PSD9nm87bd3t9raM5yte/eUSYgC/2kGhz+XTQHGE7G6m3eRs3HNI58uh
         f2DB7M1dFYX1pgK/nQbLO3d9DOOw4Bf419Bawp2lsCLvbUD3rr9fyQyNKXLUBqOkjKh0
         cokA==
X-Forwarded-Encrypted: i=1; AKwUvBzsCGN+juQ3WniHU7e0NYPGD3nVuA/7wSddmuMjjDYammdyGYP1b98K7GNr300dXf74j20=@vger.kernel.org
X-Gm-Message-State: AFuF++mdTcNpLTg2lf4TC9nxBk0bI0dd42j94oFOvx7vft65dmH1kGSb
	LjPWAU8MqcJcigO/ZSFtGXttdY5QAmr0xJZo5wQW5LpDpQGj+QtnbLRJgeWR2XDovVVwegW/ttG
	/yFX4dqNXKsDhYxL4yfi2U3JQEVEk+tU=
X-Gm-Gg: AYBFou1A1MVPN9PHnaXAWZTUS/MY4ZdlI/S5QpKj6yWYuBylvAuWY3IICKrIVwQ1Cc7
	RorGoPXr6SUJ1QqCHmVFvK+I4CLXOQeNhFF7io+EodMOlfm0KErTbEp2Ad3LJb2KRWqTIy5O7IQ
	vLk9I6Zv8scfTuDx+lJgC1sBlntpKFnLxoVwTk+o6/R75kRqq1k+s+RuF39Tl9zikdCJNq5rF75
	Ctdw2tQ3EcYolDcyYZLIIvYoSO1RLKNPWCYkjWNhFaS4q+wcfSF7vkXEpif0Kb9/Q4nNpAKwlUa
	TYPSUE07HoOksVGKkUTnV4w1qvEHW2SNxRUOJBuOcoTZ9SaZtc8W/jhtWdM4wYYnbWN9oPrUrOR
	zsnBIu9HxS8b7DA==
X-Received: by 2002:a05:600c:a107:b0:49e:663c:c69f with SMTP id
 5b1f17b1804b1-49e663cc929mr20825795e9.15.1789120194398; Fri, 11 Sep 2026
 02:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075829.2073224-1-kunwu.chan@linux.dev> <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
In-Reply-To: <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 11 Sep 2026 17:49:43 +0800
X-Gm-Features: AcwNN1UxmSgtIai_95aeqnZoEeATzU6VAkoqwwuqt7M2NT-d2JkrVJBjQKj2o60
Message-ID: <CAN_Opa-cvXVJeMxniuarq+2mE9EepjzTCgii1bW6mmSnaCKKxQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] srcu: Round out atomic SRCU support
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, 
	josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 8:16=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > This series rounds out atomic SRCU support with a reader-free fastpath,
> > some atomic-context fixes, and additional test coverage.
> >
> > The core change is a reader-free fastpath for synchronize_srcu_atomic()=
.
> > Atomic SRCU's read-side critical sections disable preemption, so when
> > the summed lock and unlock counts match for both ranks,
> > synchronize_srcu_atomic() can end the grace period immediately, without
> > the index flip or the srcu_advance_state() scans. Correctness depends
> > on the grace-period anchor written by srcu_gp_start() preceding the
> > lock-count scan; two LKMM litmus tests (patches 1-2) verify that
> > ordering.
>
> For synchronize_srcu_atomic(), the following items maybe also
> need to be added:

Hi Zqiang
Sent as: https://lore.kernel.org/rcu/20260911093515.2802551-1-kunwu.chan@gm=
ail.com/

Did a small late_initcall that enters an atomic read-side critical section =
and
calls synchronize_srcu_atomic().  srcu_lock_sync() catches it:
      WARNING: possible recursive locking detected
      swapper/0/1 is trying to acquire lock: (&ss) at:
synchronize_srcu_atomic+0x28/0x380
      but task is already holding lock:     (&ss) at:
srcu_lockdep_test_init+0xd0/0x170
      *** DEADLOCK ***
Rcutorture SRCU-N/P also pass.

Thanks, Kunwu

>
>         srcu_lock_sync(&ssp->dep_map);
>
>         RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
>                          "Illegal synchronize_srcu() in same-type SRCU re=
ad-side critical section");
>
>         if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>                 return;
>
> Thanks
> Zqiang
>
>
>
> >
> > The series is:
> >
> >  1-2 LKMM litmus tests for the reader-free fastpath ordering.
> >  3 srcutree: add the reader-free fastpath.
> >  4 rcutorture: add --do-atomic-srcu to torture.sh.
> >  5-7 srcutree: honor and propagate is_atomic so atomic SRCU never
> >  transitions to big.
> >  8 srcutree: forbid srcu_expedite_current() on atomic SRCU.
> >  9 rcutorture: disable srcu_expedite_current() for atomic SRCU.
> >  10 srcutree: skip callback scheduling for atomic SRCU grace periods.
> >  11 srcutree: drop the srcu_barrier() sleep for atomic SRCU.
> >  12 srcutree: remove leftover debug pr_alert()s.
> >  13 srcu: restrict the non_block annotation to task context, fixing a
> >  KCSAN data race.
> >
> > The KCSAN race in patch 13 is a data race on the interrupted task's
> > ->non_block_count when a timer callback runs atomic-SRCU readers in
> > inline softirq context.
> >
> > Tested with herd7 7.58 (litmus tests), torture.sh --do-atomic-srcu, and
> > torture.sh --do-atomic-srcu --do-kcsan (KCSAN+PROVE_LOCKING).
> >
> > Kunwu Chan (13):
> >  litmus: Add SRCU fastpath anchor-before-scan test
> >  litmus: Add SRCU fastpath scan-before-anchor test
> >  srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
> >  rcutorture: Add atomic-SRCU support to torture.sh
> >  srcutree: Honor is_atomic in check_init_srcu_struct()
> >  srcutree: Make init_srcu_struct_atomic() prevent transition to big
> >  srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
> >  srcutree: Forbid srcu_expedite_current() on atomic SRCU
> >  rcutorture: Disable srcu_expedite_current() for atomic SRCU
> >  srcutree: Skip callback scheduling for atomic SRCU grace periods
> >  srcutree: Remove srcu_barrier() sleep for atomic SRCU
> >  srcutree: Remove debug pr_alert()s
> >  srcu: Restrict atomic-SRCU non_block annotation to task context
> >
> >  include/linux/srcu.h | 10 +-
> >  kernel/rcu/rcutorture.c | 1 +
> >  kernel/rcu/srcutree.c | 95 ++++++++++++++-----
> >  tools/memory-model/litmus-tests/README | 16 ++++
> >  .../SRCU-fastpath-anchor-before-scan.litmus | 56 +++++++++++
> >  .../SRCU-fastpath-scan-before-anchor.litmus | 53 +++++++++++
> >  .../selftests/rcutorture/bin/torture.sh | 24 +++++
> >  7 files changed, 229 insertions(+), 26 deletions(-)
> >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-ancho=
r-before-scan.litmus
> >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-scan-=
before-anchor.litmus
> >
> > base-commit: ef15070f96c5f07de3a9b593c36f6e83bc9e3d58
> > --
> > 2.43.0
> >
