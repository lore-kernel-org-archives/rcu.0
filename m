Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB214FD260
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960950; cv=none; b=Yme6FIwn7laBcGqlZb7VJhZJpniogMudelsskeBYwt2eZxirXa1nyhTX4fSzc1nOUtizgvOpO0aOuXvKvUi1vLwb5hHKeleu7i1SQRLeu+2gS0vhXOXHP6LzgWgKBGqYV65BTK/luqWHzJ5HvZe3DPkDrCIeMmXp2/LoiF4ePXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960950; c=relaxed/simple;
	bh=P6kLUfqJKeds6mBcoX+09pwoLlGMX2WhGD61+udcnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cR3pHkaUNozuZXglO4lP2NzWwOxaD+At9lZWtlj2yRmbVZ8ek8p66lEWJlI8Rf67yx9qPfazn38ElK9EiNLfT3UMDMPBh2D1cLDFl3Bo4BTCzIyfaI654g753x06F1rxlzcKczxfBVe0EAkAiM7uwzPBdtAOb3VWwMlwKbWoYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arLAY77L; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arLAY77L"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so162276a91.2
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960943; x=1791565743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fl0M9kkOu81fD6UmnHPgP6gAcI7k1L5BHVF53b6ArLM=;
        b=arLAY77Lf5hP9ARIas2zgFclVUwfWR96quc5vpfBfKQ3ipa+ra9xPuTk+LJSPq1Szs
         gHVX+/ipK3emNX1fGPme1m2O39rxYIpZ4cI0IysNlfzvUZWlR59z+MTl9IVxIrLlnVIB
         OYv/ZETIGDsvFCY+w+8IleuES5EwIv87nn4q5Jm1rRa54TskejcnKAL9tIxaEsjPc6Tp
         9RRwcnw85aDqVddaCPdnAvRA7tY/2yWDEx5CUibU6GjuWF/UPHkM5KCGFNxF8/rloVlA
         MJ9EslIJr2irn8RhrUf+30MLGE8pHxm02kmvvD2s4kswVPiOnE4N/yAEk5Ad3iYV0307
         zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960943; x=1791565743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fl0M9kkOu81fD6UmnHPgP6gAcI7k1L5BHVF53b6ArLM=;
        b=Bq2j75+AwrEuw5aWrZgCXVS3P8e+Q23L3GZAT2MJGXCsYE8PWdMhxl8LNTgkrjGuAb
         R296OGnai8JicX7bCVxny8FoqCkN3WaG63keRQbXx3pzWcibqt7KkECf10FRdigw456m
         dKY82qZrWh9O+7VnqA1jpa3DYiX9jEIHugLgZ9XhYb/JUnGzwXraj1bofZAUF7svoshc
         sNrltj4jpE4fqNB2Kb3KkM0W8x0D2T6wCXh2ZdLz1PFsdjokgSKWoIn7VMss28wZ4+Nm
         TUx+K074HsyFUxWw8AIkQilkT4cA9Lg/FLKr3JlhOHHrCbbKrQPqUee7MKHktjG9F6ek
         /GCg==
X-Forwarded-Encrypted: i=1; AKwUvBwMriv8EvfW2/m9be4Kavq3LegBPJho6YTSKgHXmO2axWi284MLAnGCxWo94cBuWLPyQkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYILNkBWmIpT14v+QjYKmtEsl/aCwuub2FnjuXuc44GtgwcYnXck
	bD1OrD9LA0DQEh0MBko+V/K0m1OZ3rekOeyeT/ZQqnG6U3H1P2k1FO3Y
