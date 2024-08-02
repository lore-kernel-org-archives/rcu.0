Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234167A0D;
	Fri,  2 Aug 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558985; cv=none; b=XkIqd+F6N7Cn/sirffjGwNrnLa1ea90D5RnG29UFDicWqEWKiR2SJ0EqQ7ayfSYBMo3T56QbzekHa+ZS0cbAWxSB9xHeYQ0bdnjqpfDRdfaWOI1tibfrKAMT85KQ9xoCntcWByrRmfSxW5lT3EuC6+tp7OwLpAPhrhENrEMC5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558985; c=relaxed/simple;
	bh=sLm40LKhSOWLVQcsO0jcSyForZeDV7IsVbWZytINNrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez2Jc5s0Fk1ZSqfrAc+M6DeI7eSo4k2HrqBK3fy+BbT5JYk7kcarpATBFspJvVxu5L81pkIqSISoeHYJhsQGSRlkQ6+oTPHZtVisJCMPeMe5XfUIokxco99T5w2mwmU/2HbfUoO7tTAMIWzxtJQt5ooHJBByAXV9iHY1kxvoKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sku/33mN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sku/33mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85D3C32786;
	Fri,  2 Aug 2024 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558984;
	bh=sLm40LKhSOWLVQcsO0jcSyForZeDV7IsVbWZytINNrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sku/33mNKu7/60YfC9NUMZY2SjWg4Zbx2pyn06Kpqy1M4kI/oO/t06OVXtDD+TzhB
	 CjSnqJ7aKuGCPqWcCcGEfT9DB+AJZmnKxJNHkLKNtPdgjvsqsvtfIWVTuzhwO1zX8t
	 RdA4tRQId7zUk6QSYAAhHZI87EnIY9X3OGTX+Wn4lg7U9ZhxdSG65Uwvr24KL/yCCe
	 ZIXDl8ndfpNNawCP9xdq8GNClNTNUGCQ00Ww4CfijfxKelKnEsk0BZPAuoZJCv+feu
	 S0QB6wVxzgK/UZCxwefsoW7pbBEJ0G3SrvdkCfMND9RpaGVvRlh8sl+lTT0nuf9E6L
	 YW92XyWqGCqlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7653DCE09F8; Thu,  1 Aug 2024 17:36:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/2] srcu: Check for concurrent updates of heuristics
Date: Thu,  1 Aug 2024 17:36:21 -0700
Message-Id: <20240802003622.4134318-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7f2dd4bf-525d-4348-bf1d-c5c1c6c582b0@paulmck-laptop>
References: <7f2dd4bf-525d-4348-bf1d-c5c1c6c582b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRCU maintains the ->srcu_n_exp_nodelay and ->reschedule_count values
to guide heuristics governing auto-expediting of normal SRCU grace
periods and grace-period-state-machine delays.  This commit adds KCSAN
ASSERT_EXCLUSIVE_WRITER() calls to check for concurrent updates to
these fields.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 48cd75b74f708..d3fdaeba0c10d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -632,6 +632,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
+			ASSERT_EXCLUSIVE_WRITER(sup->srcu_n_exp_nodelay);
 			WRITE_ONCE(sup->srcu_n_exp_nodelay, READ_ONCE(sup->srcu_n_exp_nodelay) + 1);
 			if (READ_ONCE(sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
@@ -1822,6 +1823,7 @@ static void process_srcu(struct work_struct *work)
 	} else {
 		j = jiffies;
 		if (READ_ONCE(sup->reschedule_jiffies) == j) {
+			ASSERT_EXCLUSIVE_WRITER(sup->reschedule_count);
 			WRITE_ONCE(sup->reschedule_count, READ_ONCE(sup->reschedule_count) + 1);
 			if (READ_ONCE(sup->reschedule_count) > srcu_max_nodelay)
 				curdelay = 1;
-- 
2.40.1

