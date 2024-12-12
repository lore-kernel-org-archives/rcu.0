Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B4223328;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=CXWQiEzOuX9nA91aWMZTZq/5nxA5i9lD+D5P6O8fRUf1yn+ogtwlQ1Tyvzk7OnmJjZxZFeFxR6QOcKoDsONRUTBDv0r7QhoJBnvnc2d2r18Be928mFSBCyJgVoryrnDuYtojy0NuaxWxdtf/0DY6so9vRqziTEAmJ0HYmcD4acc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=lrBecZFHohJhe5fZBGyApnmibdB5hzycxSGgrG1RZnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQknrRr2GnfRkwCSm8nA6+XlNQz3YERzfBcm6lxMJZ54XGz7AMuZjhT3p3KMpPIpmpaldiOqstxeHSUFqHTaT2wgP2qbnQEYpDcOJu4hD/+JWCM2w2jBK37+KY7jCBSoI9qTZgpSPSlNZWkGSDS5yej0DDMxGQobUbMUKGDe1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpnKk8Fm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpnKk8Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBC5C4CECE;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=lrBecZFHohJhe5fZBGyApnmibdB5hzycxSGgrG1RZnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpnKk8FmlOCgHvvDyNgbpdt9yR47oapZtPN5yZF/bO806zBpJvbFXMEzq+VypkO1G
	 59C4XtB3K1JFLyF9TWW1UL6PaZVKp5CTRG66weHNnosp35d1A4VvJlzk7dSTzG3bLK
	 DcQmj7sqpFDvs1Ho9LoiLVuyqz8trmVE/P0BnZshPEU1WZKNtLsJAclNpGHomwM+Ny
	 /RiilQs+LEvLsleaj15uV9x7SJtv1wjmxrTHUJakNFU+7tsgS24yXI0Tb54Cu78eD2
	 +TsNYiNHPnoOXVkM6mEJRrEGqlO9VcLLREQJ5jZFTb5e/TtTswH5NdqmILwF1vDvox
	 XvQFmp7+W+7Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C95FCE0EE4; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/8] rcu: Report callbacks enqueued on offline CPU blind spot
Date: Thu, 12 Dec 2024 10:39:29 -0800
Message-Id: <20241212183936.1936196-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
blind spot. Report any potential misuse.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa59..24f1cb292a92d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	head->func = func;
 	head->next = NULL;
 	kasan_record_aux_stack_noalloc(head);
+
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
+	RCU_LOCKDEP_WARN(!rcu_rdp_cpu_online(rdp), "Callback enqueued on offline CPU!");
+
 	lazy = lazy_in && !rcu_async_should_hurry();
 
 	/* Add the callback to our list. */
-- 
2.40.1

