Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97E7081A;
	Fri, 31 Jul 2026 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459120; cv=none; b=oYMLRZCowixDG/im5L6/vzEeRfs2UGkhUWrXHgUvhQNrKzGaYrt1FCe9Q1cB61CgFjqZOcxPC4GyPOioMoMS48vJWhB98a7hnq1qvvaoft8tse2/ag4ysacjai04Y5KTX0bw0MDZ4ZCLl9FFUan3PY7l/MoLkNQAsKC2ABifwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459120; c=relaxed/simple;
	bh=dnbDTzZr+3li+Hteo32eo2C0UBLA06db9rCm9aX9A+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8gxw3CafW87tvdC45b77M91yOdQ76y8OMeA1n5wKTMrcC8dlLJL5Z67rbViYL/iJyhGelGuu/h0qdgU+TgMAnXJkEob8Lwtd/mrf8nBkB012YJgXemzfbW1hTXYcRFvnk7/f3iB/RqYH0zQJvU7dTC2u9jfpoeO1J8+fLZRRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuJytdI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuJytdI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB951F000E9;
	Fri, 31 Jul 2026 00:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459119;
	bh=lW3pfCijzuBvvuTq3n5s3iLnB4z0QLXT2qZhp51f4LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuJytdI2KvUPEkSK0+EuoHf+0FAl4Bsj29khG5eUEeJLs6gJDJhi/IJ1ryp+Ya+4Q
	 eVcFdkhZtv5p8zoB5P58t1qPpJA+mdNXfyvdMDkXr8k9Uq3M4/92Cm1//XHwb+7kQp
	 COPn5QU/r9W7PTRnwFXVxbNiHI9+VN9ZFLOMqdPP9guASds1yQvjixa+cZEGElDSqY
	 7RM3m5KRKkOpUFvct4yxu8PbOP1HsRyf3TyjxlHpiQNjtENVSXpxyErm72GcKcebkr
	 zhwlF+EuZCM86IN9vE3RyC/aqpgSjAL3XVv938ct2nxOCCTngimXhNByIVCu3a4TnK
	 N1Lw7QHUgYlkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48AB8CE0F69; Thu, 30 Jul 2026 17:51:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 1/2] scftorture: Count single_rpc offline failures in statistics output
Date: Thu, 30 Jul 2026 17:51:57 -0700
Message-Id: <20260731005158.3530675-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d470e612-b88a-4916-a1b9-1a6e8e6f968b@paulmck-laptop>
References: <d470e612-b88a-4916-a1b9-1a6e8e6f968b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

scf_torture_stats_print() aggregates each invoker thread's counters
into a local scf_statistics structure before printing, but the
n_single_rpc_ofl field is missing from the aggregation loop.  As a
result, the "single_rpc_ofl" value printed in the statistics line is
always zero, even when smp_call_function_single() invocations for the
RPC test have failed due to offline CPUs and been counted by the
invoker threads.

Add the missing accumulation so that the printed value reflects the
actual counts.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 327c315f411cc2..ffd6c83732ee74 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -193,6 +193,7 @@ static void scf_torture_stats_print(void)
 		scfs.n_single += scf_stats_p[i].n_single;
 		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
 		scfs.n_single_rpc += scf_stats_p[i].n_single_rpc;
+		scfs.n_single_rpc_ofl += scf_stats_p[i].n_single_rpc_ofl;
 		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
 		scfs.n_single_wait_ofl += scf_stats_p[i].n_single_wait_ofl;
 		scfs.n_many += scf_stats_p[i].n_many;
-- 
2.40.1

