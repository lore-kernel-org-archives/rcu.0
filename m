Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A980BFF;
	Fri, 16 Aug 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791028; cv=none; b=ge+liJvu9nqgn6YzuDLX0srK6yiwB4+WtOBoe8ox2Fim/iyqGm6O9GMFiH7QoZal4VfSZbe6YR7izfvP34e0R++VjvzJqXaCAiFCDTrIc4xMXSgBjnrkpu+7l9DZQ1v9i7wKPiRtEv1F2Gujf1kGVUbzsjrYF/EVQT2QBq7mqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791028; c=relaxed/simple;
	bh=yM39PubOSo+Kk7oYwByRSf3L9oA2uYH1PGJ91ZPWzFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VF7DJKdpCzozPzDtK3nSlmhgMMtTT/sRShLeTMogWt5zm93Fjm5QbX3w8nJ0KD6eMcP7Ufrd76oBiy43W5slENeyYOT7k1xIbJS/UCJFAH90cR8n1o43Zh5C43fQlV3DwA0h+ku/nxrfepS1ymO1GZXQ78RDXcYg9C2DiFbYyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d86oQ4jU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d86oQ4jU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE54C4AF10;
	Fri, 16 Aug 2024 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791028;
	bh=yM39PubOSo+Kk7oYwByRSf3L9oA2uYH1PGJ91ZPWzFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d86oQ4jU4nQqMrpRibi267xjgrPxr5ufty8EfuUXe68kDzrjMFIi3g6f5K6r2OcNd
	 H8rI8qjJZGNOQVEslSsZ+I2UQmxm1/nTGpsNhownVaQIp8bTFuBtdxfzKAkWiIXUX4
	 6SskE8wi0V+8/hqhXlAfzCaWH19dT5SnrjTr76ttZeTvo5EMzr8C4AQntsxiLiclfP
	 PQjyQ3uV3RdL/k3hu98XxWgpwxAvG0kjd73GeBTVah/FQ79yJG1SCzHAy88ME5a9t6
	 cG5ZIC+zqxGdsd4cXbGrjvZkdu91/ujojJMK0HmuCo1Jf1mN0FiG04vb4pdbi5jXdY
	 LHNiqYDDt5jdQ==
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
Subject: [PATCH rcu 01/12] tools/rcu: Remove RCU Tasks Rude asynchronous APIs from rcu-updaters.sh
Date: Fri, 16 Aug 2024 12:19:10 +0530
Message-Id: <20240816064921.57645-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The call_rcu_tasks_rude() and rcu_barrier_tasks_rude() APIs are no longer.
This commit therefore removes them from the rcu-updaters.sh script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 tools/rcu/rcu-updaters.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
index 4ef1397927bb..8a5df3f22550 100755
--- a/tools/rcu/rcu-updaters.sh
+++ b/tools/rcu/rcu-updaters.sh
@@ -21,12 +21,10 @@ fi
 bpftrace -e 'kprobe:kvfree_call_rcu,
 	     kprobe:call_rcu,
 	     kprobe:call_rcu_tasks,
-	     kprobe:call_rcu_tasks_rude,
 	     kprobe:call_rcu_tasks_trace,
 	     kprobe:call_srcu,
 	     kprobe:rcu_barrier,
 	     kprobe:rcu_barrier_tasks,
-	     kprobe:rcu_barrier_tasks_rude,
 	     kprobe:rcu_barrier_tasks_trace,
 	     kprobe:srcu_barrier,
 	     kprobe:synchronize_rcu,
-- 
2.40.1

