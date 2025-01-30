Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD51F1905;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=Vwmh+Qvpica5wrRYpHzexAWGI3aB0AXV98u4Z6eGZALcYAC5EK99TgeCtpByz1X6vygZh/Q7ZvrTi6piN3xuZS572bstNL0mwRrNqfg36ibOFvrmBhG4FDcIUdyQsQ+bt4Bz69QQLP6GZiaMvncFhtheQDU7Mr0XA/wt9sN9QyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=u55ZypZVyd+X4a/b4SkVBvQX3vpLjpwkxYZWyIr57Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eV3nHXoPNtb+FgLuMz/8RX7WRv1IGSHd1fkq0m8g7FWbJdNUeQ6GOXNMHXKBr4ZJQL/m7ge+IOLIS6w0IeyHcdpAUFlVxQjkHLdJgrgS3QZoP0evLxspFscpYD12orKPHW7E0UJnTAcHnEBGYxnRHRShZmk7WpW5W2D/T20Wh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+BqoyY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+BqoyY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EC9C4CEEA;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263886;
	bh=u55ZypZVyd+X4a/b4SkVBvQX3vpLjpwkxYZWyIr57Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+BqoyY9SxAotso34A2OTZ/fiEi1scm5A6Tiz8n1RbOF7rUY/mxmHMMjrr8p9063e
	 fgbWBDbaox/zkNJGMvlrxQJjGPZwvhFXZA7T56DEE3pZnzV0L9VwUbMDFmrtLEQdbX
	 h2j1OC/mRhyKc+KecgK1Nudj7KICTRd5yXcToC+RwSlvF+rPWrvzR5phO7AbNG8m2e
	 /WLppJWdH1oZYZCGJv4BQZlApujuXsL5/c5A3Wqmh5JeTHV+wZKzaktPFVfuIEz6rX
	 +xozet2EyTb2K27iomTjEvvub+huivs4ooBqU7RSGIhqaTEsOZtjnaT2vzIIhnpbm0
	 CzZTxBuX4EAog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E82ACE37EA; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
Date: Thu, 30 Jan 2025 11:04:43 -0800
Message-Id: <20250130190444.1652700-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
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
index 80242957fa41..aa42de4d2768 100644
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

