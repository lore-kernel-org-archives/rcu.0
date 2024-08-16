Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE268126F0A;
	Fri, 16 Aug 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784263; cv=none; b=P1cT+W7gTAt8YKuUzgwaRyAcq951DnSR7hUVKNIVhr65HNgjdXGednwQ60NP0Vx9xWM92Vhb1Fl1Ywya60/nIgcQCQKNVaYlzaHtX8UzBfx9qyDJLS2/raUokw0g36Rc8hxPVeFywX4Mh4dqkEaFfvMHsQnrGOzhmRYGf8kVcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784263; c=relaxed/simple;
	bh=uH/GSc/lVeBzF1ZPOUrX1qL0YiJxnn9y9Na6+VCpyww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enHneULd6N2W09xRUSeWY8FhAp9EWYRpl2F9XJ9s8eh6ImeTGTt7Awdef9M2Y9tHynp7VxzW52bFr2qG7QWia80vaue3Yr6CwUI1rIYQZ/F1mLr9fC2ZpcSyGrMaiHC2WBd+7JlFPDQKmUsLIddKyskjRKuwQTyi1nczF35g56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Pf/QKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Pf/QKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4187C32782;
	Fri, 16 Aug 2024 04:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784263;
	bh=uH/GSc/lVeBzF1ZPOUrX1qL0YiJxnn9y9Na6+VCpyww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9Pf/QKc0pZ/60zepS0iq10+uXGp666k/Dis0R+WP9uYVnoL/oqwL8jNWCdaLCzW9
	 g2IZi3LoqodRonfXLzPrTWmiQN7BJgyPvePxiG1cKZ5K2cry8rKiMSOne99x/MUAFs
	 s+tDZpaEP7lEinOkbcZET5akQwSTXM36P5+O5dlg9tZveLIt1QVXq5QTALSZu7BjVa
	 imfgCe2sPSpr6CFejF7MGpGMVqSOChynlKFiNJgPnl3++f/Xqvw8arIfqU+YMBhjpL
	 s4C+/XVamO+afeq3tzvGBQ2Vianl+nIB4RM9wqk2V4LeK6J4Y6ggegPO7FYGBDoaCS
	 0FWaxeaZpYhXw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 10/11] rcu/nocb: Remove SEGCBLIST_KTHREAD_CB
Date: Fri, 16 Aug 2024 10:26:07 +0530
Message-Id: <20240816045608.30564-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

This state excerpt from the (de-)offloading state machine was used to
implement an ad-hoc kthread parking of rcuo kthreads. This code has
been removed and therefore the related state can be erased as well.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcu_segcblist.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 5469c54cd778..1ef1bb54853d 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -186,9 +186,8 @@ struct rcu_cblist {
  */
 #define SEGCBLIST_ENABLED	BIT(0)
 #define SEGCBLIST_LOCKING	BIT(1)
-#define SEGCBLIST_KTHREAD_CB	BIT(2)
-#define SEGCBLIST_KTHREAD_GP	BIT(3)
-#define SEGCBLIST_OFFLOADED	BIT(4)
+#define SEGCBLIST_KTHREAD_GP	BIT(2)
+#define SEGCBLIST_OFFLOADED	BIT(3)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
-- 
2.40.1

