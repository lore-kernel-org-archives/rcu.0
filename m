Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E7207A32;
	Sun, 29 Jun 2025 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751238760; cv=none; b=QHGE2rmnpSVddfvbkjFQkLqXeKMYN7wWD8u49vp2MwbhSSh0Vy6sHpy4kmxbROOHBKNl41kLwbQrQAe6qMUWhiGSNqp3aeYUCfsraY7BXapDfZw5JEbsPWJKdOHU3Vs9uowO/saN3nNyf5Sjc6T6SiuUwfC3XvnAbT83vNK3nE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751238760; c=relaxed/simple;
	bh=MM8+F9NfQiipMoco2vrexssEB7cU5Cx6BfqreOJThFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/dS2eAWDyndGHhH7dgUJhIWjDxfB6pOJ0C1Iq4Vyz5yk/4kEoXjKY73b8Mivhd8vMGshxQNqDJEh8Xfa+7dXDNYaFXV5nl+3D4JpHoxaePjHyP4Ptf594UrdmtNUKYrTjOs7vfBkSUBt5HgTdUAVeNlNJe5f8V6WeGGMyz6d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GRjXIBEd; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GRjXIBEd"
Received: from localhost.localdomain (unknown [178.69.224.101])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8FD3A552F52B;
	Sun, 29 Jun 2025 23:12:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8FD3A552F52B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751238753;
	bh=CMWpdSXt+aQMl4gzAQ7WlEY+ZVcaSuxy8ltfzBBbdzw=;
	h=From:To:Cc:Subject:Date:From;
	b=GRjXIBEdgS0kOVv52MlLplQ3rDfOPqtxxJfXqvGLA1W1HSrcvGd/i6mvxiNn5qxXL
	 Wed/dg9TKdN1N1QM1ixz/4L8eQy97J+rM5E1gcWTskAcVsxeim6EhtZjkjTTO7R2jV
	 DMx5BjdOypZOUDi1abnS7ecV5vHQCMVcPN9tLwXA=
From: Artem Sadovnikov <a.sadovnikov@ispras.ru>
To: rcu@vger.kernel.org
Cc: Artem Sadovnikov <a.sadovnikov@ispras.ru>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] refscale: Check that nreaders and loops multiplication doesn't overflow
Date: Sun, 29 Jun 2025 23:12:12 +0000
Message-ID: <20250629231212.1573-1-a.sadovnikov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.0

