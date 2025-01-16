Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F44241680;
	Thu, 16 Jan 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=ND4ClZZomIsrgn7Q3JnrqS8eY4zb9VbgsjXWJkzy1/MSK1nOYsth+Qi4P71VwhkJ6dy/YztEzcTZhnd9CHL3vaQNaAsEKJNJVG0YuCCuOfw8DtbsOyECQ4jT1zJsjZu+KGFiN+TtRaG+oD7qeWtM1aOQPqJteSekvr2+EhEFBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=6K2n88jSY1dRa7H83fEj4TajoHN1TN4hN0V+oa51GqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TU2nhZGLVvjcJaBbVDpZ7lgyozDrLKYhD4anFzONWgv7dCIuwfBAC2OkI22Vktny//aIunWuMvZzuc559sV48TgF7UCiRm7DhRTGL9qyTR5VcUbY3v80MQeh+X23O8ig+iM2tofKAFiCKGj4DeJcj9Rrkwx9jU6XyepNy5mPbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkjmx9UL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkjmx9UL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E2FC4CEE4;
	Thu, 16 Jan 2025 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058410;
	bh=6K2n88jSY1dRa7H83fEj4TajoHN1TN4hN0V+oa51GqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkjmx9UL0q44XOJSDreLQhC1n1vAOGbjwNGzUIPU1OoB2u61uoRzKBc/sohtbqMpr
	 U7qWml/rFh65VQIrKmVbBnTxYwNYMA474TIPkZSX0gEGLWlEfkNnv1NZcujorqXyDV
	 NWeU2PIFy1sfCeE6UX+i2siqmszHERc+5tOTZ6jKPW2ZHtQ/NpE106axffTDROL9n/
	 s0tGim2lXs5e7oJTcncyCTlzDgnNQ1QImoXgzeMEONjbnij2w0zU1+XtyyG0yjmOuh
	 8528oc7PjC69mZgPINMI6norXZKRHI7KE1oJYJ386WB1RKoNvJ46Lf+jqPJXJOlK0R
	 SU/2eYUDx6aaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D0E0CE37D5; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 9/9] rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y
Date: Thu, 16 Jan 2025 12:13:27 -0800
Message-Id: <20250116201327.3782963-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit tests lazy preemption by causing the TREE07 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d30922d8c8832..352393bc5c566 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
-- 
2.40.1

