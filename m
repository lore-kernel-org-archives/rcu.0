Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758E127E3A;
	Fri, 16 Aug 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793025; cv=none; b=AMMytqp3H5B8veK4rTdCUuNG0BbPposX4n7lfAmUTpZQTc/yTpCMkiTR0iTPCZKpPHGJo2AKf9ozOVpMQ47iuunAU8KARQEr1LRgGtXK2LS071vZktWUF4skVCKfPCYHILdrzK2/leq8sZscdoYmkHW3lvFJFK1JOVec+R3oxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793025; c=relaxed/simple;
	bh=LqexMic2yVp5BioIIZgMNmhAdgDiQiQtzu/NQNrzTXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwdTQcJhvjgfI/fCGs+vRGb8g+sH483ufpq1P9zjpOEwie61p7l8u0vvjhrpzKYEo7r0JCndyyw0smM4SjNBb7kYbFrfMsDpFqGK8uw1xgaynDrF0edCH+1EPb6YWGDzars8K/HOtt98wcP8ng4SGp1DRWGKWEN6H8vK9qKoWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTyPOf94; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTyPOf94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD1AC32782;
	Fri, 16 Aug 2024 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793025;
	bh=LqexMic2yVp5BioIIZgMNmhAdgDiQiQtzu/NQNrzTXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTyPOf94W0SHmYvgiGUGbXe+2iX/ylJVSx+2Ob2pVzPae5Wpn9w8wIvVzf89/d46O
	 mxOF3MiBViebiiOv43+e+GAB7D0TgrdcagiD0/r5ucx1fsSKiaYVAjEl7bSlNJZjDz
	 IGhwmbWocD1YpRTawHxiBAA5RCH9TrPjfhn7sutOtXNdIDl6t1I7RgteSUeG8YWmU4
	 l3DoBfV/DRNOuJiEYFUtLk+5Zkxtd+VsOWaThQrmwKHPuAm6KM37i98fMiRiJxJxDQ
	 YrLpfd57CIug+FcaRWhnVv0JUVfnZl36J0CO7Dmk4eyvzV9Mk2IboeEobOez9bUloP
	 9mm+XjP0a/81w==
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
Subject: [PATCH rcu 2/3] rcu: Better define "atomic" for list replacement
Date: Fri, 16 Aug 2024 12:52:53 +0530
Message-Id: <20240816072254.65928-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816072210.GA65644@neeraj.linux>
References: <20240816072210.GA65644@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The kernel-doc headers for list_replace_rcu() and hlist_replace_rcu()
claim that the replacement is atomic, which it is, but only for readers.
Avoid confusion by making it clear that the atomic nature of these
functions applies only to readers, not to concurrent updaters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rculist.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 3dc1e58865f7..14dfa6008467 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -191,7 +191,10 @@ static inline void hlist_del_init_rcu(struct hlist_node *n)
  * @old : the element to be replaced
  * @new : the new element to insert
  *
- * The @old entry will be replaced with the @new entry atomically.
+ * The @old entry will be replaced with the @new entry atomically from
+ * the perspective of concurrent readers.  It is the caller's responsibility
+ * to synchronize with concurrent updaters, if any.
+ *
  * Note: @old should not be empty.
  */
 static inline void list_replace_rcu(struct list_head *old,
@@ -519,7 +522,9 @@ static inline void hlist_del_rcu(struct hlist_node *n)
  * @old : the element to be replaced
  * @new : the new element to insert
  *
- * The @old entry will be replaced with the @new entry atomically.
+ * The @old entry will be replaced with the @new entry atomically from
+ * the perspective of concurrent readers.  It is the caller's responsibility
+ * to synchronize with concurrent updaters, if any.
  */
 static inline void hlist_replace_rcu(struct hlist_node *old,
 					struct hlist_node *new)
-- 
2.40.1

