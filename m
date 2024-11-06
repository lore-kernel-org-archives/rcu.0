Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E7205E3C;
	Wed,  6 Nov 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907144; cv=none; b=GUVl2X7614MwoOPUHDQwdh5fx7FrI3NuoEwhJQy2vCF7s+1ZyPvJGQ223UtHUb5AnKqaCU9Kj+4bFEdwsOYCqYsMUJafnTxRHEouiPq8UELqVtbGMOcYdvbp03OSW2J26JkytE4x8xgde9ypwcf7ufCXI2s64O0mtyyRUWkpY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907144; c=relaxed/simple;
	bh=RbYJIcGpWB6ivRF7Ui8wnFG2WBqE1b6l4++AgbkwDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmo+2bqZSBXiQpBJ0tevWj4AzM7NmgTU1UdlVwzWsUy/H5lkcziz2+K2M9YnxOOy4viaqSPVeRytmB7m2/oD/zaOAdw6En6LAVpE3+1NrShhiH5cr1mHZK3MlzlthrDAOp+COUlQMwuuyqFrE3cCykbVnJ/aKfuOab1JXEYiJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHPzPgzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHPzPgzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83EAC4CED4;
	Wed,  6 Nov 2024 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730907143;
	bh=RbYJIcGpWB6ivRF7Ui8wnFG2WBqE1b6l4++AgbkwDwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHPzPgzIjzxz7obV/oZCoXrzXy9Y4q+h9dI6jnQND4eB3bG170mUTBmIqPVcRkHJR
	 gnT3OWFqLoFkERQr9I9KT5cXN445tf0f1smpPisuJ/EZ959Lz2ulGzSKGcY/UOlkDg
	 y9HjRZTxM8ID+tqJqfOW052vvSykOP7B0drhoCHivaC0De3YE3m8oazJyJyukyopN0
	 Abi9Auds1Vapzn08rGGCQWUyqDRh503nwAiKaaWoX1EJvuZ7p/NoqoaYK1WbPKh9T7
	 daqe4bWX6HRzZqg+7YcY9MNUFWCdyCcehwjuCGbtUG7G8ZTyRo63J2DhSXSRjSB8yu
	 b8dMovJAINegw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH 1/2] rcu: Remove unused declaration rcu_segcblist_offload()
Date: Wed,  6 Nov 2024 16:32:12 +0100
Message-ID: <20241106153213.38896-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106153213.38896-1-frederic@kernel.org>
References: <20241106153213.38896-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

Commit 17351eb59abd ("rcu/nocb: Simplify (de-)offloading state machine")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 259904075636..fadc08ad4b7b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -120,7 +120,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
-- 
2.46.0

