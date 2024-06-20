Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACE1B1518;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899904; cv=none; b=YLx0LFqwm1OquML+tG3sJkROcvkjCLzhjht//7o8Z7AziowLM6SfvVNcOPOH7sGOQKWsgm6OsSJwnd3zqkmw2J3a5uOYEyrd9AIs3J+4uP4p/6zCw0UqhqV76sWg6hEj84VSkEyr7WQiuAcVJnwMrHxABAje6ZLDZk5L75tX9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899904; c=relaxed/simple;
	bh=4Xi9ciSTlq6j4E49TuJlERCWIvwfb9dALhACmcCI9pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dcskf8V/xbZkOhAqo6jJ5g3CTya4bzeHyMzh+3WcntvUd0SzX9vRQ23VcEjFdOyFuAJCk6u3rzG5y1UlbxPYIA8X0QbOH+Jfvf91Vha0U/xin3+ITgr8imQ9ItuBiMvrFDgqV9AdyKFBwaYRi2/e2pjfmhgFJlWbFPAK5A7KPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9FeimLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9FeimLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365FC4AF08;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899903;
	bh=4Xi9ciSTlq6j4E49TuJlERCWIvwfb9dALhACmcCI9pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9FeimLp8lBYrd0+KNMBej57ppp0VMRRWSxCjdWxw9ewrbXJCxxjJ+0vBIG81uggQ
	 DV93bSKTwrM60hOM/1rPmGyp1vQuLL2lamsjOWapQCeRIHLS3AMFZ7kAKbQmcx8xoN
	 dq3pec0oHwtu/MjpY22ZIRpxzc4NS7NcoNYz4Hu9fgbR6pLZZV2CAGU8FbjaCZY0cp
	 DmwscVract3JjRMT7u2GzYinDCfnkVvcrDtreIuGKeHw4h9v2EEPcPxuhxL0STsSB2
	 iejSZKGvAtWa5vwkHrVhZPteJkJQAaHyjOpCqILW/ZZyfTEOV3yJjpsY9/4g/GGKtR
	 jIYMTBX+qr4bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50C51CE0BA3; Thu, 20 Jun 2024 09:11:43 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] srcu: Update cleanup_srcu_struct() comment
Date: Thu, 20 Jun 2024 09:11:41 -0700
Message-Id: <20240620161142.2057652-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
References: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have polled SRCU grace periods, a grace period can be
started by start_poll_synchronize_srcu() as well as call_srcu(),
synchronize_srcu(), and synchronize_srcu_expedited().  This commit
therefore calls out this new start_poll_synchronize_srcu() possibility
in the comment on the WARN_ON().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bc4b58b0204e9..15dc22a8ff5ab 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -667,7 +667,10 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
 			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
 			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
-		return; /* Caller forgot to stop doing call_srcu()? */
+		return; // Caller forgot to stop doing call_srcu()?
+			// Or caller invoked start_poll_synchronize_srcu()
+			// and then cleanup_srcu_struct() before that grace
+			// period ended?
 	}
 	kfree(sup->node);
 	sup->node = NULL;
-- 
2.40.1

