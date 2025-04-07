Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDC2566F6;
	Mon,  7 Apr 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053143; cv=none; b=Py2wMDpCabB2/vUNpG1ZSdGVjuSv0fMqqi550n1neS42v5TdSR+33U0LsQRCeoBEXIOTWwWAVmEN7fqiTwq+iBryjSgSWVGjDVJgYigY2mLAmveVpahY0SutgxjVNnOiBxpRpn3bAEvJd1IxQVyl5Iso2/IODVzwlfExu+jdW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053143; c=relaxed/simple;
	bh=jEx10nXkxWZfbgeCLV0kiMzQpsPB2G0pv78AeQrWU9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlUe/Bov+gb14Jlc0PhdR4ijX7w1qa2lRqcmefvgBYLaogx0N+pDH7+jrvsH5h3dXt3k80un6hMi3yaLaU86ZGvXz39PyXQyZ188zjFWv4glYW72BelBA98lIWKrSKTwH8PkDf/8+wcR5iAxfaDIBuuXvH824tkMvRFGTs7JFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ6FW7Gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ6FW7Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D864C4CEDD;
	Mon,  7 Apr 2025 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053143;
	bh=jEx10nXkxWZfbgeCLV0kiMzQpsPB2G0pv78AeQrWU9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ6FW7GrOrnAS8QoLr6hRiQ9dmrRcLPmJ7925B7sSJ98sIzd4UPF02fL08zspqm6Q
	 QyNwcnjv/QPein0LNQo/yI54XFmcC7oLY2vN9OSmYjq02R0OlDv4/6wrJ4sgw4ecev
	 QTgplR8EQdHLlh22eRmbE6PDoVNMu65JKKJuyB4iWo4WyOkIIofrS7kiUBBlmKpuMp
	 JfqDXGOU2WO/gBWH8hHdrWGaUnB9/2lXiC1MMcXaRU9RH4QXqy3VdO042o/AkwMKMG
	 WHOKzG5yZf6jBQMRqfsRTgUZpQuMgmIzO35AxVfF5+8ffoq3WxmRBYLZ03w0XHOFci
	 UmkU934ZxqMDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E0625CE089F; Mon,  7 Apr 2025 12:12:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 4/12] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Mon,  7 Apr 2025 12:12:21 -0700
Message-Id: <20250407191221.28679-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250331210314.590622-4-paulmck@kernel.org>
References: <20250331210314.590622-4-paulmck@kernel.org>
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

[ paulmck: Apply Sebastian Siewior feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0447c4a00cc4d..d53ee1e0ffc79 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -448,13 +448,17 @@ fi
 
 if test "$do_rt" = "yes"
 then
-	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	# In both runs, disable testing of RCU priority boosting because
+	# -rt doesn't like its interaction with testing of callback
+	# flooding.
+
+	# With all post-boot grace periods forced to normal (default for PREEMPT_RT).
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_IDLE=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y" --trust-make
 fi
 
 if test "$do_srcu_lockdep" = "yes"
-- 
2.40.1

