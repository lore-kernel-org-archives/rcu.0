Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC379292B5B;
	Wed,  9 Jul 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057818; cv=none; b=YXXIr81t+Gvl6jhnEyuDd1oxeO3w51O0rDutd7H08Iptq5HG+b61y93GOa/MqG04qyrSSleHJP63pxwGfbdbtgWAlMkjNaFh4MqxmM9A4X2lHSHrU3n3Tq/2jq3UooZLkPYdlPJIx/+iYfhg8nAsxD4RI2q4Mvf8vNYiIdMC/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057818; c=relaxed/simple;
	bh=ulnbOGonGD9IkLvyvRlXLea+xunQWmohmBwivmEFGMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5BDKO3JHk4YrpKkX40T8AiW7QUnymDTnxtRoDAdqtcLxqdSrjPivUm3qV+UC1h83q1DcMGGfc/GeLSkbwl8NVz0772VMIyuU2PKDqMyFyr944xCzhaQa1kfbT4t32NYbCxQg60ory7QenP/VE37/V/jnhZEFnqr5EmW6WnbC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3lb/5Zw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3lb/5Zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2576C4CEEF;
	Wed,  9 Jul 2025 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057816;
	bh=ulnbOGonGD9IkLvyvRlXLea+xunQWmohmBwivmEFGMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3lb/5ZwadzoC4Lm/KVEHjZZlu73QLMU6XPjctOWV7fb8Y1UWrLOdc2/5TIwm7swY
	 GkaMkeWrOQugkJ2/HAWBrJFXmem+Umcdg+WE1c3TxzlSgtJLdXT2eZKHOqWXqRgQn/
	 V0i4WaKfgp+J7FHe0rDI/OWjOP4eLRglo6JPrgQj2pB7qFQ83nd4wia/k9OPfG1Nh6
	 2vLL3e2DECruyds5OCDKOTdy+NOp332ssUtT+xoNY7zH44fAp/dMIRpPRHQUMIpquq
	 PWZhU+vVY8El/C7h8/tB0AOJEfIm9skF8Q2APPMZKIyasPxCOPjtUv3QmVWbDAiWcQ
	 fRIbqd4yp7kUw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 11/15] rcutorture: Make Trivial RCU ignore onoff_interval and shuffle_interval
Date: Wed,  9 Jul 2025 16:12:11 +0530
Message-Id: <20250709104215.15562-12-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Trivial RCU is a textbook implementation that is not used in the
Linux kernel, but tested to keep textbooks (and presentations) honest.
It is so trivial that it cannot deal with either CPU hotplug or external
migration from one CPU to another.  This commit therefore splats whenever
onoff_interval or shuffle_interval are non-zero, and then sets them to
zero in order to avoid false-positive failures.

Those wishing to set these module parameters in order to force failures
in Trivial RCU are free to revert this commit.  Just don't expect me to
be sympathetic to any resulting bug reports!

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505131651.af6e81d7-lkp@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 470b5a117602..7a07b2590c27 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -969,7 +969,8 @@ static struct rcu_torture_ops busted_srcud_ops = {
 
 /*
  * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
- * This implementation does not necessarily work well with CPU hotplug.
+ * This implementation does not work well with CPU hotplug nor
+ * with rcutorture's shuffling.
  */
 
 static void synchronize_rcu_trivial(void)
@@ -982,6 +983,16 @@ static void synchronize_rcu_trivial(void)
 	}
 }
 
+static void rcu_sync_torture_init_trivial(void)
+{
+	rcu_sync_torture_init();
+	// if (onoff_interval || shuffle_interval) {
+	if (WARN_ONCE(onoff_interval || shuffle_interval, "%s: Non-zero onoff_interval (%d) or shuffle_interval (%d) breaks trivial RCU, resetting to zero", __func__, onoff_interval, shuffle_interval)) {
+		onoff_interval = 0;
+		shuffle_interval = 0;
+	}
+}
+
 static int rcu_torture_read_lock_trivial(void)
 {
 	preempt_disable();
@@ -995,7 +1006,7 @@ static void rcu_torture_read_unlock_trivial(int idx)
 
 static struct rcu_torture_ops trivial_ops = {
 	.ttype		= RCU_TRIVIAL_FLAVOR,
-	.init		= rcu_sync_torture_init,
+	.init		= rcu_sync_torture_init_trivial,
 	.readlock	= rcu_torture_read_lock_trivial,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock_trivial,
-- 
2.40.1

