Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531497;
	b=vVYNQ+mjLHwbrpnwKbO5SfYyPpEAeA+qSMQ+fGXp3jAwKTPXGgV0YL+t8YPMHnCFk9kK
	 L5sWhs+baZz3/miqF5Gb0gv2JfF02+ow8nE3k9hlA1YK4h+hrvq0LQxuA8NAMmVvkamRe
	 DrYLpTciOwMbmIDyvaJfZJhKHq7X62wsZmqP/djQulgTL5/Q6GLI6qOMQBP9+g0ZB7M5c
	 yjSZVF4P4lRk66yKquhDDG0A8zleVBG8osNqV7tMqD7t25MOWrfu0Cxxva7WUOXxbiQ1d
	 NSVKrNh+vX3eoNDfuMM979A1YTT96ePtMy0d99vXLpui1fm76PIONoAACqTkLHX1Aug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=twY6F37x2jIPrid/esbPDfcdxaETpyl42Bj+0b+/JBk=;
	b=l2j3WesoVdyDxNIcUnBG61O0hYlzfLO2QTqg2jKqPBa/G6Gk1hNO3X7vuHGDOQyVxr1A
	 0BtQaRiymdSOOV0MHXJtpQxqF1RSTLIi9FEJlL7RcG1TWJr6BXGXU2owpc6Ld7df+68Uq
	 iTrXCGnXSdu7pXZ4kg/qJj5e7NbFeC+vl0F9HyT44bHWAW91663SU35Jei0Kc7IFO+PJ7
	 k76SN9KMKk9AoBSRe4gDov48yBT/m+S1kZMpHKuyyTz0oysU+40PIr7XYzlL4nwcptge0
	 zlpG8PvVd2j0RHeVHJd3vCLd10M52x0gl0sh5Ra7NT57g2cAquzwFOVq3PzW2sNTyqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PggzqMBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A60CE60A5BCC;
	Fri, 13 Nov 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PggzqMBW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 334071F000C4;
	Fri, 13 Nov 2026 00:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531497;
	bh=twY6F37x2jIPrid/esbPDfcdxaETpyl42Bj+0b+/JBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PggzqMBWRlgYJAECnm/tg8g6DiO0zu+04Rkj4N1MA0MGJI2E3jr5EiDVF7bf87wIk
	 QXbSmqCltjKf2+8/OcjW8ARizSt5wfa73Wbebkd6jPo7SliSw14w5hwCK0Fg4smdAW
	 GoHqkMqvHm/AV/TRqFuBqiZGpfhejKxbiH9easKlCOBMAQ1gFLQ6FBoSNlrqI0uh0n
	 1YFavd0/c9dOUQcQ1mAeLw9JFH+u/G4jguUfMWbKdCFLH+ysAq7TP3bxh9GeHhbLDS
	 j4G5T/ut5e6glNBCakGAp8pud9XB0/52aSoHtv7VvZJfo943MwFxmMqQACcFR+BNya
	 5HoA5W9kBGWyg==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH for-v7.5 13/14] rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios
Date: Thu, 12 Nov 2026 19:57:40 -0500
Message-ID: <20261113005747.2977123-14-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The TREE03 scenario has been configured to permit testing of RCU
priority boosting, including setting RCU kthead priorities to 2.
But now that RCU priority boosting is default for preemptible kernels,
it is now automatically tested for TREE01, TREE02, TREE08, and TREE09,
none of which have RCU kthread priorities set up for such testing.
One approach would be to set up these scenarios' kthread priorities,
but this would fail to test common-case kernels having default priorities.

This commit therefore disables the testing of RCU priority boosting
except on scenario TREE03, which is set up properly for this purpose,
though rather unrealistically.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot | 1 +
 4 files changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index 1cc5b47dde28..73d51d869fd5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -6,3 +6,4 @@ rcu_nocbs=0-1,3-7
 rcutorture.nocbs_nthreads=8
 rcutorture.nocbs_toggle=1000
 rcutorture.fwd_progress=0
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
index dd914fa8f690..f2ca5d812f3f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
@@ -1 +1,2 @@
 rcutorture.fwd_progress=2
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 94d38445d393..41c3264f8e8c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,4 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
 rcu_nocbs=all
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot
new file mode 100644
index 000000000000..1f52e460e14a
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot
@@ -0,0 +1 @@
+rcutorture.test_boost=0
-- 
2.54.0

