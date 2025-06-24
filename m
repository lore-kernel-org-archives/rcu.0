Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFA3595C;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781643; cv=none; b=Sfkn8HoElQ/j/GI5xENP35jOhngXM3j81PEXdI5sc6DR0x1xo9c+2fttD2mpNnYM4OjxB49SLg5rCh+kmJE44ppdxgnLF9KOBimPDpI1EtYxV75Yofykx4Y3MK/J2IdZeRDcAD8dBvGvreZh6m6BdBmdkHw/tDBzqKLZC6cb++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781643; c=relaxed/simple;
	bh=+RdBW/rgysCuyXXUZzubKiF57XyQfZ3OaDnudhPV6rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsqKhmSGqSEvnzrMk+oePUMtgwn7ah914XpX5a5Asb3LpR6PcXuIMSnb5ly8wBwFNnlMzm3vvCvRwuGtyZ8688nNHF8/s8RtpMgnaiaxN0tiLUXv1TY1MsCWI4tI1Pz+qvUUIeZIOyDvxOkwEpCRRxuZtAXMInmEYb+M9tb9jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hloAorf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hloAorf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175F3C4CEF1;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781643;
	bh=+RdBW/rgysCuyXXUZzubKiF57XyQfZ3OaDnudhPV6rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hloAorf87aI3FQkbu1vkEf5c/MAUD3oWuOsOHfJMMaMuRd2wnb5zpYjrYyca7FYYl
	 CA0o8sotp5FG1NVZ2H+BZn/TdD/P0PGZu0ASnN8UjZMEv8AfSjvR8Ab4ATaUpL0Wap
	 t9etOul17EV/g2/FMLjh1+nmCpPJ8yZP7GRdI/YkPTDNFaMZaa+xpdvmNjFdlaPEQs
	 6j+B6kt7jInQ9emOWuHWjAt/IuM5PdfNJiKUfpi3MATpw5WCS6wkTswVDI8fBBcCLw
	 9ckXMR6xfHa1aoHpzsUPsZb1JVQ/1l28lH3TpnptsrMyr7n06+EPc2J/C9A8cPSr7i
	 73BOJMPPSVECQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83409CE0B73; Tue, 24 Jun 2025 09:14:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/5] rcutorture: Remove SRCU-lite scenarios
Date: Tue, 24 Jun 2025 09:13:57 -0700
Message-Id: <20250624161400.867880-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prepares for the removal of SRCU-Lite by removing the SRCU-L
rcutorture scenario that tests it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L  | 10 ----------
 .../selftests/rcutorture/configs/rcu/SRCU-L.boot       |  3 ---
 3 files changed, 14 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 45f572570a8c3..98b6175e5aa09 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,7 +5,6 @@ TREE04
 TREE05
 TREE07
 TREE09
-SRCU-L
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
deleted file mode 100644
index 3b4fa8dbef8a9..0000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
+++ /dev/null
@@ -1,10 +0,0 @@
-CONFIG_RCU_TRACE=n
-CONFIG_SMP=y
-CONFIG_NR_CPUS=6
-CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_RCU_EXPERT=n
-CONFIG_KPROBES=n
-CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
deleted file mode 100644
index 0207b3138c5be..0000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-rcutorture.torture_type=srcu
-rcutorture.reader_flavor=0x4
-rcutorture.fwd_progress=3
-- 
2.40.1

