Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D647A5E
	for <rcu@vger.kernel.org>; Fri,  8 Dec 2023 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXojr6rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C95C433C7;
	Fri,  8 Dec 2023 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702073161;
	bh=6Rj2/Ew9i8og8UV1rs/YRIIkk8Z14PNfosvKFa7ip4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXojr6rgF4CVtj1/yBPc4JDT25DImi7RK6bjPnZ/E9+OwRt5xlCa7VBBdmwAuZRQk
	 aSMyIc9cocqzJ7LMudOAEPf9o4ryZal2Oa/HV7IOcfmPXz4JSTHA6hflKzWJ/j5U04
	 47RHygrGazdzJEjuHxp0zlfgxtpGTF+qVfmMzN8SY2ZLR55GpJobnvyxwHk7UYALl7
	 4STCMLMjN779SK0D/wWSsCw1K+XE/WQfSuIe67z0e0HnM3EUh57lV7WsdRJ2iUezAj
	 fb1y3eftmg/tb2vDlQw7dP4H+Gb2wIPAd2efJnXF2+n9aW8kKJTT1tmwcbg5O9rDhc
	 iINxxKaf0URqg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 3/8] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Fri,  8 Dec 2023 23:05:40 +0100
Message-ID: <20231208220545.7452-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under CONFIG_RCU_EXP_KTHREAD=y, the nodes initialization for expedited
grace periods is queued to a kworker. However if the allocation of that
kworker failed, the nodes initialization is performed synchronously by
the caller instead.

Now the check for kworker initialization failure relies on the kworker
pointer to be NULL while its value might actually encapsulate an
allocation failure error.

Make sure to handle this case.

Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Cc: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 82f8130d3fe3..055f4817bc70 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4723,6 +4723,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.42.1

