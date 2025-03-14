Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CA202C34;
	Fri, 14 Mar 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963021; cv=none; b=VHtpMbr3HyjnWmCH1zllClda5JgfhnaFnCfwlTh6fQvyP6tdOi0TL7AhIFfShouLBrqv4gqHfUXcCB25nhXkdcu8fn1dUnmOXvUVHaptKahFhBLNQsZI+xaaXl2YbdEFYD5fMXlZ/GPxZYZTidwmP4vrm3Ai7voCkwHWP3Tp3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963021; c=relaxed/simple;
	bh=JA73+M7TZ+VjBe+WGmCS+fPRTyG1hrOlK32h7qOdmBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6srBFGiO2uS6+4Onb/RZpwfIdGOUkCeyu67yMcP5g8h0U9OiTyBkJxLnl/WPOHkSq+6W6YESjf789z+3v0ySmVkUoT6qMWHXqXYRB3whk3MtFwXYEK+VrCuNJthLL+x59Ftl6HOuHxYqSFlSjxUJyJaWwtem1ayA/tcP08lbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9+FVapb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9+FVapb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAC5C4AF09;
	Fri, 14 Mar 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963020;
	bh=JA73+M7TZ+VjBe+WGmCS+fPRTyG1hrOlK32h7qOdmBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9+FVapbWNejlNlU/9D+likKIEzU/gRhun9WJGpIxYVOL4oApNgcIxuzyiejYdCgO
	 QmqzreRIcvLn8tF04rCv1Od++bmxKzTYJZbNfgrrNOFZ/L3sa7KP45oWZxXDZ0W+HQ
	 XX1HoS96oNjBQASM1BCg/pdL4J2e53f9svDX+yMyl2i66DL0ZQkVdwi4o9StS7QZAY
	 gw1ymmCtt96/4QiPL59VcoTf4WptsYJ7xraPriiic4i3xUijFXaG6QBzA81Qsv4wxr
	 ePfmCe+QQeDhM7aabcL2DIZQE4P9wQEVgn9l8pgSB5WgdJ7m2VvCFtaDdPIhQ4dzGq
	 gSw6OSMKTHnXQ==
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
Date: Fri, 14 Mar 2025 15:36:42 +0100
Message-ID: <20250314143642.72554-6-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314143642.72554-1-frederic@kernel.org>
References: <20250314143642.72554-1-frederic@kernel.org>
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

