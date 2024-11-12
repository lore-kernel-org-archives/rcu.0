Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B620011A;
	Tue, 12 Nov 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423191; cv=none; b=LOZfL6nnsr8dXHX7TFI9ifuGwtNbces2bRZ8Gj2wk5BxJdy/wFZpMnecC85MOIk9VoWA81B6SuzbKxA0DH0+eWzQBsYD16pz5lTQtsgV48UQ+AfpUqfXMQzTrsXy0XcC5DAiVQOE+R09vh1ikKXFCVgacdkjAnJyl0kOAlP5two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423191; c=relaxed/simple;
	bh=GIhZh93QuvVeoudWwuzoyIzNtlHYTdDkGBR8g5zW14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVwM3tQxr4UadtfyOOK/jEuyxbERoX50y6a/F12zbababSbP4NsMGEve3MxVgz7GflvtfhTpTnnsYR1+zoKA8LDJn6WdzU/SDJaDIHxo92wfac0+wV3A/YXNTKbxqOECxjg3G8f/B+TYJoC5SfqKBWwHERdjdkBavRrGoYYhgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce0i2qR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce0i2qR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C86C4CED5;
	Tue, 12 Nov 2024 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423191;
	bh=GIhZh93QuvVeoudWwuzoyIzNtlHYTdDkGBR8g5zW14w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce0i2qR9yIfjpjRAm99cOcCBS0s6QD0DO3Thlkt7SyEryCtT757nKtt0uogRZA6Fh
	 xBo3l9Ulw99OEts2/KUDWZ8f2PvZA5nuLKOa5HoGSFvQfOHTERDSgsEOP92OsPRhLS
	 A1Eatq5N2VYCQ/RhE6t6jMZ6sublSkWsWSjIyvhtxtm/5DXytkWbrvEgfsGshVI0Iu
	 YJI3FvMNPMRpo1+lL/7Fa/3ZKATZKzxqXK6VkzqrUi+h8BMQqifqkjFQzTBU3yuXHn
	 3nAh0Uwy8GNAasMnwqLNsQdAM1Rtow/zoUvYbwFUs/NN8KjVASlH6uF2/d/nevCrOh
	 5vlTvYHftY3TA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 16/16] srcu: Improve srcu_read_lock_lite() kernel-doc comment
Date: Tue, 12 Nov 2024 15:51:59 +0100
Message-ID: <20241112145159.23032-17-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Where RCU is watching is where it is OK to invoke rcu_read_lock().

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 4ba96e2cfa40..bab1dae3f69e 100644
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
2.46.0

