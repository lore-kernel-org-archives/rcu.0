Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1B14C5AE;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=BEdccXzWt5vkLQqCLAklctOeNOFNGZVBPyP+I/fMr+/XFqcL+XGwUTbbYv57noxkd3NC21Z4ovfCQQeT65vSYHQS1L4GT7KweTQpX0fr0qXsJuo3JyO4ZULSa3PH0ulj5GmbM6AH7TfZVaJAPldL7mXs8FQ7QybSo/oFIAXQ6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=i403K4lRwrOOtPyPhCFF+YfWbFsrii2TF1tAnWab5XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tv0AAebLQllHb69+UwbQf/HJkBr7fYh56jN24luCmUxr901aa/198GRELebD+Qyqqx8jSy/lNHqz6Q+6txpmso9TCvr65plGfreyp707hOZfSSCBt50c1/bxRXm75GHCRaosctiYk0fpxG7aiYqxZobJIiqABfGQSS9mwzgzoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPd4guF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPd4guF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B62C4AF0B;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=i403K4lRwrOOtPyPhCFF+YfWbFsrii2TF1tAnWab5XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPd4guF0RRmMpV+EL05Bi66m27gUk5t/z4GZ848oqnXCHYRdc+dql67eEOFW51XD9
	 AphaFbKSiXDlK15IsJmsO39QzweI4OvKMKuC/5OQjHKGndgmoSIfDxurzR514D4d22
	 7pF9kApYJvuB0KU3aF9LaiqxrLeg+dQ94DxARkj7o4rvZ49Zv22uYAB2krlr6rN/b/
	 qPex9HHIAxZ8gv2383gypqCwenKxslp5H711gIrz9sy8T+39h8Q5Q5Y6j3EVJPVXm7
	 strtTgJfbToIak0svQZ7iXtyCfZ98XIHfIetbWsmlboBX0Q0Ma9MazQavAB3gPkd8N
	 0TiPsaBd48Z3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F35B1CE3F27; Tue,  4 Jun 2024 15:26:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] rcu: Remove full memory barrier on boot time eqs sanity check
Date: Tue,  4 Jun 2024 15:26:50 -0700
Message-Id: <20240604222652.2370998-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When the boot CPU initializes the per-CPU data on behalf of all possible
CPUs, a sanity check is performed on each of them to make sure none is
initialized in an extended quiescent state.

This check involves a full memory barrier which is useless at this early
boot stage.

Do a plain access instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1a6ef9c5c949e..9fa6d2b557d6c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4772,7 +4772,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
-- 
2.40.1

