Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED04F5DE9;
	Fri,  9 Oct 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570694; cv=none; b=WrGik342tx1TuKhmBn0nksS15QZMONRJ45lAXQA1T6XcrNh5iBz1NcLI1TgayvUMGW5ir7H/PV2MS5+QlefS0z6Oe863+hY5NHW9boRRLcWh55BgL5UaZICB/LrU47olqYKn2NJY7EOEMmdtEeMyiMKhCBNVpwgrlUxJA1Kw2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570694; c=relaxed/simple;
	bh=WXLB73kkIakUAim7Eg9Y9nYVEKu60EaxHa5X93j7KZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0irGEI0OwCbQW05L1m9hdfMX4T6WAB6H0f1UBJTqaGHOxrlFQNAKeWBEfkr5myxu7F4Bh/RuzL9ntzE/oHzdPLIypU80KFC93Qc23i8kYH6V/72qbfZ/LxrrqhEmU1AjeXJJ9fxOetpdUfbG+jPohhRuBGmDfltNx5VUUZZgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AqmIniWW; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AqmIniWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1791570109;
	bh=2afBeh2mVG/TH/Uk0ZRXH0or7xfvfRpuQgTc0p9kvhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AqmIniWWJyqv90Dm3R6ywHGvi0u7Ao3LEynowaN7b7hU6CELpr4/LL5UGtnzTj/KE
	 iaAi00CKv/r2iC4dctKQycovNiI/VqzFbeQ1kAw/ObzNXAVN3A0zVkyteP8Xs97kg4
	 qoKfB3cMemHpdz1lZf6hsyjALTUL/N1lHhdf1LGE+5yD3VWaFuyUk/Hdtja+ypu6+h
	 41mdRP8dQwFKVlQVej9cuipqA63gjKh7ae3sTiPNnBynGcthq0e2UcTNvP2MEuLDs8
	 BXjmTtsCXq+KnYBdtL2H3HoqNvwYd54KgYt41CaS5E6Khjekb8nh9E2PS0d9x511ok
	 C+hLZ2RSioLLQ==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j1ZvK2s0MzljP;
	Fri, 09 Oct 2026 14:21:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH hazptr v2 0/4] Hazard pointer updates
Date: Fri,  9 Oct 2026 14:21:31 -0400
Message-ID: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

This series applies on top of "hazptr: handle NULL address in
hazptr_detach" you have in your rcu dev tree.

This first patch addresses a race identified by Boqun Feng in the
two-phase wildcard scheme. (no change since the last series)

Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
Those were discussed at length in a prior version of hazard pointer
patches.

Since the last series, I have modified patch 2 to take into account
feedback from Linus: There is now a x86-specific implementation of
ptr_eq, an asm-generic fallback, and both sit in newly introduced
"ptreq.h" headers.  The documentation is moved to linux/ptreq.h, which
includes asm/ptreq.h. This reuses all the usual mechanisms for
arch-specific implementation with asm-generic fallback.

Patch 4 introduces a "try acquire" helper to allow the fast path
to not rely on wildcards, while keeping the wildcard forward
progress guarantees in the acquire slow path, used on fast path
failure.

Thanks,

Mathieu

Mathieu Desnoyers (4):
  hazptr: Fix two-phase hazptr_synchronize race with detach
  ptreq.h: Introduce ptr_eq() to preserve address dependency
  Documentation: RCU: Refer to ptr_eq()
  hazptr: Introduce "try acquire" fast path, fallback to overflow list

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>

 Documentation/RCU/rcu_dereference.rst |  38 +++++++-
 arch/x86/include/asm/ptreq.h          |  16 +++
 include/asm-generic/Kbuild            |   1 +
 include/asm-generic/ptreq.h           |  16 +++
 include/linux/hazptr.h                |  48 +++++----
 include/linux/ptreq.h                 |  63 ++++++++++++
 kernel/hazptr.c                       | 135 +++++++++++++++-----------
 7 files changed, 237 insertions(+), 80 deletions(-)
 create mode 100644 arch/x86/include/asm/ptreq.h
 create mode 100644 include/asm-generic/ptreq.h
 create mode 100644 include/linux/ptreq.h

-- 
2.43.0

