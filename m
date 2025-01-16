Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03192442F7;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=a2uRdWEPr3N33EsX6KwATLbvzw5jGdVKZle45BqrIR6VZJJCSNz3Fn/luB4vNNgAMNAnLRPZ+crVEgFvZnnCPHEt+W5Q58TZ13lywfdQDV141mnkhLbM7FYvN7CPODXe4qBEObgGf4/mhJraXqg7d7Ea9SaQomUvZdP8xBaoYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=Y0UpprIRJnbbVRDMHgt1RNMyLVEianVXZ68KcrsvDn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwuV1BEfaRaTysp07FfbSI/FrMAmUHsCRuTx3sa9DPH+F4oRn8uK9Rg5YJX0QZw7Z3WbToVYSnE1K/jED6sssgNGvjyzX0+A3Reta15tGkDf4EC9bziNwZPKDicETe4uns3cux8LzGmHfmLiDhec5gihsFXrt9u42l26ZRMuTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqzPDbt4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqzPDbt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA20C4CEEC;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=Y0UpprIRJnbbVRDMHgt1RNMyLVEianVXZ68KcrsvDn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqzPDbt4D9MPcaHKPshOX/OkWhoI27wrBL6gWh29ZVtNZ95Bo5caDeIw8C/O7ScbV
	 pdJTi0CpDPkBn0duzsm8UFDkTBopq1QwYeHzmrMo1r7xYUgibGzfgOJZ/Zz/ShgIUh
	 OnLkehn4VVjzHeunehDGCcdI3MuAWvOqNAJQNhV/3F71j0IWgzoMWJ+SbTXByWZ4o5
	 1+Nd/oX36DWS2QWVaLcklHydk889ixxsG3/So/sQV8HK7oRouIfDHlzQqV/DbrMAjc
	 xiShTileXpoxjarCo46JFWP9tOhq1ESGzZ8ULj6HrV8kulj3kKCBjn4rBCv3gPHog0
	 f2QPM5U4LVLBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B12F1CE37D4; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 08/11] rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool
Date: Thu, 16 Jan 2025 12:24:31 -0800
Message-Id: <20250116202434.3783613-8-paulmck@kernel.org>
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
index 25a9dc2be0dcd..12e4c64ebae15 100644
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

