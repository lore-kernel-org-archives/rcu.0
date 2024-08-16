Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34075817;
	Fri, 16 Aug 2024 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791839; cv=none; b=JAC9NqoTGuROqB3kGWqTnr7jZBsx5QTfTC+M0ZsOioEvtcEm8zDp+TrCWw3HOPQ7xMY9Z+pbzDt2YKQ8qV80xhTN6rAw0H/55YXv+s7kv1XpUmquu50UFGFeloMe7/uZObw8OqOLMqy/xBEYT8hfzmksmKvRvBN6A47IGJ20HCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791839; c=relaxed/simple;
	bh=CvlFaPcyQA+Nkp6oUPDzrGfQYWuO6ut8DozmNgSRw4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoZZqc5TrMvs+gToKpfQ3b38NFLJpOcVvT1Iqx94bOmj9irJBz3dFw09okBvyILLJNL7KjegYNWf0hlAFoOpEu4VyN+1/yksF+FnDp2AkDQNDjqJHDzJXThlldRe+7JhUmvm8/o/M4LlTsO28qkrfFnx91dXpwrlUgjhGmgSPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgvXIuse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgvXIuse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02E5C32782;
	Fri, 16 Aug 2024 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791837;
	bh=CvlFaPcyQA+Nkp6oUPDzrGfQYWuO6ut8DozmNgSRw4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgvXIuseQaCUaFPWNzTYBnjU/MhUF0BKKnvG8MVdlmpfTgBWnbgda3+G9IZMdH1J0
	 T66pAcIYdWFyFF2+fe4pH8k+9+PNeZzQfX63Z2F0w3kqJmCtJgpoBNT6xTL8nv9V35
	 LpipqI7cOaHjQjtFvzi5dXLfs+t2M9H9OUaDiU98owo3MomdbX6ailGgKMqMmqSQpo
	 OMezHVzhCzAKKm7U236da9gdhejt0x7Iz4czloftE2zIKDbC+/V20vNP+UxtjvB64t
	 +GL3pPBRblUFaT46MoG2tSpkt8zTUna4EzRpxxSqwjLj4+AUVKUn8LFtjTXZK5/40i
	 nNs6KPL2m3dtg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 01/14] refscale: Add TINY scenario
Date: Fri, 16 Aug 2024 12:32:43 +0530
Message-Id: <20240816070256.60993-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a TINY scenario in order to support tests of Tiny RCU
and Tiny SRCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../rcutorture/configs/refscale/TINY          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/TINY

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/TINY b/tools/testing/selftests/rcutorture/configs/refscale/TINY
new file mode 100644
index 000000000000..759343980b80
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/TINY
@@ -0,0 +1,20 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+#CHECK#CONFIG_PREEMPT_RCU=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
-- 
2.40.1

