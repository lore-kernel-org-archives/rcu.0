Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A791DFFD
	for <rcu@vger.kernel.org>; Sat, 13 Dec 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765634131; cv=none; b=GxfEqMEfaPRXTSOMK4oeUfbCc5yjqcaCUr9YmeLhHUVtXmmRwUiJ1Dx1PS/rKw4Bq3lsFYFLiUKiSzbvJseSqwzR6H7ysFdATJIFEz/Eo51iXCP5VYrh0sICe3wVVXNGT0jP7bMqadLKoWY5ZfIp1KJtZD0etPOg3wkJtf+3O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765634131; c=relaxed/simple;
	bh=7yFrnnYI8V+mGJpc/4Oc8imlRFtWDpqUgyQ7N5/VXLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6xLK0x5TvOP9kqPtDWNCcVe7UEROGddljxO7KUm5r19EuhNavydI/8vxIPNVMZ6N68V4aePKLJXuHUwcZHv4W59ciHGkGoB1FfDK3Z6Vd1NbGWIGBFGevLKht5xx3hCVyO7PSLMX9DSHxcAX4jEzL3/VDGXkRGKKjDohrl8bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ynl/AaOs; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ynl/AaOs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765634126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45Kf3FsQ1MvLApGs+FTfdMfQFsuGSFGLBUy14NaVbxs=;
	b=Ynl/AaOsXN0Wx8ubkGj+36Lo/lA+pXbzVOV404pJDLoyqpI3X8rK52NDDN8KSHE5ZJLGra
	UxSI9zllwyPx6wcT3OYBunIDdWzV3CM/wssK7oxpseZXLg0npNedk4C8UtHCx5hQanKsOi
	rc6XKLepwhpv+7v2Cz64NPosp67bojU=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] srcu: Use suitable gfp_flags for the init_srcu_struct_nodes()
Date: Sat, 13 Dec 2025 21:55:18 +0800
Message-ID: <20251213135518.109887-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In some kernels which is set convert_to_big to SRCU_SIZING_INIT,
for use the init_srcu_struct*() to initialized srcu structure,
the is_static parameters is always false, the memory allocation
for srcu_sup structure's->node can use GFP_KERNEL flags.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ea3f128de06f..e4571b569752 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -262,7 +262,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+		if (!init_srcu_struct_nodes(ssp, !is_static ? GFP_KERNEL : GFP_ATOMIC))
 			goto err_free_sda;
 		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
-- 
2.48.1