X-Gm-Gg: AYBFou0R4Muj8wkjmy3pEUbD4fvs08BmoPu3gL6e6MVqwb7id3H3Aa/YL6nXy9beBFX
	VW8cY4F3fjYVv+vvjKUmhdw9lK3omnII1UyYP9UDtZMP5sSEYysf+yLuUtyR9Kw0WF5PRbBuMP0
	Igo8pq/WMl5twa5h3OSSwKFD78OZHmDL1eBGsHiEnlqkkhH8spTwIM+oWrKctrDyACdt7u1rnT/
	FZYc5N9AK7wIDbeR2RQx/j8rXaATjwYgvjUdUh62ggj3MOBav7CYzuW3IKTx7mSkAFCPAj8NzM/
	dBVj+cZMDLVG+eyksHLYPHKQF9ttYp4ypsevmLd83ATaEuZNU6A0WO9xDeG1XYjBhQVAIqeo1n1
	zZ7/Bduqgk7F7F4Jrt739vy2kYE1+Cn3aD/TKwwucOkBsZ6RNUUKRF24EQHc4KPVeuN8ymbYS+l
	QE5Hmh0A2jO8+Qyzf7vFJ90qiAIj7Og1b3Kdde6F2fGGCZiFcqYtQ0HNOhDcg6f1LiznwU+NzTa
	nlxgcuB6LA4L4gm2g==
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id 98e67ed59e1d1-3a6ce9b0fe4mr3264396a91.65.1790960942759;
        Fri, 02 Oct 2026 10:09:02 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:02 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v2 00/15] hazptr: batch synchronize operations through a shared scan
Date: Sat,  3 Oct 2026 01:08:32 +0800
Message-ID: <20261002170847.3653663-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends Paul McKenney's v3 hazptr implementation [1]
with a shared scan path for concurrent hazptr_synchronize() callers,
and adapts the lockdep dynamic-key hashlist use case from Boqun
Feng's 2025 shazptr series [2] to the current hazptr API.

The series also adds rcuscale support and torture coverage for
the hazptr implementation.

The lockdep conversion replaces the expedited RCU wait in
lockdep_unregister_key() with hazptr_synchronize().  This limits
the wait to hazard pointers protecting the target hash bucket
instead of waiting for a system-wide expedited RCU grace period.

