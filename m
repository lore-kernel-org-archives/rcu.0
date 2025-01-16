Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07A2442F2;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=GsZ0ykEPVA0Uy5yrUakLpjFzy1KbhVjinsr0GIx/on6rMR6ebkAbxCbde7XTtpq7Ilrm9lW0YNy0NKf9Iu1kwgQD/n1CPzOvF9EvDM/+Zh+ZIhyCWEY7pzP5N7gSE9XISH2nWKc+lBtPbGOBvIc3DHnfNCJbLayCSn9ydxYaGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=FzUQJoOG2vRf53pKk7ZYyvipXK6KzW+OBXWQI7AE6cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyQY8Akq9bIIRytx/Vzk4OJgN1gcVt8Cubo0sBxsh6pT9MpPX2aC+uzEmKJjWaUmrTECPfwVHRjOKKjvyBM3R9+g6dWVcAGdGL32cv0OXXHb/gJvqso16QV3rJ8GfL2bPkyBv45lyKMCfKkmYoyTi4NEOkM8QyBmn+693ovmyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQHUixO3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQHUixO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA4C4CEE3;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=FzUQJoOG2vRf53pKk7ZYyvipXK6KzW+OBXWQI7AE6cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQHUixO3pFJZzFxKKPs1sKd6qZjJuvRn0JUTQfurNb1Ga4pSDjKrnQXyVBWVXjOA1
	 Fx1lJ2tPA2n8W452vs/XfWMipTyFRgQzJqODAE8MZd7tPmaeicidR8uboJIVaU6d/4
	 F+CmRIva/6KM/kkE33cJsDqt3AuhZj+CqlVXCbkqupq9cZ4qW8T6MQpLv4T1YpvIR4
	 kY4/3toiQHyNUCcu+jODNQcxyK2yZ7mMne3DWVwXl/xevzKcGOpMCXu6a2ZV+Px2s7
	 Si8zvkzGZNzjq2P1B5nrfeA9/JGkT9micbcVq4Ao3vusmGZ6xsuh3x2zA2P/SN2PTX
	 WLCarn18tOixQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B55FDCE37D7; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
Date: Thu, 16 Jan 2025 12:24:33 -0800
Message-Id: <20250116202434.3783613-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
that have NMI-safe this_cpu_inc() operations.  This makes the underlying
__srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
difficult to test on (for example) x86 systems, allowing bugs to creep in.

This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
forces those underlying functions to be used even on systems where they
are not needed, thus providing better testing coverage.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 80242957fa417..aa42de4d27684 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -65,6 +65,17 @@ config TREE_SRCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
+config FORCE_NEED_SRCU_NMI_SAFE
+	bool "Force selection of NEED_SRCU_NMI_SAFE"
+	depends on !TINY_SRCU
+	select NEED_SRCU_NMI_SAFE
+	default n
+	help
+	  This option forces selection of the NEED_SRCU_NMI_SAFE
+	  Kconfig option, allowing testing of srcu_read_lock_nmisafe()
+	  and srcu_read_unlock_nmisafe() on architectures (like x86)
+	  that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
+
 config NEED_SRCU_NMI_SAFE
 	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
 
-- 
2.40.1

