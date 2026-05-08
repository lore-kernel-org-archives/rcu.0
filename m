Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C32413227;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262237; cv=none; b=P70KgdrVdmTEvrSTIoqKPuBv5Rsy+o+YSyDx9Y14HufIROcZbChA+GCvHj88/WI6Udy1pCnquvF+ae/jXavEH9z+Jrgy/YJzaBtpyil/oUwekojdouphNOlfLl/v9uJB2E7UquCXlpURgvQBu3PmpYxkStEGBmxMCDimwI5VDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262237; c=relaxed/simple;
	bh=dn0eKgumMKWPgv8A6Qf9JhTroZyknKKkxSEsAf1Np/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtW8rpu3lP/iQuFKXH+J0VOY9IK4RQnN+hOuATJtsmYTrqQqqnwqPqkxzMrMc8gbGDbl1XGiCJ3QHIiVfI0o9jFef2cZLXjtjlAB1RhkraoP4+Begkltbm019L9AAMjSbRZhyuWykzvmcsMbZhdeZ4r/awqYDRIuCRI2ZWuYBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuEHUUOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuEHUUOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6FFC2BCFC;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262236;
	bh=dn0eKgumMKWPgv8A6Qf9JhTroZyknKKkxSEsAf1Np/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuEHUUOTbxXVyny+lmkazWLIY1UIPqCOlqgZK7Buvekb43oaPpvh3QUksmuaeIgB7
	 +VEM8DmgnolCnpVOgWySzw/T0hL0hRjyJ4fD6Xu6UPWkkR7nHj8UkNnDFipbtlOMBV
	 j+7QoQq5l9cFzqPfLt+5XBFDGfml/2HBY9XzT8Q+BeMFtJpRUc8HoS9MhFjoLc/q1r
	 OnsAXcES/yzrxaAvTutYwLhCbvRlz5qWk7aKY9WDn9Y8KJ8NmbiTp0rtr8CJPz0ayh
	 03wSmyatuGkqpgdbKHgCoMj6jLRASlXZEeQolcyoCOpJtIxmiZIb6QRXq4/vXsZrRE
	 jKdwoWwpxzNaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43569CE0B15; Fri,  8 May 2026 10:43:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 4/6] rcu: Simplify rcu_do_batch() by applying clamp()
Date: Fri,  8 May 2026 10:43:51 -0700
Message-Id: <20260508174353.905746-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
References: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces a nested ?: sequence with clamp().  This does not
reduce the number of lines of code, but it does simplify the line that
it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e87..e46a5124c3eb88 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2584,7 +2584,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		const long npj = NSEC_PER_SEC / HZ;
 		long rrn = READ_ONCE(rcu_resched_ns);
 
-		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		rrn = clamp(rrn, NSEC_PER_MSEC, NSEC_PER_SEC);
 		tlimit = local_clock() + rrn;
 		jlimit = jiffies + (rrn + npj + 1) / npj;
 		jlimit_check = true;
-- 
2.40.1

