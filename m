Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAB375AB8;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582346; cv=none; b=tMwsZNI4I8hokAUbIjOHvBr1b7zfQzkqpET2V7G8W929OM6JndjjxoylzwRLJnZGN4J5jHYHWMrsL2cZk18ooRbFRtWUfB3ODiyMIx4GHLo916yCuUmK6W+IQMLUYUjlHuEHMZM1giYyvGGiG+h//mCEld6PVjZ/eII2mBkc+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582346; c=relaxed/simple;
	bh=m9Bnjv8EFFWoPUMz39NrZyY+JypAq7XPC013MrJ6Xsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGNfGf7FbGiNiVjkla6M9xQsq2/ntY9ys0UOYHUvh4/seIzC7yrhKdg69aeBBJOz0R6iQCM+vhZCsxBB7x7qbyudyA1Qqv71sQ4Hnykex1WMpLeELVS/PF+Qq9Ig54WESMZo0nT273qnWQIPM6PgWFNjkkVHWDYlxKDQhj2TF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtLD6AHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtLD6AHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C8C19422;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582346;
	bh=m9Bnjv8EFFWoPUMz39NrZyY+JypAq7XPC013MrJ6Xsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtLD6AHiJMT8KUxUyeZnQkkUU9VUri9UALjHsD/ybpA/HqyA2Fr28xiLapsCELE8f
	 Hdqwo4q8UYivNAPJrojAa9nqN5tTQhGIlTbZ4/rzzssB0oLKIqXhMhxqcXXDsZqrDW
	 +KkVoj6VWwJN4aBudq+vLH6vFuaYISkrtf3N8E/NgC/NF0MG5gWtn40rSCm45XUPtX
	 SUdBnx0ytGX/lxp7XAVQnSomdPtbZgXJJpYbv/eREAlcedp4o9cYZcWlxYXelENXff
	 qvPoPNfR2hYpNoSrkB5e3X83jBwedsGlL1FfwMwwfX+vwO3Hrbavht7IMgICputtER
	 BkxiezXLVyaTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2D78CE0DFD; Tue,  3 Mar 2026 15:59:05 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/4] rcuscale: Update due to x86 not supporting none/voluntary preemption
Date: Tue,  3 Mar 2026 15:59:01 -0800
Message-Id: <20260303235903.1967409-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such rcuscale scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/TINY    | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
index 0fa2dc086e10c..c1a7d38823fba 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
index 0059592c7408a..f3f1368b83869 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.40.1

