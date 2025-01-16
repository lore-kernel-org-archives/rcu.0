Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB812242260;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058876; cv=none; b=RYCiRZ3AGMc9hDpN5iy/p1nmje7B262pLXXKZis8E0le5mjxfkfG9fXuhexDUXYpZ2BynGrXC5PCvIA5jtUWf/vUOr1fIUdszWBeYV388WB9wV/W6rTQDfZNHWIfb0nOAUOG/P6y4iDv8Xpc3o/9sVwPmeQsEchcv+TWsKsLrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058876; c=relaxed/simple;
	bh=w3taDxcgoawy8Sb/5sWcw2jn2Y53b7dx6nnqS+Qds70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1jCcqnZddJAJmKQ2ZGzODhYsLMbLi6kltYGNbyGaY7XpA0owDgfO/SzHNZDCXEKWETe55MAFeR7HyvnMTXXXstRpS1ISocJnPYqH/Axakdqlmwlmc51vEjq2vI1oaO8RMGXw2UTd9dRcCYHHfQ6vyia0uixJn91egSyzlm6smE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRY+pU4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRY+pU4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92890C4AF1A;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=w3taDxcgoawy8Sb/5sWcw2jn2Y53b7dx6nnqS+Qds70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRY+pU4tTM6NK/rYEEBV1KPNrF7Xv2E6MkfuvU2xq5696jUIhHejUKZqe5mk1bUi5
	 ltagFneYPKrZJwOUobcPuE/Ym7f9IZJyJdMzd5ISuipDNRfiZHOt5uTwE5a/mBpRrN
	 MIVQ58A18C2QMOXH1dbQKrM+TZVqTzldXq77zzxmkxhPcnlw/NCtA8ILiYQb9iw0+R
	 CV2RrWauB8vFOcBB4EFeUxiwKtmdC77T1F6/u9coOANzDlLqiK7Xy+E1yORQ8ziTEk
	 hlQRwlOdjeUML7QtJAIUbiafGTVJ9ACFhJuEuyN5HfE+qItMdtlpbIM+HUJ89vz3Rm
	 s5PpMIlLL4QrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA19DCE37DF; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/17] srcu: Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc
Date: Thu, 16 Jan 2025 12:21:12 -0800
Message-Id: <20250116202112.3783327-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The srcu_read_unlock_lite() and srcu_read_unlock_nmisafe() both say that
their idx parameters must come from srcu_read_lock().  This would be bad,
because a given srcu_struct structure may be used only with one flavor of
SRCU reader.  This commit therefore updates the srcu_read_unlock_lite()
kernel-doc header to say that its idx parameter must be obtained
from srcu_read_lock_lite() and the srcu_read_unlock_nmisafe()
kernel-doc header to say that its idx parameter must be obtained from
srcu_read_lock_nmisafe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 63bddc3014238..a0df80baaccf3 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -402,7 +402,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_lite().
  *
  * Exit a light-weight SRCU read-side critical section.
  */
@@ -418,7 +418,7 @@ static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 /**
  * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_nmisafe().
  *
  * Exit an SRCU read-side critical section, but in an NMI-safe manner.
  */
-- 
2.40.1

