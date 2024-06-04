Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D614D43E;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540595; cv=none; b=AC4JcfLTyp11V2SXJJ2GvGC3Xjd7RmmfEgXmjRHuPP+gSwEPeUsjlIdZ1kzv/2ETzUCXPho6iya0DnQ4yoQSbWf6M030mVW108zQoWNCr8WRKeq/1wLqDUysXdJ0qpRIj9kTfFCmtf71uQ9w4mtsoSlj5QnAjL2fszXN/v7yMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540595; c=relaxed/simple;
	bh=A1B89F6f71BTaBD2c6ys6oWMLDn6LLn8Xrl2YURYyWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOGXLgkSoaZnhF5wIdx+gRlh0rgcTAVSfD+Y9FGeZwd8Bzhxc5UJbIYGzTi3rVCH4B9+pRVWC4BLVCpeZgAs8sPmm/kSRfuBxSdaKEHGUUhI8de0JgiZLUrXX8ZdAXeX6UQXgz8StSuqsiuEuxhPAOHYgivRBf31HIK0OTcRGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjtHMhPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjtHMhPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B587C2BBFC;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540595;
	bh=A1B89F6f71BTaBD2c6ys6oWMLDn6LLn8Xrl2YURYyWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjtHMhPWw2cR4PKJ4a0oFaDUSfzScELdWeoI4yGMOj6zZsTY5rpLw4sHKmci/EDZ/
	 YMAlVPmKdbylzk/bLssle5qYVVtiaQkLDmcX2mboeOxYQznzlE2GEEppbSeuB4jT1O
	 JLyT1qg1Vv2qWQYSvcsbKAixmlFLZNvEqoWB/IMppEDrOPTKUyfPBfb1WuPW3GcGaY
	 SBiTP6nNBzvnkZ030aBFPgn9Y7qt2EHZUtKnEpQvUGqUpi8FsJrLCD5+lQyratdNq7
	 eIXom5hhimQr3PhG3pVl/QNUW0+yVjH4dbjqtbZ+OOv3FkJlq5c6ivT4VuQQEVzods
	 XPbom4jpExVMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF4C3CE3F0F; Tue,  4 Jun 2024 15:36:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev@googlegroups.com
Subject: [PATCH rcu 2/4] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
Date: Tue,  4 Jun 2024 15:36:31 -0700
Message-Id: <20240604223633.2371664-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On powerpc systems, spinlock acquisition does not order prior stores
against later loads.  This means that this statement:

	rfcp->rfc_next = NULL;

Can be reordered to follow this statement:

	WRITE_ONCE(*rfcpp, rfcp);

Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
this statement:

	rfcpn = READ_ONCE(rfcp->rfc_next)

KCSAN located this data race, which represents a real failure on powerpc.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: <kasan-dev@googlegroups.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 44cc455e1b615..cafe047d046e8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2630,7 +2630,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
 	rfcpp = rfp->rcu_fwd_cb_tail;
 	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
-	WRITE_ONCE(*rfcpp, rfcp);
+	smp_store_release(rfcpp, rfcp);
 	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
 	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
-- 
2.40.1

