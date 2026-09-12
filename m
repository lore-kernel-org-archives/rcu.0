Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7E2D12F3
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173718; cv=none; b=uRZcMUMTegeSbfUHIr2QmMi1wk2Hjvb79rpF/RdKr1310blVC4TP6VNtu37sPrUiqtUCXlrCeegbPUugf8qTEHwgXczphRi8k4kB3zZAEXAulG5Tpjx1J8rWpDbleVThB8N7ZzCSqQkbSBSDmAN2nfhknDaeuFPchqPOaQxgefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173718; c=relaxed/simple;
	bh=Rq6h6MkloDu8/TIhp3A0RYwCRdFlYSizx8bMbaLnmF4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VzBunEUl3uTsXiQdXeYi6cB56R9MP4jFRLYAs1dONBX0MNPNgUlWZm4VISKMuaERmclBIa6ivJuwgLS2WnLGuc5n/fg2yMXxkeMMbRxRnSTzY1TnihXqO3Wipdkai7QF737iLyONZHN/o3jPClX3OO3NGd2jrJWxbYYoD2h6Ves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDh8Um1I; arc=none smtp.client-ip=91.218.175.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDh8Um1I"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rq6h6MkloDu8/TIhp3A0RYwCRdFlYSizx8bMbaLnmF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789173708; v=1; x=1789778508;
 b=UDh8Um1Ik7n0n86rvcOUGQwZwFTmt7zZA41DsnnjQbEw78SF8L6WZj94hoVRl615q95bs67S
 8rHxrVVcwZW4GWCoDZACsLNd92V2UhIbUXvNSf6JNj/fN4XjIsUfCva8OBkFyUbWJbSdW5RElzk
 d/7uF33axRXoiLZiKBqh/v24=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 82c32faf23c26956;
	Sat, 12 Sep 2026 00:41:38 +0000
X-Mizu-Trace-ID: 82c32faf23c26956
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Sep 2026 00:41:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <4298908f242e82d54e0f462307ee18fa777b0935@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 00/13] srcu: Round out atomic SRCU support
To: "KunWu Chan" <kunwu.chan@gmail.com>, paulmck@kernel.org
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
 josh@joshtriplett.org
In-Reply-To: <CAN_Opa-cvXVJeMxniuarq+2mE9EepjzTCgii1bW6mmSnaCKKxQ@mail.gmail.com>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <c201584b58aec856342e0f23f8df9f81baccba1d@linux.dev>
 <CAN_Opa-cvXVJeMxniuarq+2mE9EepjzTCgii1bW6mmSnaCKKxQ@mail.gmail.com>

>=20
>=20On Thu, Sep 10, 2026 at 8:16 PM Zqiang <qiang.zhang@linux.dev> wrote:
>=20
>=20>=20
>=20> From: Kunwu Chan <kunwu.chan@gmail.com>
> >=20
>=20>  This series rounds out atomic SRCU support with a reader-free fast=
path,
> >  some atomic-context fixes, and additional test coverage.
> >=20
>=20>  The core change is a reader-free fastpath for synchronize_srcu_ato=
mic().
> >  Atomic SRCU's read-side critical sections disable preemption, so whe=
n
> >  the summed lock and unlock counts match for both ranks,
> >  synchronize_srcu_atomic() can end the grace period immediately, with=
out
> >  the index flip or the srcu_advance_state() scans. Correctness depend=
s
> >  on the grace-period anchor written by srcu_gp_start() preceding the
> >  lock-count scan; two LKMM litmus tests (patches 1-2) verify that
> >  ordering.
> >=20
>=20>  For synchronize_srcu_atomic(), the following items maybe also
> >  need to be added:
> >=20
>=20Hi Zqiang
> Sent as: https://lore.kernel.org/rcu/20260911093515.2802551-1-kunwu.cha=
n@gmail.com/
>=20
>=20Did a small late_initcall that enters an atomic read-side critical se=
ction and
> calls synchronize_srcu_atomic(). srcu_lock_sync() catches it:
>  WARNING: possible recursive locking detected
>  swapper/0/1 is trying to acquire lock: (&ss) at:
> synchronize_srcu_atomic+0x28/0x380
>  but task is already holding lock: (&ss) at:
> srcu_lockdep_test_init+0xd0/0x170
>  *** DEADLOCK ***
> Rcutorture SRCU-N/P also pass.

