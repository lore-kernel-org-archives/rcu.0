Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4854C98;
	Wed,  2 Jul 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415815; cv=none; b=U3d+KoSSpWu0SNsOK6xmRMPKyFo9pBC/jjyOlIi5hfjmfNOmh90RmsNVpRzJQlx+nS4eccrEm4MXaaDsv8oIHXXfx/ymvta45aYuPC4QOO7QRnyOoVBwg3QfCJzJFVO+UfwP6WDeJUNgWrKtyeSsin3+mQK7SwCfl5OHT5CEnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415815; c=relaxed/simple;
	bh=ZgMvbMndZacqE3zWzT/NlRtIf5NM7rx7pJurGiqBCyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMm/3hVdzowzeBGUCHrS7xkth+alqiA/aNrGIGNpT8LTSz0Hur/PxQ7E1QQG/zk0FysCezi9lFfcMxxjWPVg/NZ2KeeiuC6DJrTeBuxYYGq6Vg/xH2QH3V5d9yo+uc6SCIAgiEqe9eeH4miA/JaTit+1KprHXSjIn6DkijMNKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds3oC7rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds3oC7rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E391CC4CEED;
	Wed,  2 Jul 2025 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415814;
	bh=ZgMvbMndZacqE3zWzT/NlRtIf5NM7rx7pJurGiqBCyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds3oC7rNIXuVlDx/WcD7hXrYozYA4gq9HmdQ3qxBIqxQ4CoV272WiPpk+RuNlXnEQ
	 7p/L8MfV2JlWV1Jzw4G+SvtSf18S4IExXG2VUeT9Yt4yrCWzKVC/NQAD5gCKus4jsz
	 4GnvILm/kZSMufHvXrp2xdhgYd/nUXnFdGJP+mNbAaFwLdSOAVx7GMGm1P0ohTBEad
	 k0L4GQaBcc4QIDFGgcbdtAsGsg/BE3kF5WKLpmpDno6EY940cR9gZnF3JpM+eK1Bhe
	 9HNCmRY156oOTDhTcAZ7HkFJE0FoSYSZTEJDgvk5H8FRqdiJfe/sR/cI6z8U5v9Fnd
	 z7zdIdxCKawoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89D88CE0EA2; Tue,  1 Jul 2025 17:23:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/5] rcutorture: Remove SRCU-lite scenarios
Date: Tue,  1 Jul 2025 17:23:27 -0700
Message-Id: <20250702002330.1074433-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
References: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prepares for the removal of SRCU-Lite by removing the SRCU-L
rcutorture scenario that tests it.

Both SRCU-lite and SRCU-fast provide faster readers by dropping the
smp_mb() call from their lock and unlock primitives, but incur a pair
of added RCU grace periods during the SRCU grace period.  There is a
trivial mapping from the SRCU-lite API to that of SRCU-fast, so there
should be no transition issues.

[ paulmck: Apply Christoph Hellwig feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L  | 10 ----------
 .../selftests/rcutorture/configs/rcu/SRCU-L.boot       |  3 ---
 3 files changed, 14 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 45f572570a8c3..98b6175e5aa09 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,7 +5,6 @@ TREE04
 TREE05
 TREE07
 TREE09
-SRCU-L
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
deleted file mode 100644
index 3b4fa8dbef8a9..0000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
+++ /dev/null
@@ -1,10 +0,0 @@
-CONFIG_RCU_TRACE=n
-CONFIG_SMP=y
-CONFIG_NR_CPUS=6
-CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_RCU_EXPERT=n
-CONFIG_KPROBES=n
-CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
deleted file mode 100644
index 0207b3138c5be..0000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-rcutorture.torture_type=srcu
-rcutorture.reader_flavor=0x4
-rcutorture.fwd_progress=3
-- 
2.40.1

