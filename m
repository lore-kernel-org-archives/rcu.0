Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 224223FBB3;
	Mon, 21 Apr 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216144; cv=none; b=aKpWt3Tn0hBNdvzUhI9vyi8HD9vT0V/hMuOx02A8JCWgHHuinQ4VO9fNYR4JsHqjjOzugjCxsPYTXQ4/TPLR+rdkmSoGfnS09w5RdKEICydj4K8aQMIoAt5z/H2siw9gU6LtKrvFnzqnt0lK6moYFrGPuZuHtZj6s6eSLCJliO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216144; c=relaxed/simple;
	bh=pexuyVUdAl62EN1tiqiLq2qywE+Axu5IlyyjKJWJtBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMn5Dh3g7UVcF+SrHti5ENBO9EowoZXb/i+ZMwcvpYW5yfqdW9R2b5zaNM1VFwl5X9Pofh5X4D+pczFJxJ4G361mcDSJdIlncj36KV7JGwQGx6guHijlUQeUMTVw/0GoqrVz4xSTfHQNqLjPmIMJHPR6u7g1FO5twr4bMgOfQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2D27660252AFC;
	Mon, 21 Apr 2025 14:15:30 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] rcuscale: using kmalloc_array() to relpace kmalloc()
Date: Mon, 21 Apr 2025 14:15:09 +0800
Message-Id: <20250421061508.718752-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's safer to using kmalloc_array() because it can prevent overflow
problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 0f3059b1b80d..cbe2195f08d6 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -762,7 +762,7 @@ kfree_scale_thread(void *arg)
 		}
 
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
+			alloc_ptr = kmalloc_array(kfree_mult, sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-- 
2.30.2