Hi, kunwu

You can add srcu_atomic lockdep test to rcutorture to verify
your change, and I also saw that Paul suggested the same thing :)

For example, as shown below (I am not test or verify it):

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d795e07a12ad..d4f7399acbd5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4662,6 +4662,17 @@ static DECLARE_RWSEM(rwsem7);
 static DECLARE_RWSEM(rwsem8);
 static DECLARE_RWSEM(rwsem9);

+static DEFINE_RAW_SPINLOCK(spin0);
+static DEFINE_RAW_SPINLOCK(spin1);
+static DEFINE_RAW_SPINLOCK(spin2);
+static DEFINE_RAW_SPINLOCK(spin3);
+static DEFINE_RAW_SPINLOCK(spin4);
+static DEFINE_RAW_SPINLOCK(spin5);
+static DEFINE_RAW_SPINLOCK(spin6);
+static DEFINE_RAW_SPINLOCK(spin7);
+static DEFINE_RAW_SPINLOCK(spin8);
+static DEFINE_RAW_SPINLOCK(spin9);
+
 DEFINE_STATIC_SRCU(srcu0);
 DEFINE_STATIC_SRCU(srcu1);
 DEFINE_STATIC_SRCU(srcu2);
@@ -4673,6 +4684,17 @@ DEFINE_STATIC_SRCU(srcu7);
 DEFINE_STATIC_SRCU(srcu8);
 DEFINE_STATIC_SRCU(srcu9);

+DEFINE_STATIC_SRCU_ATOMIC(srcu0_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu1_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu2_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu3_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu4_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu5_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu6_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu7_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu8_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu9_atomic);
+
 static int srcu_lockdep_next(const char *f, const char *fl, const char *=
fs, const char *fu, int i,
                             int cyclelen, int deadlock)
 {
@@ -4702,6 +4724,13 @@ static void rcu_torture_init_srcu_lockdep(void)
                                          &rwsem5, &rwsem6, &rwsem7, &rws=
em8, &rwsem9 };
        struct srcu_struct *srcus[] =3D { &srcu0, &srcu1, &srcu2, &srcu3,=
 &srcu4,
                                        &srcu5, &srcu6, &srcu7, &srcu8, &=
srcu9 };
+
+       raw_spinlock_t *spins[] =3D { &spin0, &spin1, &spin2, &spin3, &sp=
in4, &spin5,
+                                       &spin6, &spin7, &spin8, &spin9};
+       struct srcu_struct *srcus_atomic[] =3D {&srcu0_atomic, &srcu1_ato=
mic, &srcu2_atomic,
+                                               &srcu3_atomic, &srcu4_ato=
mic, &srcu5_atomic,
+                                               &srcu6_atomic, &srcu7_ato=
mic, &srcu8_atomic,
+                                               &srcu9_atomic};
        int testtype;

        if (!test_srcu_lockdep)
@@ -4812,11 +4841,48 @@ static void rcu_torture_init_srcu_lockdep(void)
        }
 #endif // #ifdef CONFIG_TASKS_TRACE_RCU

