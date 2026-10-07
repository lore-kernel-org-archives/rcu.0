Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E9412280;
	Wed,  7 Oct 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405916; cv=none; b=p7dtsznI1hKTyZM7MKAIS+o3O006j8NpV3gFC6MKL/C5RcxlbmSTBszgyG8ptcJ50UlVgZHD+wP043+l5dcy7W8LSnMr06p8x4kVFbXB+tyzrs9nWX5PFEF5dvfy7Q7M8UBhCQu2jmtCK1t0UMgV6tYbasWBt6OwbJzq7pV4Mvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405916; c=relaxed/simple;
	bh=uzUJcf0hYPNykEGH5zgVhq+5MOYg3irM+0yy8hgUlLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wi5jz3YbNh+1cTfHF6IGkIpoG5QFziHsSn1MoT+k0QCSG34yt4OunTHLW/GJaG/JrNH64qxG3Uy4S+/95UX1fqgvWQozHilFTdX1r6bsTeR3ejT4UxDdcwu6jXvDZqxfsA3JI0OHRAocOQS/C3p0WPmNzkLf3dl++b3lKz1JyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoscqwKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoscqwKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65271F0089F;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=0/dxJ+HarJYJSuRWltTNOsiamzeZDByX0MaQ1zCI9+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoscqwKKjxHhfoOMduAm49N8NE6GoPVsB5Ofrk+Z9/fVNiaA2snBSh5hUjRrj+Fva
	 jCa/17Lplyfup45rOKicCNeOF0EGd0Y/VHtg7ES7GtrQ6dyD4bR17L3BNHeqWaxD0b
	 EZPpCSurdzyzxkIdte+GWojd/jvMu2vMHQetFCmPic1iV17v7kqMqrUr1T885QwaVf
	 msxcQgW4PtRN7IyPHa6q+NQntIG50hOaWs1eUN0oVdQOxn/y246sGhLtotWb2mootz
	 KzT0PlQMxFD3FVnWixZtK5/PF00cRN3DmgoIifCAbdezqB1Hg4OCQcP7t1SZx6StI7
	 w0fC/9BKNPlXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3611ECE2742; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 08/10] rcuref: Fix the rcuread_is_dead reference in rcuref_read() kernel-doc
Date: Wed,  7 Oct 2026 13:45:09 -0700
Message-Id: <20261007204511.1982646-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

The kernel-doc comment of rcuref_read() refers to rcuread_is_dead, which
does not exist. The name is rcuref_is_dead. Say rcuref_is_dead.

Fixes: 3efa66ce6ee1 ("rcuref: Provide rcuref_is_dead()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcuref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 2fb2af6d98249..01fee161b67c3 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -34,7 +34,7 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
  * indicate that it is safe to schedule the object, protected by this reference
  * counter, for deconstruction.
  * If you want to know if the reference counter has been marked DEAD (as
- * signaled by rcuref_put()) please use rcuread_is_dead().
+ * signaled by rcuref_put()) please use rcuref_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
-- 
2.40.1

