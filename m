Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B81A76D5;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=QhpoVUi5hwecunHmO1lhP+DJBVwvlI+GAGepFNOklODPxCw5RMRlt4/QIB+SrIMpvwWYOsmO1zvxX0q/8PXE/NjisFGOy5ftKE/8K5c0dir3KYFjspM+2TNv708I+lect5u2otwUNfRudkWqKyR+utVh9VbHPMH+iJWNRkJZCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=ChclQjdk1wWpYrsOxGeef20vXWr7m8b4FD5ACzrOUE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhEYlHBMkqgzH9hYygxu05uWJhHyv+KG+Dn3vTcYJH14Ug7v9+KQ8+ZBAKZk64zVnGOji0W7T4heL8QrG1WJlN+KcXlCS4Ut6qJzHvLqv4yZBJWFjkqVr2ohcsEyYHhyz3aIdzt9ueV5pvhX05HK6f+IafPFwAwh7GVMU+sOS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UloGKvEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UloGKvEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5F7C4CECC;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496846;
	bh=ChclQjdk1wWpYrsOxGeef20vXWr7m8b4FD5ACzrOUE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UloGKvEjq5TAcI62jhgjmcZ0N9cY+N11CprmxYp48Lp9TbqchMs5ZPJjdTgLbuEZ4
	 VrjqgeK1hYHexzCx62kSUX/mhiE5OJzH99/N+DTLKYv4aYm9/5dwshq/QjSKgcPtqu
	 +DQGkHSb9/YqyNW7iai6ZUDCN0BAXPVvvAoemfd2784Ys3d0XO0LXX0uf1KutzH8WE
	 F+vvl0AMKQlPap7w71QoVcU7lIB+jCORGB94VHToTUhcKMX1+tjHBN52ASJxhSQu1w
	 cQAwxJ1hla7QZy7hNJfP64yNgVKtS4hMGU0xJUi4Vb4nc2GiOlsJbjIVKlUOS0oGi+
	 zKQQmKsvdIF2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 693FECE08E5; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Olivier Langlois <olivier@trillion01.com>
Subject: [PATCH rcu 1/7] rcu: Add rcuog kthreads to RCU_NOCB_CPU help text
Date: Wed,  9 Oct 2024 11:00:39 -0700
Message-Id: <20241009180045.777721-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RCU_NOCB_CPU help text currently fails to mention rcuog kthreads,
so this commit adds this information.

Reported-by: Olivier Langlois <olivier@trillion01.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3e079de0f5b43..b9b6bc55185db 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -249,16 +249,24 @@ config RCU_NOCB_CPU
 	  workloads will incur significant increases in context-switch
 	  rates.
 
-	  This option offloads callback invocation from the set of CPUs
-	  specified at boot time by the rcu_nocbs parameter.  For each
-	  such CPU, a kthread ("rcuox/N") will be created to invoke
-	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
-	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
-	  from running on the specified CPUs, but (1) the kthreads may be
-	  preempted between each callback, and (2) affinity or cgroups can
-	  be used to force the kthreads to run on whatever set of CPUs is
-	  desired.
+	  This option offloads callback invocation from the set of
+	  CPUs specified at boot time by the rcu_nocbs parameter.
+	  For each such CPU, a kthread ("rcuox/N") will be created to
+	  invoke callbacks, where the "N" is the CPU being offloaded,
+	  and where the "x" is "p" for RCU-preempt (PREEMPTION kernels)
+	  and "s" for RCU-sched (!PREEMPTION kernels).	This option
+	  also creates another kthread for each sqrt(nr_cpu_ids) CPUs
+	  ("rcuog/N", where N is the first CPU in that group to come
+	  online), which handles grace periods for its group.  Nothing
+	  prevents these kthreads from running on the specified CPUs,
+	  but (1) the kthreads may be preempted between each callback,
+	  and (2) affinity or cgroups can be used to force the kthreads
+	  to run on whatever set of CPUs is desired.
+
+	  The sqrt(nr_cpu_ids) grouping may be overridden using the
+	  rcutree.rcu_nocb_gp_stride kernel boot parameter.  This can
+	  be especially helpful for smaller numbers of CPUs, where
+	  sqrt(nr_cpu_ids) can be a bit of a blunt instrument.
 
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
-- 
2.40.1

