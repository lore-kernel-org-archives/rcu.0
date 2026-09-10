Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C64825C1
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042613; cv=none; b=IFGYKJ/TN/foFimyepIDhVRh/hyct+eZJL+Z2skltApPZxoA61N1OLpLB20SO96p1maExCRkyxtlcTqyYr4Y+2E/hRW1rFHnO3OjP/D0592iUCoAoFdmSngS6bEV7Jddu5yBk+T3xcoBMSh3fO/iAZW8ZqYfS7RsP9xCbuuH414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042613; c=relaxed/simple;
	bh=pUeAzDI4OMNm7fLmWdRK7cq3PUYuAemTDShKix3Bpa8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DV87Z971d4Haav0Rx1IFqB76Y6QUhz4DPGUKaEBN4K+DtKB2XJtAl2fBNuDD2Jh12fBPT6KEg5eSc8CP2+WZrTAs1fUXN4zFnbNP/Gdg9/bA0n80e+tKH1358FKViSQIUA0eh6KxRihMpls8CLER8HssczhjkI72PqW2oSC/Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPP3yeZB; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPP3yeZB"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pUeAzDI4OMNm7fLmWdRK7cq3PUYuAemTDShKix3Bpa8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789042604; v=1; x=1789647404;
 b=UPP3yeZBKisKbmEKVufuuvY/UPoIBBs7NZ+G+lFF/UIp/Gdgw/SL6TR4JoE5Y1JG+LOYX0bB
 F/LFbCy5a4TVWW+ZtCnQyiHnf27hQDSCyejd9qtMD38CXV3WnoYEV6Kr1/FuG5cZ0RgMYBsVvDm
 mgi9zg1vCDpuOEqxpKVfVinw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 123ebebfecc01040;
	Thu, 10 Sep 2026 12:16:44 +0000
X-Mizu-Trace-ID: 123ebebfecc01040
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 12:16:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 00/13] srcu: Round out atomic SRCU support
To: "Kunwu Chan" <kunwu.chan@gmail.com>, paulmck@kernel.org
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kunwu Chan" <kunwu.chan@gmail.com>,
 jiangshanlai@gmail.com, josh@joshtriplett.org
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>

>=20
>=20From: Kunwu Chan <kunwu.chan@gmail.com>
>=20
>=20This series rounds out atomic SRCU support with a reader-free fastpat=
h,
> some atomic-context fixes, and additional test coverage.
>=20
>=20The core change is a reader-free fastpath for synchronize_srcu_atomic=
().
> Atomic SRCU's read-side critical sections disable preemption, so when
> the summed lock and unlock counts match for both ranks,
> synchronize_srcu_atomic() can end the grace period immediately, without
> the index flip or the srcu_advance_state() scans. Correctness depends
> on the grace-period anchor written by srcu_gp_start() preceding the
> lock-count scan; two LKMM litmus tests (patches 1-2) verify that
> ordering.

For synchronize_srcu_atomic(), the following items maybe also
need to be added:

        srcu_lock_sync(&ssp->dep_map);

        RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
                         "Illegal synchronize_srcu() in same-type SRCU re=
ad-side critical section");

        if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
                return;

Thanks
Zqiang



>=20
>=20The series is:
>=20
>=20 1-2 LKMM litmus tests for the reader-free fastpath ordering.
>  3 srcutree: add the reader-free fastpath.
>  4 rcutorture: add --do-atomic-srcu to torture.sh.
>  5-7 srcutree: honor and propagate is_atomic so atomic SRCU never
>  transitions to big.
>  8 srcutree: forbid srcu_expedite_current() on atomic SRCU.
>  9 rcutorture: disable srcu_expedite_current() for atomic SRCU.
>  10 srcutree: skip callback scheduling for atomic SRCU grace periods.
>  11 srcutree: drop the srcu_barrier() sleep for atomic SRCU.
>  12 srcutree: remove leftover debug pr_alert()s.
>  13 srcu: restrict the non_block annotation to task context, fixing a
>  KCSAN data race.
>=20
>=20The KCSAN race in patch 13 is a data race on the interrupted task's
> ->non_block_count when a timer callback runs atomic-SRCU readers in
> inline softirq context.
>=20
>=20Tested with herd7 7.58 (litmus tests), torture.sh --do-atomic-srcu, a=
nd
> torture.sh --do-atomic-srcu --do-kcsan (KCSAN+PROVE_LOCKING).
>=20
>=20Kunwu Chan (13):
>  litmus: Add SRCU fastpath anchor-before-scan test
>  litmus: Add SRCU fastpath scan-before-anchor test
>  srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
>  rcutorture: Add atomic-SRCU support to torture.sh
>  srcutree: Honor is_atomic in check_init_srcu_struct()
>  srcutree: Make init_srcu_struct_atomic() prevent transition to big
>  srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
>  srcutree: Forbid srcu_expedite_current() on atomic SRCU
>  rcutorture: Disable srcu_expedite_current() for atomic SRCU
>  srcutree: Skip callback scheduling for atomic SRCU grace periods
>  srcutree: Remove srcu_barrier() sleep for atomic SRCU
>  srcutree: Remove debug pr_alert()s
>  srcu: Restrict atomic-SRCU non_block annotation to task context
>=20
>=20 include/linux/srcu.h | 10 +-
>  kernel/rcu/rcutorture.c | 1 +
>  kernel/rcu/srcutree.c | 95 ++++++++++++++-----
>  tools/memory-model/litmus-tests/README | 16 ++++
>  .../SRCU-fastpath-anchor-before-scan.litmus | 56 +++++++++++
>  .../SRCU-fastpath-scan-before-anchor.litmus | 53 +++++++++++
>  .../selftests/rcutorture/bin/torture.sh | 24 +++++
>  7 files changed, 229 insertions(+), 26 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-ancho=
r-before-scan.litmus
>  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-scan-=
before-anchor.litmus
>=20
>=20base-commit: ef15070f96c5f07de3a9b593c36f6e83bc9e3d58
> --=20
>=202.43.0
>
