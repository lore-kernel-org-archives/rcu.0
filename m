Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E92293C77;
	Wed,  9 Jul 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057839; cv=none; b=mDd/9u8vYxXNhwFrN27hoa8gewb7q5i7ifx5maZXAM8pL7wVgbz/YS0PbXlPfWe/P97z1rTDwsnEM4Cn9b9Xa9Gket95TTHHuM69Nimurvsoqs7ryeQY0WqvYGQeDWwK0rGx4ZAmdMVnesth2iWz14OxB81ai9CL7oEOgPuPtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057839; c=relaxed/simple;
	bh=5P4dzPtGQTwTuHcsDkeuA8Wafn1PVojCmEfac+5vgxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Umj3vBiV7+cBFQP3mqSDnoUFslzCRc6Rzg2l6d78bofOjDhdLUl6IpWFoGGVzuYrepT8WyqqO/GONCY0/+dkBYJwKy15gZx1xZwNO1FfIj7IEBURNBnFiZD2bjGm5vieUrNcRvBc18KD7vtWY0IQh3PuM3TM7y5lrNaqfvQGouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnLTN9Cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnLTN9Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88F3C4CEF7;
	Wed,  9 Jul 2025 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057838;
	bh=5P4dzPtGQTwTuHcsDkeuA8Wafn1PVojCmEfac+5vgxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OnLTN9CgM4Sz6ADqscUjLSJIl04PVsg0kvHEc77kCRLVRb72H7UN60pnGSjvxUms/
	 pi9UV3CZrc/qXPawY/9DM0bW6N4J5mZwWJY3xTaGzuFGouNAxufHLeP+ExA8Rc5GFS
	 1XwpitottlwJyeqUQdU6SGJP4nNoNm0AUzqmnkc4ojFbxC5bH64OqaX9SZwqIUeymr
	 PAJcZovWeBeQF4dMukqIu1QyjO54bODF6RLfvPxc9Ff2/GSyo/wUBUesJh7UXuKWi0
	 yPmcTehHhsWoeeUrK2SZF5UysbM+j8qd5wLpk8Z3nVZSyJwLpGJvcE1cKpGJbW/1QA
	 5sgDASx7XfjqQ==
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
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 15/15] rcutorture: Remove support for SRCU-lite
Date: Wed,  9 Jul 2025 16:12:15 +0530
Message-Id: <20250709104215.15562-16-neeraj.upadhyay@kernel.org>
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

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from rcutorture.c

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 include/linux/srcu.h    | 2 +-
 kernel/rcu/rcutorture.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 900b0d5c05f5..c20dacb563e5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -49,7 +49,7 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
 #define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST) // All of the above.
+				SRCU_READ_FLAVOR_FAST) // All of the above.
 #define SRCU_READ_FLAVOR_SLOWGP	(SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 213f23f20a64..7a893d51d02b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -718,11 +718,6 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
-	if (reader_flavor & SRCU_READ_FLAVOR_LITE) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		WARN_ON_ONCE(idx & ~0x1);
-		ret += idx << 2;
-	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		scp = srcu_read_lock_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
@@ -756,8 +751,6 @@ static void srcu_torture_read_unlock(int idx)
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
-	if (reader_flavor & SRCU_READ_FLAVOR_LITE)
-		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
-- 
2.40.1

