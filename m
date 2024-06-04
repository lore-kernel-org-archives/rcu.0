Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF514B092;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540107; cv=none; b=NKCs3ehXyea8OO7lAGaJM5hBCUDg+1remJ4ozZ2TvBzq1N/PpAuy+km08jra/e44PWbkPyx9d3NxfXviShYqggc1S/O4QUZdxUy9RoQrXAOj5TdVbPVY9SxRurxRngfGF5UBflhQiSyHQsZ+tp3kKSSKVanGbiEX5SgPi3EX07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540107; c=relaxed/simple;
	bh=JKYIMcssC4nwBM8+/HZJZVbbImM/JBZd6G7JEJefDLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJbD5Do3EwRAYsPhBZXnAOciHZWFBdvAq41p2c1Pse3kxNvVVXwxnty4R6uvf7KS7EsiLERj70hI60UdYNPepqxQsdTKqKUu0PM45EaJ344wZpUI8e1wcEmSP9V00/ABrdN50MdJKD63DT8ze4EKFiLWXmFKd4+unlBIDX3wafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyGmyQy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyGmyQy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F204C4AF07;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540107;
	bh=JKYIMcssC4nwBM8+/HZJZVbbImM/JBZd6G7JEJefDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyGmyQy6m2NU/cTmKq1ElJMKpjHhH5NX74ob/pKuRT4k+AGj0nEDHgGKuoiQQj7Q/
	 eZCwB0p1swrcSDOiTGovyXPIJTW/xrLPqQEzdQZH+W425JsCd0UmObPA7DmNMGYUbo
	 psvDnTYvJfzIe613VsuaFN7V1c/IXruUm3ic7NH1wvZIOk4kCp8hGPsB8Ktoka7TCb
	 2w5T2V37dFzkUk1cH731Pjl+Y7gi2jVKJQJPGOJuJY7xqVGltpYztmqQAQghg165PY
	 Sh5+4FnW7nb4fBGOjLGSHlon2wmOESNS3GUnnmbNYO31wBJeMrP8n5NkdOwJqGEW/X
	 smep1QguCuSNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3478CE3F0F; Tue,  4 Jun 2024 15:28:26 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] rcu/nocb: Fix segcblist state machine stale comments about timers
Date: Tue,  4 Jun 2024 15:28:23 -0700
Message-Id: <20240604222825.2371133-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
References: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The (de-)offloading process used to take care about the NOCB timer when
it depended on the per-rdp NOCB locking. However this isn't the case
anymore for a long while. It can now safely be armed and run during the
(de-)offloading process, which doesn't care about it anymore.

Update the comments accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 1e5b4ef167caa..8018045989af9 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -80,8 +80,7 @@ struct rcu_cblist {
  *  |       SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED       |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
- *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
- *  | allowing nocb_timer to be armed.                                         |
+ *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads.     |
  *  ----------------------------------------------------------------------------
  *                                         |
  *                                         v
@@ -183,8 +182,7 @@ struct rcu_cblist {
  *  |                SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING                    |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
- *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
- *  | Flush pending nocb_timer.                                                |
+ *  | rcuc kthread, while holding nocb_lock.                                   |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
-- 
2.40.1

