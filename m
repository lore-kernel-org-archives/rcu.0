Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5F3B3C17;
	Sun, 27 Sep 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524326; cv=none; b=jSCVAHQKHX0PJkijPypq+5FDSLVIQwlV3eyfbADwlnuhd/KYrT1N6IMGCENRXXqhplEXIVhJuYvuO5V4tARJbAUoncTJWImQyak8u9HVE4Sn1NjjXkmbuKoQbXvxvPawGVrAmm/TQ1ugPHgGT2ZnxWhcJeDotGXviwPHRyTSLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524326; c=relaxed/simple;
	bh=uh5+QEAXdQ3aJXm/rqc9gITsrLpFRNWUPTWZarD8gdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BR2tRbWRsrxMRwzABYgovo3NAxamisTUMJm5zr8R1uTYt0va/oAHWcapep4u3NTeD7TpJ+sL2KPFuDrhsB4o5FppY4M899UApL9XJxv6EUG5/tURQ0S587vAXlyYle7jLUv1JSPmEb/fuzwRMrxjfCgSL8XscAalkCGnorm//+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bmIDR/qr; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bmIDR/qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1790524309;
	bh=CqnBE3DkErZugH/qRMaxksgb/KGywMpNP3MlUQmQoBg=;
	h=From:To:Cc:Subject:Date:From;
	b=bmIDR/qrFr/fRf4Pol38ucLoQfHlpCHL9H+ba80x+ulrGRXxJTQ2Wq2jZocUBOL30
	 Tg92XEFACjTF+HkwXK0mQrDvXxzLextcxsmchBfv5Dg4eb5OjTCfMCFjmVzHDoUfHm
	 JTHBKwbzWLKQQ2xHIipfdhuzp0Ynalf6wKq3l1j2hcwurvUfaAtkOfman61Wb7ynmy
	 G4Pq6QFNLGVNwptPiblXxOQZOvQ9DoQFVKto1aYk58vXb8lUDQQPOyMEqo5P/eJfIo
	 5ZYnEHKINZJm9wdQNP7jr1NJOZFm7UWXoEKm+aS23CbnUwVFoRtHLILWHBfWdLaWCk
	 flkNeuyM3UGlA==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ht87n2SHZzhGw;
	Sun, 27 Sep 2026 11:51:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH hazptr 0/4] Hazard pointer updates
Date: Sun, 27 Sep 2026 11:51:27 -0400
Message-ID: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
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
two-phase wildcard scheme.

Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
Those were discussed at length in a prior version of hazard pointer
patches.

Patch 4 introduces a "try acquire" helper to allow the fast path
to not rely on wildcards, while keeping the wildcard forward
progress guarantees in the acquire slow path, used on fast path
failure.

Thanks,

Mathieu

Mathieu Desnoyers (4):
  hazptr: Fix two-phase hazptr_synchronize race with detach
  compiler.h: Introduce ptr_eq() to preserve address dependency
  Documentation: RCU: Refer to ptr_eq()
  hazptr: Introduce "try acquire" fast path, fallback to overflow list

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>

 Documentation/RCU/rcu_dereference.rst |  38 +++++++-
 include/linux/compiler.h              |  63 ++++++++++++
 include/linux/hazptr.h                |  47 +++++----
 kernel/hazptr.c                       | 135 +++++++++++++++-----------
 4 files changed, 203 insertions(+), 80 deletions(-)

-- 
2.43.0

