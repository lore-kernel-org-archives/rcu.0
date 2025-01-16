Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE23F269;
	Thu, 16 Jan 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057762; cv=none; b=gnBaNt0REXU+6H68uFwZ132ur8Q6f6N7wrWMbMQnlq6MKJ62gLuwk6rImqCUMoZp3xDiTbKof7IyHMyAV2oErd57J2841ckP2QhSkGPiPjspOjluwO3hnF1rr1UPwTeQVUGjctK2UuoNxaEVk4BLM32K0DRLdBoXxBGDqUZj0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057762; c=relaxed/simple;
	bh=nCzBiBHz3M2xxT1NTdXIMhRys/kvq/wbFX7EYoDah+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=inuuzqddOIqOdtfULxIPZmQE1hKe2Kgt4okz7md3jlhwuuNmQNZ/EH+aYWZHmOLSUszAJWG4gQobib8UGVzTPBfzkSqtmaNxe6ETdCU5mNt0M/eCYPaS+oPOM+fVvy7vNhPc58lt2RaI99ppfnlXHoe0xlla+6PXHtT+UhrhYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEcvtssV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEcvtssV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AA3C4CEE9;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=nCzBiBHz3M2xxT1NTdXIMhRys/kvq/wbFX7EYoDah+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEcvtssV3oT38qFLKH/36T5Z2kPdhHLdBFij255x0R67OP5KNYWBp1/Yu5s8vMGMf
	 wPVwQLxawWj8Zulkjv0+0v3SezcxrWly8FqsrkXQxBiZKqcCz8X+JkU2mrd5E1cdRd
	 cQ13/84dD+OzyS4RW3tGwOOpsLjZxyqYLOosjhLPMQY4IKHojK++O9JUEeo7/3bBHW
	 hTeJaxikTKpjC7htp4PhAjDsU2JScTjegjsvbyVzto/MDMryCbXOWZZhBRUV5iPxLA
	 f3j9XIXvE6ioh4Z5Z0HpGnkYpkzjGOubAwmGkuvX996CY+qeXhhVtZyj7/fGRhjIrm
	 GCuDNmI9v76mA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 349F7CE37C4; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/7] rcu: Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text
Date: Thu, 16 Jan 2025 12:02:38 -0800
Message-Id: <20250116200239.3782374-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit wordsmiths the RCU_LAZY and RCU_LAZY_DEFAULT_OFF Kconfig
options' help text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185db..2bb22dac3b5a9 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -323,21 +323,27 @@ config RCU_LAZY
 	depends on RCU_NOCB_CPU
 	default n
 	help
-	  To save power, batch RCU callbacks and flush after delay, memory
-	  pressure, or callback list growing too big.
+	  To save power, batch RCU callbacks and delay starting the
+	  corresponding grace  period for multiple seconds.  The grace
+	  period will be started after this delay, in case of memory
+	  pressure, or if the corresponding CPU's callback list grows
+	  too large.
 
-	  Requires rcu_nocbs=all to be set.
+	  These delays happen only on rcu_nocbs CPUs, that is, CPUs
+	  whose callbacks have been offloaded.
 
-	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
+	  Use the rcutree.enable_rcu_lazy=0 kernel-boot parameter to
+	  globally disable these delays.
 
 config RCU_LAZY_DEFAULT_OFF
 	bool "Turn RCU lazy invocation off by default"
 	depends on RCU_LAZY
 	default n
 	help
-	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
-	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
-	  it back on.
+	  Build the kernel with CONFIG_RCU_LAZY=y, but cause the kernel
+	  to boot with these energy-efficiency delays disabled.  Use the
+	  rcutree.enable_rcu_lazy=0 kernel-boot parameter to override
+	  the this option at boot time, thus re-enabling these delays.
 
 config RCU_DOUBLE_CHECK_CB_TIME
 	bool "RCU callback-batch backup time check"
-- 
2.40.1

