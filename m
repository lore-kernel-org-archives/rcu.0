Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BB1F76C4;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=eNxgkuW1uB+q3GiDnXN6hSjvLTf0WUTGfR5FuVqcE37yHjOgCwfgQxFW9w6x7d5hNN4aL6VCO6yQxY5C4I9yah6CtNzgVmsi2alubD+KWnF3fRB5ssxyn6YUicF/d6zIalP2PcZOH3FoT6CKs4vz8KvnxThI2gh0FleM0h1FPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=lRHusLBwQ9jaA1f95XVTfeSH3venFIrcNJmEhKbZEYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxGhfFT0COLOD/YI+95piPmR9I93srkg9BJGrBGylgyVlaqtXmCTVPSUNcrL0O0Ezo8dAYiCdCdRIKsgqjwf099ZsGE6CdBjmt4yAu6ZB8ol9LllL/ONbj64PTPdyEzBj9OIlhctE3tAoy+IGcPCQE0/gimgDmm01WmqvLojzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM9ZN+DD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM9ZN+DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DCDC4CED6;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=lRHusLBwQ9jaA1f95XVTfeSH3venFIrcNJmEhKbZEYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM9ZN+DD25G0DydGoVq9zu4brJs3JId72UOn3lOcOpg51/XD1DPm2dioYoLN4qdSM
	 uDAk5+L7X3Ine1KLa/d+zs3HnOTeLzrJQsougq5niRR5y2VfJa+v0m8ySPY67JecNs
	 FQquRCKdgiWlPp9XPy1MwAMEoru8IyWHOUA2acmaOWEoeEy8Pnbmjska6h9JPRGa+V
	 qOjoW33u/KwbtNvDSlvh/pTRYI1gk678srFU2KuUZcWwPbWB2R24+Uc8IkraxQPGZh
	 glWpOOS6GV//xM7b2SpMTu56krMa0lMTmyaDhYD3DkONmxZvnEFaP6v5EkFG+osFai
	 wYw0N76bLbbLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1510CE1038; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH rcu 06/15] srcu: Improve srcu_read_lock{,_nmisafe}() comments
Date: Tue, 15 Oct 2024 09:11:03 -0700
Message-Id: <20241015161112.442758-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds some additional usage constraints to the kernel-doc
headers of srcu_read_lock() and srcu_read_lock_nmi_safe().

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 06728ef6f32a4..46fd06b212baa 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -235,10 +235,13 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * Note that srcu_read_lock() and the matching srcu_read_unlock() must
- * occur in the same context, for example, it is illegal to invoke
- * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
- * was invoked in process context.
+ * The return value from srcu_read_lock() must be passed unaltered
+ * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
+ * the matching srcu_read_unlock() must occur in the same context, for
+ * example, it is illegal to invoke srcu_read_unlock() in an irq handler
+ * if the matching srcu_read_lock() was invoked in process context.  Or,
+ * for that matter to invoke srcu_read_unlock() from one task and the
+ * matching srcu_read_lock() from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
@@ -256,6 +259,10 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  *
  * Enter an SRCU read-side critical section, but in an NMI-safe manner.
  * See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.
  */
 static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
 {
-- 
2.40.1

