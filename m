Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8E17E016;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=Op65QMNLZqjp2HZzr15g7JhZSv5ejpoRMn+Dnhhob+5IYDX12fDJDvwl596c4jk+8brFmJWYS5KJlxVM5O+FcvnyokOMYYFcDsrIf8MEnpeOX7bDxc4e+VuJ9YOydRWfznFDqnz9PfNezWKVWAe6m6aGZn/5Q5A+rgX9LhI7+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=Wt+iUXA519YLeGephNKkRADiLuwr/13xisKe15AlZSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2uZhmD0fUGJZlXE7EzpoYF7d1hrb1vs2Is59bm3nYD55R5JzxMO2aXCZQu6JE7B+OH/7dgN0ct3B+bptP1GS5aA7hd3ekBK28PBl6Z2AKuokkdJ4w5OSTytCadwIZNy7e1vNpFo+0LRz1+uoc2nx3Gh/fszwm1QvjkuPIoUySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESrxEEHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESrxEEHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C953C4CED1;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=Wt+iUXA519YLeGephNKkRADiLuwr/13xisKe15AlZSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESrxEEHVKaEOdvSFVHIIHcvaRk2jpktbq9B+AAiaw9VB2SDenYvQ3a62LplnnsHaW
	 6Q0v9X469J4CkHRPGjHxDPJrEAJN8jqtr1WmjsK4R4PDCM8Czx6KuukJlbqZMIIX3R
	 jMldJL3wV2a+vbwju0D4b3e8vV0IN/OYuhUAui5ZDelJp0RAQ8gggR1Li8ix3qg+Rn
	 O9WXC9Gl9rT2i3G1Y4hajuCzCutJatPghYNg9/BeBNI7YlLOj/Ufc4pFgyjdEUJmqE
	 ZF0bw+Nr2/zvuS6cbakXvlCUWs6AmU1Abir+6A9rhEcOzBmFOqORCqsCoB1oVMLY+c
	 IEOjRXS06Phlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B96AECE0F9A; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/18] rcutorture: Make the TREE03 scenario do preemption
Date: Thu, 12 Dec 2024 10:49:42 -0800
Message-Id: <20241212184957.2127441-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the rcutorture.preempt_duration module parameter to
rcutorture's TREE03.boot parameter list in order to better test preemption
of RCU read-side critical sections.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 8e50bfd4b710d..90318591dae22 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -5,3 +5,4 @@ rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
 rcutree.use_softirq=0
+rcutorture.preempt_duration=10
-- 
2.40.1

