Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D261E1A0A;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496976; cv=none; b=sUWlNBrW3ZdWVKA1DwgVQ49cjACEcp6GMngSzISoIi6c6xyWaI1G1Q4IfPlvp3ABtgpxhisdLitxeWz92+R93jeJcI5bQQ1CwEyVSrd8SuhAP/Y4p6l5j6WixM3UcrZ5iKSP/kapl8A2z4XESf/TqkeIK4rflQ2VrqSr9mHPLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496976; c=relaxed/simple;
	bh=YDPwQSF2/texsz3QxQwBxVHxyCv65A5M1YAGUFQYwR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQdlwNfqjBfhBjtWqPmQrkTVTTLQznx5J/4KCjNjYtErtjFiEcSJJvyHUC9dMG0oM06TCEMUlf89Th03Fn5e/WcWRwjEm9IIdUqheDGRrKMv2bkUhASrFsuEohg4tzl0OBtRS2nqkb0E3CeilT91jg2T2gSUjXJh5DsT1mSUKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL4UPmYq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL4UPmYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C16C4CED4;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496976;
	bh=YDPwQSF2/texsz3QxQwBxVHxyCv65A5M1YAGUFQYwR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tL4UPmYq8ykFNpHwuW6EaqTFHfj2slNtqv3fAAxBcFLNpOhXKY/kqKTtXjed1HL85
	 TK8EXgV/EFlCS5HyCeRSGmzHZtU6K64+ueqJb+/U5fp8DSzOU+s8+ll+qPJOVIDX7i
	 tNT0isdMfSvE19+j+Xf4Bem7HA9zDNzdzUcXh+G+AotO1LL6fFuqDBhONADDo3BJKx
	 mD9oip3E/tnEuTAxRrrjEdJtfIqTKViFvuh6KGN4PD16+UdI+YyCG735em0K/bbmp7
	 huzXQMx7IqavmPal6SMBrB5z6vLRtsM6MJOhDyIuHJQYAE5yPH1LJ6FUqZBDjSPZqS
	 IWhNISBNuCjrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCDA4CE0DD1; Wed,  9 Oct 2024 11:02:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] rcuscale: Add guest_os_delay module parameter
Date: Wed,  9 Oct 2024 11:02:52 -0700
Message-Id: <20241009180253.777965-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
References: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a guest_os_delay module parameter that extends warm-up
and cool-down the specified number of seconds before and after the series
of test runs.  This allows the data-collection intervals from any given
rcuscale guest OSes to line up with active periods in the other rcuscale
guest OSes, and also allows the thermal warm-up period required to obtain
consistent results from one test to the next.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index af32331ef645a..be66e5a67ee19 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -76,6 +76,9 @@ MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
 
+// Number of seconds to extend warm-up and cool-down for multiple guest OSes
+torture_param(long, guest_os_delay, 0,
+	      "Number of seconds to extend warm-up/cool-down for multiple guest OSes.");
 // Wait until there are multiple CPUs before starting test.
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
@@ -835,6 +838,18 @@ static void rcu_scale_one_reader(void)
 		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
 }
 
+// Warm up cache, or, if needed run a series of rcu_scale_one_reader()
+// to allow multiple rcuscale guest OSes to collect mutually valid data.
+static void rcu_scale_warm_cool(void)
+{
+	unsigned long jdone = jiffies + (guest_os_delay > 0 ? guest_os_delay * HZ : -1);
+
+	do {
+		rcu_scale_one_reader();
+		cond_resched();
+	} while (time_before(jiffies, jdone));
+}
+
 // Reader kthread.  Repeatedly does empty RCU read-side
 // critical section, minimizing update-side interference.
 static int
@@ -991,6 +1006,7 @@ static int main_func(void *arg)
 		schedule_timeout_uninterruptible(1);
 
 	// Start exp readers up per experiment
+	rcu_scale_warm_cool();
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
 		if (torture_must_stop())
 			goto end;
@@ -1021,6 +1037,7 @@ static int main_func(void *arg)
 
 		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
 	}
+	rcu_scale_warm_cool();
 
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
-- 
2.40.1

