Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB57E76F;
	Fri, 16 Aug 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788836; cv=none; b=hFfkIAKrlbJ/QrhgxEwVvnziq2tt8d7+5ffXloQp1w4ZRee2ie1sMec7YEuM9QhQysou5Qg9AXiP+hcSuFuItSGVnkx1TXK5JR78jGTbdJD4G9QiUGm5rvpefup3ofFP4vjYaOCKyr9TN925JktroGYUnaIU6rNsYr7aWgmxchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788836; c=relaxed/simple;
	bh=YPkQUjcHmgKFCc+e9xA6C2pGFVqWtssaMx5lnsv5h8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3hrgBIqJCJ3GNrdDpgcaXvHz1bWu9+T/qAaAXhfFcUbY7VpAVvXkL/ohtAjYxqNmdDXmo6vLztQAT2hWdhwYfVafmM2KZk5qr6bxX2mF+aCaKroSwJQdI0+j2MrGCDvDIZgkYkZaoVcpYwzy05AYPKcQrgU3YlJCHtiaKXXJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRzDP8Cr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRzDP8Cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16F2C32782;
	Fri, 16 Aug 2024 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723788836;
	bh=YPkQUjcHmgKFCc+e9xA6C2pGFVqWtssaMx5lnsv5h8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRzDP8CrWR1g9FqqiiSCcvVgKw/N0wRGnKCsqDVEB1bs2TeFs910Zjyr2c7owqpxM
	 P23U7/aog9aCHpfzeAK3lkRj4+Jp/I6NUNLPcFWl0g1JSqcoWfN42+fbmGeoesims2
	 FSq4RdvokeWpk8OTeNeOf9iOkmqzXEIP4F0lh/UL8GqHeXEY3ealFcfCOhrH0DNAUN
	 uICFdAMOIf7vkJ4rQvksk6zRr926BVi4xj86hUptkAERALqBB6xRpn8PfHEMdHr8c/
	 F3zVqSMVIxnadi+IYjY80uw9PVjfihzFwJebjFpxli9tn641DQ8O6OJitz+576Qfer
	 MYXUWJOPwqZ8g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 1/4] rcu: Summarize RCU CPU stall warnings during CSD-lock stalls
Date: Fri, 16 Aug 2024 11:43:01 +0530
Message-Id: <20240816061304.48843-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816061050.GA46994@neeraj.linux>
References: <20240816061050.GA46994@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

During CSD-lock stalls, the additional information output by RCU CPU
stall warnings is usually redundant, flooding the console for not good
reason.  However, this has been the way things work for a few years.
This commit therefore adds an rcutree.csd_lock_suppress_rcu_stall kernel
boot parameter that causes RCU CPU stall warnings to be abbreviated to
a single line when there is at least one CPU that has been stuck waiting
for CSD lock for more than five seconds.

To make this abbreviated message happen with decent probability:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 8 \
	--configs "2*TREE01" --kconfig "CONFIG_CSD_LOCK_WAIT_DEBUG=y" \
	--bootargs "csdlock_debug=1 rcutorture.stall_cpu=200 \
	rcutorture.stall_cpu_holdoff=120 rcutorture.stall_cpu_irqsoff=1 \
	rcutree.csd_lock_suppress_rcu_stall=1 \
	rcupdate.rcu_exp_cpu_stall_timeout=5000" --trust-make

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/rcu/tree_stall.h                         | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..d56356c13184 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4937,6 +4937,10 @@
 			Set maximum number of finished RCU callbacks to
 			process in one batch.
 
+	rcutree.csd_lock_suppress_rcu_stall=	[KNL]
+			Do only a one-line RCU CPU stall warning when
+			there is an ongoing too-long CSD-lock wait.
+
 	rcutree.do_rcu_barrier=	[KNL]
 			Request a call to rcu_barrier().  This is
 			throttled so that userspace tests can safely
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4b0e9d7c4c68..b497d4c6dabd 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -9,6 +9,7 @@
 
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
+#include <linux/smp.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -719,6 +720,9 @@ static void print_cpu_stall(unsigned long gps)
 	set_preempt_need_resched();
 }
 
+static bool csd_lock_suppress_rcu_stall;
+module_param(csd_lock_suppress_rcu_stall, bool, 0644);
+
 static void check_cpu_stall(struct rcu_data *rdp)
 {
 	bool self_detected;
@@ -791,7 +795,9 @@ static void check_cpu_stall(struct rcu_data *rdp)
 			return;
 
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_NORM, (void *)j - gps);
-		if (self_detected) {
+		if (READ_ONCE(csd_lock_suppress_rcu_stall) && csd_lock_is_stuck()) {
+			pr_err("INFO: %s detected stall, but suppressed full report due to a stuck CSD-lock.\n", rcu_state.name);
+		} else if (self_detected) {
 			/* We haven't checked in, so go dump stack. */
 			print_cpu_stall(gps);
 		} else {
-- 
2.40.1

