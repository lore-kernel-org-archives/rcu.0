Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A728FFDE;
	Wed,  9 Jul 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058063; cv=none; b=SC1/H8H5NqQXbv+isnPJXlPWsoohti2uaNBlMeYRqTDBPJEGYl98TNjK31okq+eLhJB09NN+81EdKm+ZAoYYnmdwJYBQ609SsIoBbovGH/Oo0WGwaCqOWskIHaR3PVd+zYSGvc80BlItcmJYe8fZiCxtSsgN1m1BCTxn7w+7CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058063; c=relaxed/simple;
	bh=txsajfvA8IdeLAqL2hE7eMFpIZ4tPTLyXFsHmPXdMGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2AO4cTiLL2VbkdNUVw5Z4lr34xfsoiLp/D0J+11frjI4b6k6yQTB/DU2IKLnw8VMGTYeLbrjDy6qRI/E18TL+NtnlQs+CV+jR/ixggW1zo75tW89ewN/BeZFN+d4XnmXFtxF3fRYJRv7SrJTLKeEHKOq7f7FlZVDWOS2A3YmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDegeFoF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDegeFoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2391C4CEEF;
	Wed,  9 Jul 2025 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058063;
	bh=txsajfvA8IdeLAqL2hE7eMFpIZ4tPTLyXFsHmPXdMGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDegeFoFhrHi/XY9o5o3R6x80YBZdJqzEMnjwuDkjySYRaEig4Z3UbMXM4zGd8sag
	 3/oysv/nkhmM7KSdGaSYh+zyQBln5IFR0OXSlzWtJau4UOec4cGPWlzNbd0o+o+AHs
	 g7SCWCsBFSzHaSj4WjOg6uloHEV+tmxxFhykVvCZzPiMteOrZFDNLUz3zeNq9wQ5y1
	 uF0AtfvtzkzTmRErhgs3otzQdd3u/vWSDkOWF+hdnMS26naWhrVs4mfXhcYJhTBlio
	 MbWsrLRbgFEsknr9DOTbxthtCg97ECZFKS8dR+DgoeKy8vg3fTBZHAC+3gbRYvBcxi
	 MYzPkQuURMAKw==
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
	Artem Sadovnikov <a.sadovnikov@ispras.ru>
Subject: [PATCH rcu 1/1] refscale: Check that nreaders and loops multiplication doesn't overflow
Date: Wed,  9 Jul 2025 16:17:12 +0530
Message-Id: <20250709104712.15728-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104712.15728-1-neeraj.upadhyay@kernel.org>
References: <20250709104712.15728-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Sadovnikov <a.sadovnikov@ispras.ru>

The nreaders and loops variables are exposed as module parameters, which,
in certain combinations, can lead to multiplication overflow.

Besides, loops parameter is defined as long, while through the code is
used as int, which can cause truncation on 64-bit kernels and possible
zeroes where they shouldn't appear.

Since code uses result of multiplication as int anyway, it only makes sense
to replace loops with int. Multiplication overflow check is also added
due to possible multiplication between two very big numbers.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/refscale.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778..ab7fcdc94cc0 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -85,7 +85,7 @@ torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 // Number of typesafe_lookup structures, that is, the degree of concurrency.
 torture_param(long, lookup_instances, 0, "Number of typesafe_lookup structures.");
 // Number of loops per experiment, all readers execute operations concurrently.
-torture_param(long, loops, 10000, "Number of loops per experiment.");
+torture_param(int, loops, 10000, "Number of loops per experiment.");
 // Number of readers, with -1 defaulting to about 75% of the CPUs.
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
@@ -1140,7 +1140,7 @@ static void
 ref_scale_print_module_parms(const struct ref_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
+		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%d nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
 		 verbose, verbose_batched, shutdown, holdoff, lookup_instances, loops, nreaders, nruns, readdelay);
 }
 
@@ -1238,12 +1238,16 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
-	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+	if (WARN_ONCE(loops <= 0, "%s: loops = %d, adjusted to 1\n", __func__, loops))
 		loops = 1;
 	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
 		nreaders = 1;
 	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
 		nruns = 1;
+	if (WARN_ONCE(loops > INT_MAX / nreaders,
+		      "%s: nreaders * loops will overflow, adjusted loops to %d",
+		      __func__, INT_MAX / nreaders))
+		loops = INT_MAX / nreaders;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-- 
2.40.1

