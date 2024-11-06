Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B465206970;
	Wed,  6 Nov 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908964; cv=none; b=WjZ/vibkXEHsKxsPz/2976IsxzZIHihy8HI06eljyLcz4sv+vY/3Gi1RaiX+aXMqlaF+ZKu4cDcn1nYxhLtDuhCdgXV1yZp1HeEm2UXPlK+O1MuKYxO0I4Gdl8iQB3LQN1STyLf9XriUWlbAxgZ5E1AeQLbcennOgTKyAeI8s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908964; c=relaxed/simple;
	bh=rhYeUBB/n91//oTPNUiqguVr/Wrp4228mhfdTnKKsC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq0scMs2kLKw3UFybpHQCrQN7SVxBMhSZEakzG9Bqe8unksIuFL8qR3lZg5/fXBK7vplh+7jh5NS1o0F0uprPNx6GHSFRQqPimgwQ/d9t8ICdPK91oCWyVBSVRDR0CRL/KLIzSYeT9I9qgr+3MddLmP5xFjze0HaKWPvG7HEhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPmToyHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPmToyHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74077C4CECD;
	Wed,  6 Nov 2024 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908964;
	bh=rhYeUBB/n91//oTPNUiqguVr/Wrp4228mhfdTnKKsC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPmToyHE8ScyzXvhV1M8DWPs/LIrWMm48yT8CJARVZhLBQ9xF4aYzpxJA426U+WVp
	 gp7+weV/Dp6rbUpU23pgS7pAdMj3aK1IgwEOVVy4a3I61sqvfV/ySpgOV0dLmtaTcw
	 kWmb9NbqI0wO0qmAPfdwIbbrNnrbcol306h65Ml11AXU7CCLx6IbZT98JHZLI66qu1
	 HkRol5XxL1//+rHRBndYaNn2O4Cl2GWt7+tJmSI2s2EMLNjKTMEXbEvekGK8YJbUeT
	 vOMcPjEi8RExwEMdH8lJobX+saqXDJ2OA38ipKk/w0OroXqCr6ULysR573pgvI74Xc
	 lUEggRdYT4Qvg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 5/6] rcuscale: Do a proper cleanup if kfree_scale_init() fails
Date: Wed,  6 Nov 2024 17:02:22 +0100
Message-ID: <20241106160223.42119-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

A static analyzer for C, Smatch, reports and triggers below
warnings:

   kernel/rcu/rcuscale.c:1215 rcu_scale_init()
   warn: inconsistent returns 'global &fullstop_mutex'.

The checker complains about, we do not unlock the "fullstop_mutex"
mutex, in case of hitting below error path:

<snip>
...
    if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
        pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
        WARN_ON_ONCE(1);
        return -1;
        ^^^^^^^^^^
...
<snip>

it happens because "-1" is returned right away instead of
doing a proper unwinding.

Fix it by jumping to "unwind" label instead of returning -1.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/rcu/ZxfTrHuEGtgnOYWp@pc636/T/
Fixes: 084e04fff160 ("rcuscale: Add laziness and kfree tests")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 6d37596deb1f..de7d511e6be4 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -890,13 +890,13 @@ kfree_scale_init(void)
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			goto unwind;
 		}
 	}
 
-- 
2.46.0

