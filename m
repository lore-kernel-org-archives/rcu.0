Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBB2D3230;
	Tue, 29 Apr 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934204; cv=none; b=ILdqEO2TVNTQhpPDtBtF6R4qfUiUvPAsyqhr/42dgyh67r4KFBUKFuw90Vd1yslK5H9rbvv+cjBVP0n46CshTTkXxRyhhA5D7NyX95b81hcPSNjj9NRDLdPSVl8AK+CMVYumGOMm9foh4oKISMg+1AS5JmRVzBoQbCbVbsu3Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934204; c=relaxed/simple;
	bh=yGWkKy/tKQerFkmSW04s+UTgCO9enQW5oW0EdLwrtek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiNyiuH9F4glzG4ZMgCpKGY5Oy1g7uVoxk9X7xTjOro8hDErbcLixEZb+DYTDYbzc3SGF+ZX8AOVtpCMOesjSO//GQP0oSrCHy13ACgDnzTqm8a/sHkB9TinO+Q4i9A91ea4R1ulO7KQKOLXtCymgVDoeZ3z+6R+pn8KkKOH9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7CRtGTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7CRtGTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E7C4CEEB;
	Tue, 29 Apr 2025 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934203;
	bh=yGWkKy/tKQerFkmSW04s+UTgCO9enQW5oW0EdLwrtek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7CRtGTvHO5PXI7/0xm2Dlb9UqieemyNO1L+QxPZC88h+YxCNFanYgAvRDZM7PE91
	 ebRCdv6+Z7yWgORKPR/cDpXk8/gPqp99uonvSIIO8+MMQ0ChnTLrp1YqslU5Mzeyw6
	 paclvxCYKmJUWSisz2s90hxATsGnAVnpvyr30clWITre9JcwkrTjY+ej0CKN2t0aab
	 kxZEve0hkaB8qdy5VLuN4bvEX3wuLw4u4oOLMzNPK8IvuZKJ42uZILVuBEV2Rg1HJG
	 9uKBzTDuk18p3ZWAOwkgz/tGPXK0QWjBxlcZfgIWameCh7spXPWTdR92u+SHuljhJI
	 PY4IufoBDXKOQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot
Date: Tue, 29 Apr 2025 15:43:04 +0200
Message-ID: <20250429134304.3824863-6-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429134304.3824863-1-frederic@kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU within hotplug operations can make the RCU exp kworker lagging if:

* The dying CPU is running after CPUHP_TEARDOWN_CPU but before
  rcutree_report_cpu_dead(). It is too late to send an IPI but RCU is
  still watching the CPU. Therefore the exp kworker can only wait for
  the target to reach rcutree_report_cpu_dead().

* The booting CPU is running after rcutree_report_cpu_starting() but
  before set_cpu_online(). RCU is watching the CPU but it is too early
  to be able to send an IPI. Therefore the exp kworker can only wait
  until it observes the CPU as officially online.

Such a lag is expected to be very short. However #VMEXIT and other
hazards can stay on the way. Report long delays, 10 jiffies is
considered a high threshold already.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6058a734090c..87a44423927d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -406,8 +406,18 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 		unsigned long mask = rdp->grpmask;
+		int nr_retries = 0;
 
 retry_ipi:
+		/*
+		 * In case of retrying, CPU either is lagging:
+		 *
+		 * - between CPUHP_TEARDOWN_CPU and rcutree_report_cpu_dead()
+		 * or:
+		 * - between rcutree_report_cpu_starting() and set_cpu_online()
+		 */
+		WARN_ON_ONCE(nr_retries++ > 10);
+
 		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
-- 
2.48.1

