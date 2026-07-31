Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27E2D3EEB;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459845; cv=none; b=s/OCOER51bGuZ8FovDDN/gIWJFK82efrk+S7bxA9a6eFNi81igRk/V5YP2R5bzoWYY01feDnJyRAVtheZk4yxjo0J42LnyuLa2yjYeWuIONY/wIEWUp78lC2xdUX3311Z1a/3DVFash3Vq8DsDJs2rZIMp/TiOdnrDDXpCsH/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459845; c=relaxed/simple;
	bh=4jgfWSLikRl+xWI4uR47lD18fbt/PJOvWfRxbxP4RVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGLWiB5NBF+InBJ3RA9pK9JE6vCqNde4bRQn7levovLeX5ToVL9StqqBiiCWjNTdU+bTzCjS88XoLR5iZVZ+b7Z/T84Y60MaT7Y8c+NbW+pitre0pnvO3Nu74A94UHpQRDoT78oj4D5/N3ddshcROFCNBwySRKfuafLTfv2FLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFguWGzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFguWGzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C01F00A3F;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459843;
	bh=+mEC86hot4V+7/tf7mFraSyiFAtQI54l1HezUFxzJGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFguWGzHfDPA41c/K6OUK7sOho66agW+sNx8W9EuPDZu1atX9Z5B6uQYzkTvI+lXc
	 e3+/njLaaFJ5gydd8BlVol7xVLyVZZXD5Nlby8MlvzvVe3B7GKW7HhJ52vRxppuxMJ
	 N/QKLaPakpsA/bQDrTo3SKwAEYwE8xSOwQG++ZbCu9ojeEwlCV0IJzPjMx+5LQ1wAp
	 xRiaVqhQSVzkhrGvJO0QDSNt9TbXBC99NtSrGJZaXZYSU7lRkMZeyhlgL+nT25v+ss
	 Eh5jAaFiYWSdq9Mrya6J0aZE+kEKaMSOPIiVC7jQKLAPAKUakWqDFursAjW7Mzar7D
	 LJCzyZhcy4kUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 923BECE0F82; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 04/10] rcu-tasks: Apply READ_ONCE() and WRITE_ONCE() to fix data race
Date: Thu, 30 Jul 2026 18:03:55 -0700
Message-Id: <20260731010401.3531631-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that rcutorture tests readers from interrupt handlers, KCSAN spotted
an additional data race.  This commit therefore fixes it by applying
READ_ONCE() and WRITE_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index cee89e51e45cbb..fd3ddeb6aa3bd2 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -95,10 +95,13 @@ static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
  */
 static inline void rcu_read_lock_trace(void)
 {
+	int n;
 	struct task_struct *t = current;
 
 	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
-	if (t->trc_reader_nesting++) {
+	n = READ_ONCE(t->trc_reader_nesting);
+	WRITE_ONCE(t->trc_reader_nesting, n + 1);
+	if (n) {
 		// In case we interrupted a Tasks Trace RCU reader.
 		return;
 	}
@@ -119,12 +122,15 @@ static inline void rcu_read_lock_trace(void)
  */
 static inline void rcu_read_unlock_trace(void)
 {
+	int n;
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
 	scp = t->trc_reader_scp;
 	barrier();  // scp before nesting to protect against interrupt handler.
-	if (!--t->trc_reader_nesting) {
+	n = READ_ONCE(t->trc_reader_nesting) - 1;
+	WRITE_ONCE(t->trc_reader_nesting, n);
+	if (!n) {
 		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
 			smp_mb(); // Placeholder for more selective ordering
 		__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
-- 
2.40.1

