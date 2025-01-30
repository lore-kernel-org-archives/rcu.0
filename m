Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE131F2363;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=aGGBfvef1msDyrvivaCvOaWIXheKwceYlY2CaL5hZlL9smZB7ww4DtEWtHS1srsxCo/y4CJ4nkZBsUEX1ZuRfltKeu1Bm5O68wxjVhMFw6qumQQSulRzJJ9wInc1wu5DtQ0GeeQPtLXIx2D04dO0YXz+m9hc/5wzdIYO/WygTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=kpykuJ6IJmLToY2NQQdfvb935dMGsfHVdSa5fdenBAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Axewec0dgUx+MJfcLOngVuNupH8v7ACKg4TopaqJOfkhdOl3TpMNwO/9RpMSR5l56qjsKCqENR4XpJby/eTTDRr+gXGKf41X2XsVIvzoqqrrFi1x/MUFhHq5LChkgNnSXIkLdsZYcHUL+5Q+K1YDnMo1it35fHIXo1VBq86gsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc9ebNk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc9ebNk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1215BC4AF0E;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263886;
	bh=kpykuJ6IJmLToY2NQQdfvb935dMGsfHVdSa5fdenBAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc9ebNk7lgvmzNSFl3ZfeuwZY4UDB+KAGqCs7IJxgcKL3SqS+PlCEyyE3LD/XVZax
	 ObsPH5NfqgzWHIBXNfc3uooXwt4QBn72dzyyR4wBTO/piBzJ6iQKdz/9h00ASXqxI0
	 SANZTHySy422IR7Tfl0cMwBMfBexVxhPZHitvHcDL8BZQ5ZoUnQmuleNJZUkczyZHY
	 c4oR+N//cZgi57sI9uqMFvzFdbNpi+DhJvP5HJ4i6oKx+EYVJUWIOYZ5KSR3YwXvqQ
	 sJBn32+OzuAkf5g7E6UhCJO5tWONtvAb6iOLWFQzbLqL+3TuH+a21f2qiSLIIm3V6f
	 tQA2kTXiLdG7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 897DACE37E6; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu v2] 08/11] rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool
Date: Thu, 30 Jan 2025 11:04:41 -0800
Message-Id: <20250130190444.1652700-8-paulmck@kernel.org>
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

The RCU_TORTURE_TEST_CHK_RDR_STATE and RCU_TORTURE_TEST_LOG_CPU Kconfig
options are pointlessly defined as tristate.  This commit therefore
converts them to bool.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412241458.150d082b-lkp@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 25a9dc2be0dc..12e4c64ebae1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -54,7 +54,7 @@ config RCU_TORTURE_TEST
 	  Say N if you are unsure.
 
 config RCU_TORTURE_TEST_CHK_RDR_STATE
-	tristate "Check rcutorture reader state"
+	bool "Check rcutorture reader state"
 	depends on RCU_TORTURE_TEST
 	default n
 	help
@@ -70,7 +70,7 @@ config RCU_TORTURE_TEST_CHK_RDR_STATE
 	  Say N if you are unsure.
 
 config RCU_TORTURE_TEST_LOG_CPU
-	tristate "Log CPU for rcutorture failures"
+	bool "Log CPU for rcutorture failures"
 	depends on RCU_TORTURE_TEST
 	default n
 	help
-- 
2.40.1

