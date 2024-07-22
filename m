Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA714F90;
	Mon, 22 Jul 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655470; cv=none; b=kGmrEsM98tSMpyx+OCoA8JNvhmir3bNnidoFvKbx+bpAcIaHE40qKU2OEyxKhYGgaEyOfFSU4uwbJjmAEN+8WNBmYU40KM//u+W4o2OHjRAnLZPls70zMSE4bxhZAj6Avrng3AdJ+OmFcps9iGoTtbfK3RqZUsuxOlTnnuIUQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655470; c=relaxed/simple;
	bh=7DrJdi6I7WnokKKbDig2nnyz9y9HWc/n0Upi7h4kk28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpMqnSf+zoG478A55GAXl+/yjk/bQbB50a8ka9H7GEt3JQCYEUxduLrmumpPSss7gW+3RyyvJYicHae98iV/kjVKC7Xq1sGbK1zBjqk0WdZsZfXJD/70qK2udQaDEy+jQijX7lwX/APpWKC5gFBBsTQgfD1U2r9yLknaEU9Sxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrexS/VK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrexS/VK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43388C116B1;
	Mon, 22 Jul 2024 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655470;
	bh=7DrJdi6I7WnokKKbDig2nnyz9y9HWc/n0Upi7h4kk28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrexS/VKKxlzgQu+8AncMOOnBRRQscnpqEDg8tZaTUD//0+nMHuTizOCU9+n3pefJ
	 jQ6iCX4aMVzsbXLWzAMOQfMyuqmCzkfqXgYtH5bR3vNF0R43ClZ+zgQvBlGPl0DnS/
	 ttUh/VAqZ/TOmLdXls1zmFD2fnf4GogMcDl6kTQMJogIuKb/LzRtJ2DKjpvD8HSY2I
	 zNFBION6ncdUMSVNFAItE38vEs/5UU2CSgrFNhv9QsfbefqC5q1TS5KFjIXOz/ippC
	 GqocCkm00BIFffsHlEHu+TbNvAnovS3Dw504+wt5dLoDNADG8EG1HLNd3rsz6WxOce
	 q9zzWrpBLbL1w==
From: neeraj.upadhyay@kernel.org
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	neeraj.upadhyay@kernel.org,
	tglx@linutronix.de
Subject: [PATCH v2 1/3] locking/csd_lock: Print large numbers as negatives
Date: Mon, 22 Jul 2024 19:07:33 +0530
Message-Id: <20240722133735.667161-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722133559.GA667117@neeraj.linux>
References: <20240722133559.GA667117@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The CSD-lock-hold diagnostics from CONFIG_CSD_LOCK_WAIT_DEBUG are
printed in nanoseconds as unsigned long longs, which is a bit obtuse for
human readers when timing bugs result in negative CSD-lock hold times.
Yes, there are some people to whom it is immediately obvious that
18446744073709551615 is really -1, but for the rest of us...

Therefore, print these numbers as signed long longs, making the negative
hold times immediately apparent.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..81f7083a53e2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -248,8 +248,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
 	/* How long since this CSD lock was stuck. */
 	ts_delta = ts2 - ts0;
-	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
-		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
+	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
+		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
 	/*
 	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
-- 
2.40.1

