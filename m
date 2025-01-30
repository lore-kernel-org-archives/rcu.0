Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AD1F0E4D;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=b4rtFSi9O4WgnT7yYa8PTHKmdk8c60Zk5WfrbnLrNY8qKpptJAdz4l35Tv5zUf0yrguPOSmUQngjc2eja3R2jBxfuGgtM5e8M0seBYKFdj57xzN5YS4HexlzNwuu/Nr2ONMYnsXn+nWdwXKcz2gzvXmC47qBC1/osAM7xm+LXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=Ta6x6E4Y/Cvp0hdhi77qdtbO+qPx2Z5tGwClq25nvtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsAA/iW3bI/13DW/7dbLPwALgS4yCi3+SYxOlvK/isWrldZFzuSn1kXA3f+qTwdtYo1sCdf2d2aKJQgCkTe5RuxHp7FB5ix19nXCiF1x/b/qddPvCsy2PDGSi7m28aXTO4wn/uuPZXS5WeWVaG9XvjmCnGvMGTcTcD7R+RDDrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSlNdFdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSlNdFdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3684FC4AF0B;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=Ta6x6E4Y/Cvp0hdhi77qdtbO+qPx2Z5tGwClq25nvtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSlNdFdJ3VBopL2cedLN/he58etagtnjWoC0FrBKSYlkTmfntmJGPI/IcHOuYN2xb
	 AJUZwDBKyf/AcVllWKbfv336x1QUiwIRqujg+DR8cfLhYs6V87shjfFjEJLeBAXyuD
	 4qwrdtmB4ITZ7mUGSH9Gt4vW1eEd6vvoWndywp+tvHyGQbN3ssVygH6USht3gTjgkM
	 PLi6rNtnfav/jfECapZFYDzGadXCkH+JH4szeSeoSOTpGHev9v5QiY4w6iwsob4OWG
	 y2hlXMYencQfOtTePNbUVeL5cpCn7nY50hwwglaKP+fm/NkqKgCIAW4jFK8ESlz3ZQ
	 v1jh5etWFsukQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9912FCE37E6; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 8/9] rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
Date: Thu, 30 Jan 2025 10:55:21 -0800
Message-Id: <20250130185522.1652093-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit tests lazy preemption by causing the TREE10 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 759ee51d3ddc..420632b030dc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=74
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.40.1

