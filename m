Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3473ECBD2;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=Ew2KypoPE4irrqmoZDmg10n4IuioV9Ff13A6KZvIjvWaIDVOnp5ZppLLGVcN2bslE2cuj8CaZ/WyUECQ8ygVyLyMXyGM2PxFCz/oUoTNFbQg7zJHqgGdcipBhLGIDAT05A0scbs9lddl/RdpDPRNtnuzcdEigLlIDipHI9DK7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=/Y++xnjbRpcunrSUKXCI4237l43LWEtuXPunx3ckXv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyLUCRaNlubRCpRbfnVRf0eHxzXncKcB3qfJtErnMdK2QhWG393cDjTIMZRt4BNekhzbuOtuFdvriREysuPophcKMAGccws1HjRDG69zHvfP1QwAnANPxclNf7OgrwDaZbFHOCL0LlOJPcD9QFuK0d/rUQwIl42HFvdpuocOPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLzq99Fe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLzq99Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC3C2BCB2;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=/Y++xnjbRpcunrSUKXCI4237l43LWEtuXPunx3ckXv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLzq99FeYhg5A100/KijSbovUApCQll/NwTLbJ/C2eecm06l4pZ5+loWWYosqb50Y
	 fYU/fEADJ4HKzPYg+ZjzpDo0qXuI8BhEsMmKYbfoTRzpx8FPWKd3xswfylwkIfPDRs
	 a8eTxEIjhHApV/oa5v15dFGgOZNO+o+1XYLTglnBVwcfIRk0kLpVaYWVYPwLJz/QjX
	 xuvuYazPdwYv5O8LTD4kywzHIMi/aZ6MqxGs+doz2Nk3p3aCp3EYW3Q6WhvAc5hg4K
	 5W6RFrQm1JKHVUE6neF7+qngNVVi7MBRrvjZugXyjmWkyrFM6lwWJFcI2vQijFdStN
	 nkaXQF0IDYljw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A81C9CE0A36; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/7] srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
Date: Thu,  7 May 2026 10:09:45 -0700
Message-Id: <20260507170950.2040199-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/srcu_read_lock_safe()/srcu_read_lock_fast_updown(), there being no
such thing as srcu_read_lock_safe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5d1..a54ce9e808b92c 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -397,7 +397,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
  * and srcu_read_lock_fast().  However, the same definition/initialization
- * requirements called out for srcu_read_lock_safe() apply.
+ * requirements called out for srcu_read_lock_fast_updown() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires_shared(ssp)
 {
-- 
2.40.1

