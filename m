Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBE1F76D4;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=G7GHlnKUNu98+DqSfK+BXphz90nJRleJBSS1AC5vYPnVhTPpLLE8wJLVMkycpaKQ2sYqeTOMRJEEJoHTdZklIIgNaPuAEJDVRidNm/mkr9RGVNoi7ImGgn8jcqSyjwvuWtmYM2i+aE90Rm8ta9G+H0EiVqQZ+QSRuZJ90OJ5HqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=8e+zGyoW+Tm4spVSvH4fyTbGnotsozeYt2gapdOvycA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTUzznG7Y2N70gaD+GEUqIUnLMG1Qu/tDVS6c6ApQ8D65iBxfhWFICJzHttCF8uZ+5Hk7QhooI4cxggNUZrgVBYT1e6AEChgyp52nEUeGUN1zRHWxNtG4btu/EgMuFF7iepQvDXrNBV9ZY2nygcPfPujtV3hox8/U+yVnBOHFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRM6b5VE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRM6b5VE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FA4C4CEF5;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=8e+zGyoW+Tm4spVSvH4fyTbGnotsozeYt2gapdOvycA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRM6b5VE41ITBDvTkYCmQMVXY9O2L3EaJDoraUdCMbsxr75935KbL5NUm4YaAcdaL
	 NtTXITYelbjm9+BgDAFQh37dC3zBcmoaFUWxpMClP2TFB49ySXqURLza1yTrcqF70I
	 zkTIH9Z2TtdTpdOPLI13eFEF59lYJpP0azd6i9lF9iZZqYM2jjLwPdDLRMX5Br+61f
	 n56YycBAU0rWwwkk6p+kVw++dvwMCM8p1m6f9DoPHvFzC/GkDH009ks7F1jbptIHvQ
	 Mu+zsIOsZw4RAzvRJvB+yku4tLy3paGGnC8Ldz7aza9wjUAui+77chUtMraLUkkT9i
	 5H3+Ap5L3qEsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9AA9CE20E2; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH rcu 15/15] srcu: Improve srcu_read_lock_lite() kernel-doc comment
Date: Tue, 15 Oct 2024 09:11:12 -0700
Message-Id: <20241015161112.442758-15-paulmck@kernel.org>
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

Where RCU is watching is where it is OK to invoke rcu_read_lock().

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

