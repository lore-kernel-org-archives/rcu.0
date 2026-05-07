Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695592D29C7;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=Daof/QJu0B/9bGLM0N0w//Om1YQiTJ7llXm8rj/PvcmMA8lWO8AMe15li9M49QZSEJ8FQyiz1PGdBDvu5gh6fhFELWHev+mn919EiQ+5tldpl0k32t16QsG4JmdFqHcktSZ49UQP7y+EPI1DW2PC7IezhuqguBE9gzwsWmLzqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=dn0eKgumMKWPgv8A6Qf9JhTroZyknKKkxSEsAf1Np/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH/BgwKEMPpdjlEEPx2qRaQSX2Zr67nqkDaLpZtzwnNtgo9zTccxubufnpFjYK6njVYx65vR/qvu8zbjLfVoiSB0O7+QfCbhmk9vTAFz9Z8wIk29LJ/G1HPVE1YEO9wOde0aA5GG1qpFKMPv3av4pILPGzhYjbYRCUO4ASM+/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADIo+DZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADIo+DZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3426CC2BCFC;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=dn0eKgumMKWPgv8A6Qf9JhTroZyknKKkxSEsAf1Np/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADIo+DZ4om6z11BUGEMPa3hDQwcvIjknWo9I3MV/lJThyy2pEmG4j0e6x+BeqAltK
	 EvZpdbAnld3eXf0t7Y6PyqYpAhKkfKnvjLBjl3oMJnCt+DjkyUFo6JIyj2kpDY3xip
	 J+qm/r6/bmOHHH0zIjYJ1kRq8l+259P9jA0vcjN24yIFx8pAneaDwhshnVXMHJaaRI
	 YjTgH3NExZp2Rkp+ahXP2bvkEDx9/oqgoSi5RV2Apo/89WAt4IktJHk613APKE8PQ3
	 XkmGu45TSZTVE88T7tttU2WqnPKsKoTBTqa0c95lxaViQThKRSYHFveq4PB9fIQlhz
	 eRFOaoI6/w6wA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B0A3DCE0F12; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/7] rcu: Simplify rcu_do_batch() by applying clamp()
Date: Thu,  7 May 2026 10:09:48 -0700
Message-Id: <20260507170950.2040199-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
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

