Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712C2E9ED7;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191394; cv=none; b=Wq2YOkQOWSjTfeLNwbuOj3v7HkE5svTK8x8KZpX6zq8Y8XmrBiYP3q9pXdHXx+MVZ73Gnhfgg8uIcsdSH0VFJYKkQ2o9A1URUQesWiQR5Lb4apdriWKdq3rESnEzeIZPHONU604weC8BpEJCBc8aapRVOPV6hd/MN9fGD9TxmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191394; c=relaxed/simple;
	bh=QRMj3cfejFshQ8gBkMpPIHQRTiBKhfo6s4NoeWXO8TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FT3Lj1HhNaisprRKvNy6RyAMPsBVdWrKnNglhPrbP7tr2k9sA4gh7Mffh0mMH75AooNQbvQ9u6E+ClQ3dQ2jF57UJHNruDbCOrWc0vHxCrDmeDefEn2uhRrN5U/KFhslaZi1JSPxOIK3G75bBlV9c02+YyCHT8qDJPyQWMxs0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIJvkAvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIJvkAvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF6FC4CEEB;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191394;
	bh=QRMj3cfejFshQ8gBkMpPIHQRTiBKhfo6s4NoeWXO8TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIJvkAvH8rPumN5z/8xjTX2R+xqJC+7qXGplarnKLEj8zXTN/3d6QGRxnUo4/4SbL
	 2EUOFj20i23hIhO6e2nJ+1Bc9QK5/RN/B3a2OExPNha3KAmrnzf09EW3V6D7u7gEjF
	 hmCaxMI+n30NULEKDASzaVx0Qtjo4gxDZXk5VYtEIV1egrseVX9NGgKMDimEHudxO9
	 wOaAhL0svMkhgiqZMhIZshLQvNEIATl6J5DWgWUOaQZLjadcKSLu+hNbziecrra+8J
	 Q/3RDx9J7AywxCrzmrWpsXA/dWel6ykkp0njwfotUULStBZs3mgLRlmr97AaDyYa93
	 Uskr1bJJXeVgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D56FACE0F82; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 04/11] rcutorture: Suppress "Writer stall state" reports during boot
Date: Thu, 18 Sep 2025 03:29:45 -0700
Message-Id: <20250918102952.2593045-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rcutorture is running on only the one boot-time CPU while that CPU
is busy invoking initcall() functions, the added load is quite likely to
unduly delay the RCU grace-period kthread, rcutorture readers, and much
else besides.  This can result in rcu_torture_stats_print() reporting
rcutorture writer stalls, which are not really a bug in that environment.
After all, one CPU can only do so much.

This commit therefore suppresses rcutorture writer stalls while the
kernel is booting, that is, while rcu_inkernel_boot_has_ended() continues
returning false.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7a893d51d02b6a..49e048da4f6810 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2756,7 +2756,8 @@ rcu_torture_stats_print(void)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
 	    rcu_access_pointer(rcu_torture_current) &&
-	    !rcu_stall_is_suppressed()) {
+	    !rcu_stall_is_suppressed() &&
+	    rcu_inkernel_boot_has_ended()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-- 
2.40.1

