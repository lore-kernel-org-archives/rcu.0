Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373743E411B
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093910; cv=pass; b=fRGDbQWbY841rpwMozD69tVD3uvv6cRTgBu+G6D7yqkIv7nCn/71milSuGQrBfZwknwcuzRAwzJWSFwJMRQOkxLuQSsNBu3N0jFap2sSAkDDsC4VdIF+CLxP6eRxl50xTn5Y+2OoAEsfW+Z4MHptop7WpYiCeiM1YuVPjs+i2cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093910; c=relaxed/simple;
	bh=Fv/alucK4B1I3/mTojghRn92nB3M29nhaTjKPeekFFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADejR4/CpRsVJgeQlwnvK6VywWcbMVFji+hazk58hfQcQxcFheiI39qG+VxFLbc0tAZVc2EEmQP8lDV/TuC3Ir2pkMuY1Ls3h/4XaNgsencoIvcOqNu2ozD2MZ1/pwsers4uJKdcavsYs8aP+UTPReEnQJlYaYcR7/6jA7S4+aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Waj1gaAP; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waj1gaAP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so2248865e9.3
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 19:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789093906; cv=none;
        d=google.com; s=arc-20260327;
        b=ejQW7jWQl3wN2gmO0+4J3k3PKx/DoohHcjRzvU260GLT61p+4m1RJwCHLe7z4sSB9q
         ivem9bPfs1eu02rBt5BgUB++EGYrGXoB1uKKVL5tN0im7jYvi+tjxSyK8KYq8EXnAf+3
         CekIuileWXGoE/T5CiHyJU1+8w/3rxXxOpeYgBPyqbxcLqZn2zrxClycZbemFkQiJ5BC
         ANdWVFDq6MofFUjzmwP17P4c7xKlO4g0jwzAL9flmlHNPDQ8gx9jJhSvTJrxilJBI6Uj
         i4IlfxstP/P4KdSLe0O5BhFM6bQg2KX0usBAijlrIcucnGxaLdPOV8oRgPicmHAPEACy
         u5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4z2PlAx+ooH1DQkWitjSiJSFWsoxu8y4GadNPU5V8DY=;
        fh=yrdAnsuYtuHESXneJeSL9gJapHZDjTRWHRGFyB2T5kc=;
        b=selNAFdB+ThldT9WLWoh0pLpmfi/ZnzKFFoLUhBHFqJpHMoFBJuEReeQMl8YNv1ZaC
         DcwMLiETJwg+yn//iAyMHq1HeIAs2BXFl02yKm/onrUGyPbsDUxlq/JEqU8m2/zMyVBg
         sibmmL/p+kzTQQwVm+fUH3a5rgt4XrFYioCRYmifxCvd+dZ5kF0ojafmyW2M6Kq1iJiN
         2cjPxLZGEVR4iskoGSYPguTA9XBh6a/RaL73wNEMa4POlO9QmckIUmRFsjiPsP7nLzkR
         ycF0qHTt3YGIToz7IdHW7VCL85v8oEHsPtRev1IWtLQURkPQdqn3Pc4UzLqt9vWE8n3F
         uiwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789093906; x=1789698706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4z2PlAx+ooH1DQkWitjSiJSFWsoxu8y4GadNPU5V8DY=;
        b=Waj1gaAPRbeeZWO+r97UfU7JDEh5kl/ZuIfwBDPIqo3YJqxtsSmPOAyfkUogTL+Hzm
         Es+U8Wi+hg1jxqml/gEl9aDID51S5FZYA4EFSWD+iIvKAjKUdiEOrcAAoHoT74umWtKL
         E67e66VPtCwElnxLZfKzkDpM3mBspiFPIZW9ECNjS9oHo/IPD1kRgYgpalIMwdG1O3Vl
         zK7nfSn1C2pGmYBBi8nUuoRYcunzdg5eRPPzwO/X8X2LcsdN9Watftk+8lbj21nINPlQ
         Ql1I0aVow13wm49cHFaTm5r0v39EiQeI6qwtL/sJb53l5srOFqETck1C0NK6QWL30IOX
         i5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789093906; x=1789698706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4z2PlAx+ooH1DQkWitjSiJSFWsoxu8y4GadNPU5V8DY=;
        b=TjPTCk0jPcVPCT3yHzipQWoKPwhq0hi9BWctGgwWQiFZgGggN//3pzoKoel8ZT1Zk9
         rwhUHHg8+0S3GmQWNTxp8DxPmMstL2ShEgcW78OSltdYirP5ZphcQ8FXuQKR8KDOc4Ho
         uRhfNbn2xt+oa4bJwuZK5C++8TvYsaPxAyesiHJ26hhQI8NrSEgHy3MnS7I0fJW7pJaG
         Uxtdl1fTxcu1H12eLWFFbmerRwfXbliHHZiAWoBjj3PGMZrWQD7fwoUrYR0R7deoukEp
         TtKphO3y/RuZlDzrBEsDpWJaaIQ4+rbtVVxuvifTeeSm2r9pImutvI2hTAM0N2tK06I3
         C9uw==
X-Forwarded-Encrypted: i=1; AKwUvBxc1U4/YPkziyCq8B78yYqvXE1hHH3hsHj6ienck3ErPiJ6b/cT/2aaqllIBt4szwS+gVU=@vger.kernel.org
X-Gm-Message-State: AFuF++mwugdvp2YefEua0p+oaflrl+kX9WV07cM2G9DeF6tOcDc+FbA3
	SvP0tF4uxPf9rttS3OlJ9DCtkLUArVBGCmfj77QlfQGb1//9DdPqEHYA9XuuaRB1oCbeSLHLOXg
	nNbQLdlJ8lLGQFZbAxrAGTs6iulQiPNE=
X-Gm-Gg: AYBFou3datInBLg57snFgAc7ciogaqflJYQrcV6ZmPqqmHk3JwJg4A9NTf3V/GsGWBA
	F49no5HKMBMC/nrlUOU8gmibRqA6wvIwAEqSoVjtQ9OkzVqRAOviV5t85x+f0z0Rseop8pSE3e3
	MF7JqKMDv8TTwkzCVYAuS+Y35ctYI5VT3VXkzDKMT3cyuXHtjjG3WxjEtiZQWlov5qrzZ6bDneC
	n5FnD2inhIYBXzINePrtVAiSc1YS9+ct/eR63BWajNrb9wxu58QVeCPwvpTZf0YRvW3Wj86IVvz
	VT5BzFJ9qO00lg5s75pu4gWYE8IjM4p5FJWuHL5dUwszJSmC+BNqspjLMPM1UTSNa5nDBAyr5pB
	c/bJa4PX+8AJ5EfRh22WrxZWB
X-Received: by 2002:a05:600c:4e0c:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49e6198734emr48605425e9.6.1789093905582; Thu, 10 Sep 2026
 19:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075829.2073224-1-kunwu.chan@linux.dev> <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
In-Reply-To: <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 11 Sep 2026 10:31:33 +0800
X-Gm-Features: AcwNN1VoKSQ59tly50x3h78cd3RLsXN_AHHDzi0tZfm-mT8UWJfPRMG8hB-w29I
Message-ID: <CAN_Opa_rqLQ+SEvWeaLpi3qa2SB7hA-3n+e12h7QQSAPfKCpEQ@mail.gmail.com>
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

Thanks, Zqiang. Good catch on these missing SRCU synchronization
checks.

I=E2=80=99ll review these against the existing SRCU synchronization path an=
d
send a follow-up patch if confirmed. I=E2=80=99ll add your Suggested-by tag
for the changes.

Thanks,
Kunwu

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
