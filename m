Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F322C0F6D;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459716; cv=none; b=qTQGtyuqKmpib5YhqxvMiL7QYwwzOGkDhtfN0oF3NTJ+Xb7g5aQGF2C5UNotx3Qf8hmF1FpX1MZaxF08eUc4t3OMgPAQKjjhmkKiP9PdAtQDg3BM5Z896h5V6QdtpcJugN4Jkxg/T0nGKgbPqvewGmVRzES7TxfE7F3+zUI36WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459716; c=relaxed/simple;
	bh=EkZRF18fal3/zfiMFfCdfrq65vTfzdrDabPLzL+E9kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGgC/uXzIuWGG6xymPBGkUQAWw/Hpdj2VrnzsXD3hO4TQ9Z6+w8+BRMgzmYIfPOlOlOT9Uj849cPg3ZqJEok19WUonuUg3qNDDehaaj3yHDPdo7bvp7r7TULF/2cQE1GzYQjxCJAmtwmSL8cA6yYF9M1B4ZfXByHT3Wp0QQtW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvIPmG7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvIPmG7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EBE1F00A3D;
	Fri, 31 Jul 2026 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459714;
	bh=6v74Vr+JDl4aQFyesJLzqi6KC90vCW4EqJ5C7/ir9F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvIPmG7cQqWKmkS+GhW4MMqtErHMSpLcLj0WwFLiCgw9Ne4rxCOkd5RbhW4Grmg9U
	 PlprtAtQQv13/GB6drk2/OWp8XH7sLAt2R6B0CbTe9Txr/71zOIkTZ+XJCmqbxeLyM
	 nXp5xJHFAszFcyOCZHVVyuBoidFT9rIEMF6nlsl/M5IVngw42UOwbpAsOj66SgC9SI
	 AWu+BjYZvyZuTpRy6YtPVqaIcPLzsIsOfsRGK1velNrHCmVWs82pDQlUGL8wLbxTdg
	 ptOxb7COVPV4w7uy2n3ADLT6y2EMRUuVdUcLjWaMhAOXTihbZYsx28ZEy5S5kQm3Q9
	 GiCgIcNBT02pA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7ED3CE0F7B; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Manuel Ebner <manuelebner@mailbox.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 03/16] doc: RCU: Adopt new coding style of type-aware kmalloc-family - part 2/2
Date: Thu, 30 Jul 2026 18:01:40 -0700
Message-Id: <20260731010153.3531313-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Ebner <manuelebner@mailbox.org>

Update Documentation/RCU/* to suggest using the new type-aware
kmalloc_obj() per commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

p = kmalloc(...);
 -> p = kmalloc_obj(...);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu_dereference.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 2524dcdadde2b8..5bc3785ebfc2ae 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -236,7 +236,7 @@ precautions.  To see this, consider the following code fragment::
 	{
 		struct foo *p;
 
-		p = kmalloc(...);
+		p = kmalloc_obj(*p);
 		if (p == NULL)
 			deal_with_it();
 		p->a = 42;  /* Each field in its own cache line. */
@@ -293,7 +293,7 @@ Then one approach is to use locking, for example, as follows::
 	{
 		struct foo *p;
 
-		p = kmalloc(...);
+		p = kmalloc_obj(*p);
 		if (p == NULL)
 			deal_with_it();
 		spin_lock(&p->lock);
-- 
2.40.1

