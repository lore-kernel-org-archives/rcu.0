Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A401C9B81;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=ASMOgbtSoDSqzZEkBs8nPaAhnt1DI+q5jFr3NYvkdUaHgX2i5eJrOxZNuf1YU8Bhls0y3b/UBjZ4btbRRp2fGDk9cIVEN2r7VEAs0R/2Tdw8sDo4b/TyrIbWwwK+JJtoAY3OEWWJCQMsUiIE+G0V4dMDV7WOgN3ocBLawRNYatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=VNnp30uwfjWqvy4NVapgi+LtAjMkx2x6Xh+V0F6TxJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1xRhGuIcgh966WoucX0ZuIksybc6ju3zxRVlOnS+qw9IdpRlPZ5qvKiHf9Bk5hpZF0Bc+4dJVtAAhenn6LwOKI1qk0pzr0awyQzrDCoky7wCKO8QUJ+NMhdhjw9UDIN+fS0HI0t91W9XnDfP+dwF4Txq2CeGfdL3jBIPMDzJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJDthcDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJDthcDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7552BC4CEE9;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=VNnp30uwfjWqvy4NVapgi+LtAjMkx2x6Xh+V0F6TxJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJDthcDVPT+fOdB96517oOtcGm0m3SXUyyyWEK2FgWFZ8xjiGJthcTa39kt9LGO8M
	 PE+/v8ddA1+4Q6452OBCFcbS9SzxKN0UD5TaNF+Vy9JRFSdYlOxQGhIbVL66kWVP/E
	 mV99ayR/nKSFjbdiBvpbPbS/jek1OgZyIfMK3hte6axmB6ouN2HKnwjx8aEQq4weo7
	 sqYkJvKkkN5xHtfaOEfm2IDIX7vsJvUfrPu3wRZabIyMNJhl/EDsmJHesuxFQsj7tB
	 4BPBSReKsUbjEKOPmvAI8LxHjooCOTgmBCffS/jR0je7iohCqid5Ay6pTrKlDN1CF8
	 8SpwPYInwxGNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BADCFCE0FEF; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 rcu 13/13] srcu: Improve srcu_read_lock_lite() kernel-doc comment
Date: Fri, 11 Oct 2024 10:39:31 -0700
Message-Id: <20241011173931.2050422-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Where RCU is watching is where it is OK to invoke rcu_read_lock().

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 4ba96e2cfa405..bab1dae3f69e6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -270,7 +270,8 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  * synchronize_rcu_expedited(), IPIs and all.
  *
  * Note that srcu_read_lock_lite() can be invoked only from those contexts
- * where RCU is watching.  Otherwise, lockdep will complain.
+ * where RCU is watching, that is, from contexts where it would be legal
+ * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
  */
 static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
 {
-- 
2.40.1

