Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7DF9EC;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558868; cv=none; b=bzcUObm2zv3PnOiV6ibToOPdghoa48ca/c+W41CzUY7UlDCPYAh7cCp3dlB9EkifvU7mVNIDcrHdeWfp2FWN8nYmY668mN7CN7/kZJL2bq0dsvXiGeoMAmROGqSC78NeIwoJF4UsUp/Rjvni2B6nx3p64uIPP0lO0q5ZpI7cuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558868; c=relaxed/simple;
	bh=X9aHmvddPuSA+i4410NgEvfsaBk41rG80LyCQw3wKdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XayUtcAVu+uj5tUQc9B7UqMGKDFMscTXdwBysljclPZghYlsCT8c3BH1zm1BZ48/EkhruuG4cJVIZbjFYKuU+w8Qk2Cqx/RDfgvWwyhdk7kDTQcORzvnYn1hy65DAPUjZN3BRmaoHsGfHD5muDkkZYfwOAFxGsBvEm2v5lfx+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMnq8Etj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMnq8Etj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C1C4AF0D;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=X9aHmvddPuSA+i4410NgEvfsaBk41rG80LyCQw3wKdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMnq8Etjy6vct9F/udWnJEKAOwphoo0Ri5n/MWEWd2HYszyCcdf3Xb+ldFzA2J3Dc
	 UAkf8QzVvaz1YInuoCvoJfCk4VQG0b0nfCS/kXO5bmFYXtk/Kx4KpwUWuqdWS+p/1D
	 64Xl8j9UqFeaNypZPzQ5T7JrPyy5LXj2Sb5pTFxKwCDqKJF+AC3N/FmFiQh6mW3YFZ
	 tq7L4ulKEUy4NvpkBlJWtkwhyyOoIxWVwrK1/L/bwOP4j6Vs76fZjoxZZylTYEgzPj
	 avFslSZyMAlM8k6Y3ZVKpduMAIGYF59zPRmMh4KG5gZQRVGPhanERUdwo9BZQvN01b
	 l17UNRYNMBjmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7438CE0BC3; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/6] rcu: Provide rcu_barrier_cb_is_done() to check rcu_barrier() CBs
Date: Thu,  1 Aug 2024 17:34:23 -0700
Message-Id: <20240802003426.4134196-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit provides a rcu_barrier_cb_is_done() function that returns
true if the *rcu_barrier*() callback passed in is done.  This will be
used when printing grace-period debugging information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f035fd4e579b4..feb3ac1dc5d59 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -252,6 +252,11 @@ static inline void debug_rcu_head_callback(struct rcu_head *rhp)
 		kmem_dump_obj(rhp);
 }
 
+static inline bool rcu_barrier_cb_is_done(struct rcu_head *rhp)
+{
+	return rhp->next == rhp;
+}
+
 extern int rcu_cpu_stall_suppress_at_boot;
 
 static inline bool rcu_stall_is_suppressed_at_boot(void)
-- 
2.40.1