+        if (testtype =3D=3D 4) {
+                pr_info("%s: test_srcu_lockdep =3D %05d: SRCU_ATOMIC %d-=
way %sdeadlock.\n",
+                        __func__, test_srcu_lockdep, cyclelen, deadlock =
? "" : "non-");
+                if (deadlock && cyclelen =3D=3D 1)
+                        pr_info("%s: Expect hang.\n", __func__);
+                for (i =3D 0; i < cyclelen; i++) {
+                        j =3D srcu_lockdep_next(__func__, "srcu_read_loc=
k_atomic", "synchronize_srcu_atomic",
+                                              "srcu_read_unlock_atomic",=
 i, cyclelen, deadlock);
+                        idx =3D srcu_read_lock_atomic(srcus_atomic[i]);
+                        if (j >=3D 0)
+                                synchronize_srcu_atomic(srcus_atomic[j])=
;
+                        srcu_read_unlock_atomic(srcus_atomic[i], idx);
+                }
+                return;
+        }
+
+        if (testtype =3D=3D 1) {
+                pr_info("%s: test_srcu_lockdep =3D %05d: SRCU_ATOMIC/raw=
_spinlock %d-way %sdeadlock.\n",
+                        __func__, test_srcu_lockdep, cyclelen, deadlock =
? "" : "non-");
+                for (i =3D 0; i < cyclelen; i++) {
+                        pr_info("%s: srcu_read_lock_atomic(%d), raw_spin=
_lock(%d), raw_spin_unlock(%d), srcu_read_unlock_atomic(%d)\n",
+                                __func__, i, i, i, i);
+                        idx =3D srcu_read_lock_atomic(srcus_atomic[i]);
+                        raw_spin_lock(spins[i]);
+                        raw_spin_unlock(spins[i]);
+                        srcu_read_unlock_atomic(srcus_atomic[i], idx);
+
+                        j =3D srcu_lockdep_next(__func__, "raw_spin_lock=
", "synchronize_srcu_atomic",
+                                              "raw_spin_unlock", i, cycl=
elen, deadlock);
+                        raw_spin_lock(spins[i]);
+                        if (j >=3D 0)
+                                synchronize_srcu_atomic(srcus_atomic[j])=
;
+                        raw_spin_unlock(spins[i]);
+                }
+                return;
+        }
+
 err_out:
        pr_info("%s: test_srcu_lockdep =3D %05d does nothing.\n", __func_=
_, test_srcu_lockdep);
        pr_info("%s: test_srcu_lockdep =3D DNNL.\n", __func__);
        pr_info("%s: D: Deadlock if nonzero.\n", __func__);
-       pr_info("%s: NN: Test number, 0=3DSRCU, 1=3DSRCU/mutex, 2=3DSRCU/=
rwsem, 3=3DSRCU/Tasks Trace RCU.\n", __func__);
+       pr_info("%s: NN: Test number, 0=3DSRCU, 1=3DSRCU/mutex, 2=3DSRCU/=
rwsem, 3=3DSRCU/Tasks Trace RCU, 4=3DSRCU_ATOMIC, 5=3DSRCU_ATOMIC/raw_spi=
nlock.\n", __func__);
        pr_info("%s: L: Cycle length.\n", __func__);
        if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU))
                pr_info("%s: NN=3D3 disallowed because kernel is built wi=
th CONFIG_TASKS_TRACE_RCU=3Dn\n", __func__);


Thanks
Zqiang





>=20
>=20Thanks, Kunwu
>=20
>=20>=20
>=20> srcu_lock_sync(&ssp->dep_map);
> >=20
>=20>  RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> >  "Illegal synchronize_srcu() in same-type SRCU read-side critical sec=
tion");
> >=20
>=20>  if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> >  return;
> >=20
>=20>  Thanks
> >  Zqiang
> >=20
>=20>  The series is:
> >=20
>=20>  1-2 LKMM litmus tests for the reader-free fastpath ordering.
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
> >=20
>=20>  The KCSAN race in patch 13 is a data race on the interrupted task'=
s
> >  ->non_block_count when a timer callback runs atomic-SRCU readers in
> >  inline=20softirq context.
> >=20
>=20>  Tested with herd7 7.58 (litmus tests), torture.sh --do-atomic-srcu=
, and
> >  torture.sh --do-atomic-srcu --do-kcsan (KCSAN+PROVE_LOCKING).
> >=20
>=20>  Kunwu Chan (13):
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
> >=20
>=20>  include/linux/srcu.h | 10 +-
> >  kernel/rcu/rcutorture.c | 1 +
> >  kernel/rcu/srcutree.c | 95 ++++++++++++++-----
> >  tools/memory-model/litmus-tests/README | 16 ++++
> >  .../SRCU-fastpath-anchor-before-scan.litmus | 56 +++++++++++
> >  .../SRCU-fastpath-scan-before-anchor.litmus | 53 +++++++++++
> >  .../selftests/rcutorture/bin/torture.sh | 24 +++++
> >  7 files changed, 229 insertions(+), 26 deletions(-)
> >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anc=
hor-before-scan.litmus
> >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-sca=
n-before-anchor.litmus
> >=20
>=20>  base-commit: ef15070f96c5f07de3a9b593c36f6e83bc9e3d58
> >  --
> >  2.43.0
> >
>
