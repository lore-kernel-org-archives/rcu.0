Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2326D4F9;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=VliRKynRQXdxNPrgG1SpbTEtfYB635C87OvIIYU6jkGenQjNUZ0+EOsrT5UWS85wmoz6aL86dvjTiPbBFNYPSmRUxxpULDRAEgnzyP6DjiMsxcJ0+Fg7bmZ0/zPbFtmco+EOkZFE8Dot4h8PSVPEzOEgMEC6gE5xKf1LIaXH9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=C2icL2fQQNUgO6Ny6Y6dB3rlOzYUyWDmQH4NRC/307k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGkruS0/B9c1E9ER3soXgE5Wa5llEOd1xppTLOKY7ctFDijSbpObYvXqAzqpIpn3e9Kz5iNFBebZwrcbFtgvs1m1JHRIO9dYSFVWMlNkxB2kFtM5Sf71aZwm2/AiC8goVJFUqFlYLCcRhOPU/QE2niuyIKTmHlqndXo7NAaBY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU870Jtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU870Jtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69139C2BCB1;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=C2icL2fQQNUgO6Ny6Y6dB3rlOzYUyWDmQH4NRC/307k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NU870JtdXj+AqLvUxd6CtsakRwz++l/mSaZqK8XiELp505nSyYcFSn2rtapjgP3A8
	 DTNweRS7Wxz1yN7gJgYyBQLDQvWHcokMpy+WKtLRDUEg056bbsSyJRyODnzG6d1KVq
	 L2F1mFzFS0XMrbIQ20e7t1xPpnj13I3iOzCGqH+UBJdY/GykM1eeIdpyvjTH5z3+5r
	 C9+3t33RLX2iFWrvRB/qEu1W6kVtBa11XuHMRFUFpeGlQE+I8bBFKAmVkDUUvF7QMW
	 QyNcaiORMrx2rhhQLvDa+/PJ89Hi6g1hVWtV1hrO6zpzVFwL55lg17ff3hExaxpjQK
	 35rby2Okn43cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E99C7CE0EDC; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 04/11] rcutorture: Adjust scenarios for default lazy preemption
Date: Tue,  3 Mar 2026 15:50:30 -0800
Message-Id: <20260303235037.1967017-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, most of the rcutorture scenarios do not explicitly set the
CONFIG_PREEMPT_LAZY Kconfig option one way or the other.  This can
result int "improperly set" diagnostics from kvm.sh, which indicate
that the scenario in question isn't testing what it is supposed to test,
which can result in missed bugs.   This commit therefore explicitly sets
CONFIG_PREEMPT_LAZY as needed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TINY01 | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE04 | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE06 | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 1 +
 5 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index 0953c52fcfd76..bd5ed7b0da5f0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -3,6 +3,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TINY_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index 67caf4276bb01..f49fda1c88811 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -4,7 +4,9 @@ CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
+#CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 9f48c73709ec3..0513aa33c32c4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -3,6 +3,7 @@ CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index db27651de04b8..bfd88c46dbd73 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -3,7 +3,9 @@ CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
+#CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 420632b030dc4..b2ce37861e71a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -6,6 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
+CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-- 
2.40.1