[1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
[2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

Performance data
================

All measurements are on an ARM64 KVM guest with
HAZPTR_SCALE_NR_OBJS=8 and round-robin updater selection; unless
noted otherwise, nreaders=0.  Scale tests run with
PROVE_LOCKING=n.

rcuscale synchronize latency (96 CPUs, nw=1):

              nreaders=0      nreaders=1       nreaders=4      nreaders=96
    scale       avg              avg             avg              avg
    --------------------------------------------------------------------
    hazptr     46 us            47 us          102 us            106 ms
    RCU       8.3 ms           8.5 ms         16.6 ms         54.4 ms
    SRCU      8.2 ms           8.0 ms         11.7 ms         11.8 ms

Hazptr single-writer latency remains below 110 us with up to
four readers on this 96-CPU guest, but rises to 106 ms when
all 96 CPUs hold hazard pointers.

Under 16 concurrent synchronize callers (nw=16), per-writer
latency at four CPU counts:

              hazptr nw=16      RCU nw=16     SRCU nw=16
    CPUs       avg               avg             avg
    -----------------------------------------------------------
      24       8.0 ms          13.6 ms          9.2 ms
      96       8.0 ms          13.3 ms          8.6 ms
     128       7.9 ms          13.0 ms         11.7 ms
     256       8.0 ms          20.8 ms          9.6 ms

Hazptr remains around 8.0 ms across these CPU counts, with the
scan-kthread retry interval contributing to the latency.
RCU rises to ~21 ms at 256 CPUs while SRCU stays around 9-12 ms.

Reader-side overhead (refscale, 96 readers on the 96-CPU guest,
3 runs each):

    hazptr     25.7 ns/op
    RCU        96.7 ns/op
    SRCU      134.6 ns/op

lockdep workload -- tc qdisc mq x100, ARM64 KVM, PROVE_LOCKING=y,
96 background hazptr readers, function-call IPIs per 100 ops:

    CPUs       hazptr              exp RCU            reduction
    ------------------------------------------------------------
      24       196                 207                 5%
      96       189                 265                29%
     128       193                 266                27%
     256       222                 384                42%

Hazptr issues fewer function-call IPIs at each CPU count, with
the difference reaching 42% at 256 CPUs.

The hazptr.sh test suite passes, including the lockdep scenarios
and the 8-to-256 CPU sweep, with no lockdep warnings, deadlocks,
or crashes.
Additional x86 server testing with Lian Wang is planned(maybe after
LPC).

Changes since RFC/WIP
=====================

- RFC/WIP: https://lore.kernel.org/all/20260922070950.4173245-1-kunwu.chan@gmail.com/

- Split the original 4-patch RFC/WIP into smaller commits covering
  shared scanning, correctness, API support, lockdep, scaling, and
  torture testing.

- Incorporated Boqun Feng's review feedback: use a Bloom filter to
  avoid per-waiter allocation, add scoped_guard() support, and add
  a debug option to force the hazptr acquire slow path.

- Fixed scan ordering around backup-slot promotion by scanning all
  per-CPU slots before the overflow lists, with a separate
  overflow-list phase.

- Simplified the scan cycle to flip first and drain only the old
  wildcard generation, with herd7-verified LKMM tests for both the
  in-flight and resolved publication cases.

- Extended rcuscale and hazptrtorture coverage, added a selftest
  script for the torture configurations, and fixed the
  hazptr_release() kernel-doc.

Kunwu Chan (15):
  hazptr: add shared scan kthread
  hazptr: use Bloom filter for shared scan waiters
  hazptr: scan all per-CPU slots before overflow lists
  hazptr: add scoped_guard() support
  hazptr: add debug option to force the acquire slow path
  hazptr: elide redundant first drain pass
  Documentation/litmus-tests: add hazptr wildcard-flip escape test
  locking/lockdep: use hazptr to wait for dynamic key lookups
  rcuscale: add hazptr scale type
  hazptr: fix kernel-doc of hazptr_release()
  Documentation/litmus-tests: add hazptr acquire-before-scan test
  hazptrtorture: add slowpath and lockdep scenarios
  hazptrtorture: add READERS4 and READERS0 torture configs
  hazptrtorture: add 128- and 256-CPU configs
  selftests/rcutorture: add hazptr torture test script

 Documentation/litmus-tests/README             |  13 +
 .../hazptr/hazptr-acquire-before-scan.litmus  |  45 +++
 .../hazptr/hazptr-wildcard-flip-escape.litmus |  46 +++
 include/linux/hazptr.h                        |  56 ++-
 kernel/hazptr.c                               | 336 +++++++++++++++++-
 kernel/locking/lockdep.c                      |  25 +-
 kernel/rcu/Kconfig.debug                      |  10 +
 kernel/rcu/hazptrtorture.c                    |  57 ++-
 kernel/rcu/rcuscale.c                         |  70 +++-
 .../selftests/rcutorture/bin/hazptr.sh        | 146 ++++++++
 .../rcutorture/configs/hazptr/CFLIST          |   6 +
 .../rcutorture/configs/hazptr/CPU128          |  16 +
 .../rcutorture/configs/hazptr/CPU128.boot     |   1 +
 .../rcutorture/configs/hazptr/CPU256          |  16 +
 .../rcutorture/configs/hazptr/CPU256.boot     |   1 +
 .../rcutorture/configs/hazptr/LOCKDEP         |  17 +
 .../rcutorture/configs/hazptr/LOCKDEP.boot    |   1 +
 .../rcutorture/configs/hazptr/READERS0        |  16 +
 .../rcutorture/configs/hazptr/READERS0.boot   |   2 +
 .../rcutorture/configs/hazptr/READERS4        |  16 +
 .../rcutorture/configs/hazptr/READERS4.boot   |   2 +
 .../rcutorture/configs/hazptr/SLOWPATH        |  16 +
 22 files changed, 881 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
 create mode 100755 tools/testing/selftests/rcutorture/bin/hazptr.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH

-- 
2.43.0

