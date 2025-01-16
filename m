Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52603241688;
	Thu, 16 Jan 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=MRH9glhl/VD3JSMHNIj3tlsUL4ila0nkSwWAaDEGhv/nTkJV0OkLdkNUXrFtjgiKJajxWZkSJSRX97Bq1gaEofpr2w5yTQPyrbEQ5eG9Zk53r6CSp97tZmr35mt3XIzj5BA4mzfgT6OQMfznuB1OB9me6Q3zwj8TptqcBy8xavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=bU/hhG2oOe2+9IgwUDcxuAMUF+jz8ZnfcJS4yxVb3jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADyqGzaSBjWp1TXvDiYfm/KSwHQaKCy9X+bmou7XWd//+ZgxIpJ/+wKkSqFOd9QLWF+HcKP5AoB21B6BjNHYNF5lgWr1wvFiqDeJeRqouRZUCQEYX2wBx9ulNR1sCATW0vkY6YVFcr+MNLl/nD4DDjmLpr76MK3DSkEXZlmn9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZLX9bgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZLX9bgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F221AC4AF09;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058410;
	bh=bU/hhG2oOe2+9IgwUDcxuAMUF+jz8ZnfcJS4yxVb3jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZLX9bgSoOu8vGiAJoWwBwjlhwPJhKBnhfXKWmeNKIx7C+5fjB+STYYbAkLKzciAy
	 cR0rOb1ru/ebaTDQkNQrwapLgSyevY2/+o2yFZKHPu8Xfe5+dkILzyKnxK5aMoBFYP
	 x+gtLKCDWCsgl7G97jpicY34eqWRFcL0H9vxiWmV13LjHOJIoSDFXxBwQT8HgAp9rt
	 WhzmULtHuMBBy3+zpNWW732nj1+4OQ15S+7ta9be/mpilAjPzJyE80/iq0bxIHxzOQ
	 i3u1xj6KT0PAWubzn7zNFtEZvyY9WEpD0LNLbTR29+YRVYrkyGxYk7Z4iZvflR9cvD
	 SO/flYMjwd6Yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AEAECE37D4; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/9] rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
Date: Thu, 16 Jan 2025 12:13:26 -0800
Message-Id: <20250116201327.3782963-8-paulmck@kernel.org>
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

This commit tests lazy preemption by causing the TREE10 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 759ee51d3ddc6..420632b030dc4 100644
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

