Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEA2153CE;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=gVuL3AHXEFuo+ICL0VoqDZOYCD7LgV/LOwqmmeXWxmya0AU5i0YL8wACxknDCUjMojLKKkz+liZlAA7mYKQYTo7he+WbCdOKzLBibNx9VUj6a8DUtMU364k/j/cmn1egCeyffy9fykulyjR1WAiWVP5FBxeTUOIARmSuTS3GiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=9sDMN4XZIcJRgoHQjxyZQce37ueUrgjbAHGywNbSEVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/MOD8SrMLDSgJX3A2XXCLdQ5C017xDTF4nNi1FDs9EGZiGTTtzI28ZLmb71+bRvYrdXmbeXyoBjroB0xfM+flcGG3Wflf9Irgb3zS7j3Vn4ZvKWH6MpWXkuf67dar0dtJ1qHkCvtr0qiixwOzwxb8ixzsLAp1oCdxHXBEu0XUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAX4KNmP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAX4KNmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7D9C4CEED;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=9sDMN4XZIcJRgoHQjxyZQce37ueUrgjbAHGywNbSEVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAX4KNmPJGdPwHk2VJZZl5ykOgI4J4w8XqZu27hWQhKh0XNesjbap3l/lVej8PS96
	 3i6/ieNyjBTmFKhGJ/vxvcvvRuSZRN7z9nwYZHyKptC7CbzjKgob5y/R909CmNYAQq
	 juDAEp8DZNg6i9U2Qs1UzIw8txwOfjlIdu2ku+u7N/sqnBsp8fV3g+pPHH4piNikJB
	 CeUb4TTcb0Qv7QRdOpC/QvRnFMwLymkrEHX8TofCzKbJ4x7reyT1Nx0evrurogRaDB
	 6BZg4eDa99wA2HYlCm8wZdrgbydUlXt5owiAK9JrCmzyTwNA2zhRTekRKJkEyWFum/
	 l01v6/ZUpRolA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2BD61CE10D8; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 04/12] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Mon, 31 Mar 2025 14:03:06 -0700
Message-Id: <20250331210314.590622-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The torture.sh --do-rt command-line parameter is intended to mimic -rt
kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
mimicking more precise.

Note that testing of RCU priority boosting is disabled in favor
of forward-progress testing of RCU callbacks.  If it turns out to be
possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
testing of both, both will be enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0447c4a00cc4d..9cabe505585ea 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -448,13 +448,17 @@ fi
 
 if test "$do_rt" = "yes"
 then
+	# In both runs, disable testing of RCU priority boosting because
+	# -rt doesn't like its interaction with testing of callback
+	# flooding.
+
 	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal=1"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_expedited=1"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
 fi
 
 if test "$do_srcu_lockdep" = "yes"
-- 
2.40.1

