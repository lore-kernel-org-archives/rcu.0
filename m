Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882391856F2;
	Thu, 30 May 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076795; cv=none; b=hiWEsF/TfHgjjfxn/EHNiTo19fmhGIqSrs5EQa+LZVgL2rvFX3mreSUXezQUAwyjOh7bnvkU8bi9VpROcd9HjlzXjg0ayVEuWknr4XoIgPdXoQFeU4u72N31ymzUW+OM5Udy1zftkUjMuCEvK/STYZEdIwcJ5H7PM08vUYONFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076795; c=relaxed/simple;
	bh=zWdQY6e/8PSNUP7VQ0D8AgYnYw4k9+f5nEq3LZnmnr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEWp75NpH1ha+iDGeM1Ce3vC12OjAC1Zpl/FHsNavmWULskqdCsIbgtZKG3Y/62A0qdA+bOdFxla/f4FZc/dYeAslvKPVect+et6yswMuvORsFQ3QXOxZo4JyBxDGtSvmLcw0LiRmmRd2KR5IXfvxQhB3pG15YzHy6WXBXsk1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l14Shepl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l14Shepl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E16FC3277B;
	Thu, 30 May 2024 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076795;
	bh=zWdQY6e/8PSNUP7VQ0D8AgYnYw4k9+f5nEq3LZnmnr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l14SheploPRJfl6S4qmmWBf75MaXZGZBlrapht8sNO4fm+uaCJODrPychuInfje+/
	 RSbctdwvNuUYxO8mtA33/gUFgomOBXy5TCF6rdJtDUwZK7CX7v32bzwfJzBzGdsKt+
	 wH54KuTJr+OasmLs/dUx6c2ya1cMrC9g/5HPhrozIib6EcjXHFR7ZtiiDaY1KkYdes
	 HNANXkDRKinbY8eYvUM7Ae+i6+gIBW2AhTI4e3eMVwHZFAEgyiNjG6//ULwwcUAWLs
	 GXh6HQXepy8aZ+yT5I3lkn5qGUKVCrb+wRySPjhhT+462tnXZO4LBJTIgA/namOLnh
	 DDe7cM0tBaCBw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 10/11] rcu/nocb: Remove SEGCBLIST_KTHREAD_CB
Date: Thu, 30 May 2024 15:45:51 +0200
Message-ID: <20240530134552.5467-11-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This state excerpt from the (de-)offloading state machine was used to
implement an ad-hoc kthread parking of rcuo kthreads. This code has
been removed and therefore the related state can be erased as well.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_segcblist.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 5469c54cd778..1ef1bb54853d 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -186,9 +186,8 @@ struct rcu_cblist {
  */
 #define SEGCBLIST_ENABLED	BIT(0)
 #define SEGCBLIST_LOCKING	BIT(1)
-#define SEGCBLIST_KTHREAD_CB	BIT(2)
-#define SEGCBLIST_KTHREAD_GP	BIT(3)
-#define SEGCBLIST_OFFLOADED	BIT(4)
+#define SEGCBLIST_KTHREAD_GP	BIT(2)
+#define SEGCBLIST_OFFLOADED	BIT(3)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
-- 
2.45.1

