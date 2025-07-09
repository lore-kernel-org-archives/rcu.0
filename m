Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448328FFFB;
	Wed,  9 Jul 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057768; cv=none; b=fVF8UZC7hK9tn9sDflKR8pNPZ2O/8ndxyHg+541fEBohqWgiO0fcV9g3k9lvctKMQZ7dka1y3SBS+BdWKFN+NuCvgqa4fGmd015mDib306l4QTkkzjcRs8Y6CajhRW/6j7hiMSHcCLFm+bbeAuqlZQcFmmx9sL0ueAl5Kp9PnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057768; c=relaxed/simple;
	bh=wKdPJPJ/I6sElxr2X9zIgE1Q3fP7t2VCbZRiKZAMmwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIeOAEO/wudYVfBW5AekgKLjxfCGaCbhOWzE/ghPNAM47uVSoa7p98VnFMB14SJ/x05h6fH9xbGgItrBtsz+c6SWe7JVBQhuZUR0WtTFud1OnNpxwrJ1mjNIGMJThMtY3SKb8Do0+O3SS998jZMtiW80/zBuL3lA5VyPfUXzJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT8Uvg88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT8Uvg88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CB2C4CEEF;
	Wed,  9 Jul 2025 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057767;
	bh=wKdPJPJ/I6sElxr2X9zIgE1Q3fP7t2VCbZRiKZAMmwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dT8Uvg88EFyM/JUm8nXkWLtPg7Egt7t/Zg1orojILyEBvhWWMw4dq4DcHglwxugzb
	 OSzUFh9PIz7U8OetbxhDfRmTjn4GuM5cVpfcACBbUD/P72e5fbDhOOjdwQKYqJjBDU
	 epB5uS4lj0B/xfTfdpktxQ+ToR00FjWzLCkX2vNtiBzcXrKA20WicR+nshuHET5Czt
	 +3/YiLcSsOwM2cv2JrTO8oP0+2GgtA+7kh7887Np93jQVQO+p7yg4tFsw3pbmB2Lwn
	 hEW+39X8447PDk6RGgbPYbKWdxKHU45oFbhv5rauqmv3jPz82eeFDD1svZbJ4rOgHt
	 mCATuBXYvC86w==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 03/15] rcutorture: Make rcutorture_one_extend_check() account for hard IRQs
Date: Wed,  9 Jul 2025 16:12:03 +0530
Message-Id: <20250709104215.15562-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit retrospectively prepares for testing of RCU readers invoked
from hardware interrupt handlers (for example, HRTIMER_MODE_HARD hrtimer
handlers) in kernels built with CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y,
which is rarely used but sometimes extremely useful.  This preparation
involves taking early exits if in_hardirq(), and, while we are in the
area, a very early exit if in_nmi().

This means that a number of insoftirq parameters are no longer needed,
but that is the subject of a later commit.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505140917.8ee62cc6-lkp@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a209d2419cfd..7944cc69321d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1920,10 +1920,10 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 {
 	int mask;
 
-	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
+	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE) || in_nmi())
 		return;
 
-	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled(), ROEC_ARGS);
+	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled() && !in_hardirq(), ROEC_ARGS);
 	WARN_ONCE((curstate & RCUTORTURE_RDR_IRQ) && !irqs_disabled(), ROEC_ARGS);
 
 	// If CONFIG_PREEMPT_COUNT=n, further checks are unreliable.
@@ -1938,9 +1938,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 		  (curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
 		  cur_ops->readlock_nesting() == 0, ROEC_ARGS);
 
-	// Timer handlers have all sorts of stuff disabled, so ignore
+	// Interrupt handlers have all sorts of stuff disabled, so ignore
 	// unintended disabling.
-	if (insoftirq)
+	if (in_serving_softirq() || in_hardirq())
 		return;
 
 	WARN_ONCE(cur_ops->extendables &&
-- 
2.40.1

