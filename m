Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC43DEAC4;
	Sun, 11 Oct 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748154; cv=none; b=FHLuMxzOKU1An9d7VQdYqIW5C4WC1o06cOHMuVMjHJ/Wryo361dJ26Q+nIvPwL351w3SQkXOxdMwE+yrYLsKgqFio1nr8OiQdFotyo/fT0KdDs6tdmZVBezwcNyLUGxlYMBEtiEGBC4qW4FtcIR4RZfoiaqUEfFQPZ2OMLZffpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748154; c=relaxed/simple;
	bh=LztY0X7E68Sbewv6578zDUduCssEY7j9KwUdw6BWt3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PO7O0+dRYGbmEHutjDaT7986aklcIM5l5xgLkEijeJsATyxb/jhuS+7+aJP+Mr5Yr8VmL5VIHXupK+Vaq5Spoy1Hdvtrfbtw3aZx21rJHWnIOEYmL7dPb79Zb7KU7uTaLU62Qys7z1FOg3NEy07KKXd7nadmuHlj5YnW8B1r27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Kt+hu4nP; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Kt+hu4nP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1791748146;
	bh=sCnBiFHHnSG6/B0mgE4rKLkgnhja9jqWv4Ks92rPV/w=;
	h=From:To:Cc:Subject:Date:From;
	b=Kt+hu4nPYAGuUFUOfYdJ8Me8904l8LieyqRtVHv2dLBPlBjiP3uCqUH5AqI4MnsiZ
	 1AnfKKao4kK0dCDTwbnCAe96zVNX9U/gZgsOJX+K05gUr65cpLn4+lk25X7dirPFvN
	 djNnND6/bKa+tTI+K70cFtAE/Uky36wXYieFFGYkdTeNskWZ55LkBW6+kZZkMbCywD
	 FioBJSuthe9HDjVsvXSrq/KnQ7c/iQapXI73LtqJ7pJ5kSQ8OGPf1LsYCxRg0lYwfN
	 hFXKhyNHir0hIhN794Viu4PRXtCNTSTf7G1+5NL7zGua9mUnDpiw53zsmmTHFqLhEu
	 wX1y01gelog1Q==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j2rl62mbNzmGB;
	Sun, 11 Oct 2026 15:49:06 -0400 (EDT)
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
Subject: [PATCH hazptr v3 0/4] Hazard pointer updates
Date: Sun, 11 Oct 2026 15:48:46 -0400
Message-ID: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
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

Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
the feedback received from Boqun and Gary.

Patch 4 introduces a "try acquire" helper to allow the fast path
to not rely on wildcards, while keeping the wildcard forward
progress guarantees in the acquire slow path, used on fast path
failure.

Thanks,

Mathieu

Mathieu Desnoyers (4):
  hazptr: Fix two-phase hazptr_synchronize race with detach
  ptr_eq.h: Introduce ptr_eq() to preserve address dependency
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
 arch/x86/include/asm/ptr_eq.h         |  16 +++
 include/asm-generic/Kbuild            |   1 +
 include/asm-generic/ptr_eq.h          |  16 +++
 include/linux/hazptr.h                |  48 +++++----
 include/linux/ptr_eq.h                |  63 ++++++++++++
 kernel/hazptr.c                       | 135 +++++++++++++++-----------
 7 files changed, 237 insertions(+), 80 deletions(-)
 create mode 100644 arch/x86/include/asm/ptr_eq.h
 create mode 100644 include/asm-generic/ptr_eq.h
 create mode 100644 include/linux/ptr_eq.h

-- 
2.43.0

