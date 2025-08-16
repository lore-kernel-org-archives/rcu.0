Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C1BE46;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=olrHzQZzFLdIlsgIpMWH2DeOk9RBqWWKdkuJ6yUY9qNvMsH2aHCcWZ5jHO9X5zEd4OwUVcfNkjsdawWIIYzScd/SVl7BMVw/r9NPZjwD9u2ZOttyCZxhsy1Cy5pRrMOeGG2mEiSyU3QjAKKNM7arTMkiexFOHpm/m+2Xsap4MGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=QRMj3cfejFshQ8gBkMpPIHQRTiBKhfo6s4NoeWXO8TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3R5CIu+GYRDGdJLdc2CrweRYj22aR8183S+cnU4DHwf7h1wT1sgg5b/5UlOg6Fwo2/XwVChIBDyncYFSPHmRl23kH//GmX4CLyikrYjXX786XqnRlFBzYdWX0u2UL4Nq1C05BzsE3dmf0SUmnFe4cmozXGsoBULTXsCT8caZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQQ6jMrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQQ6jMrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A61C4CEF5;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302919;
	bh=QRMj3cfejFshQ8gBkMpPIHQRTiBKhfo6s4NoeWXO8TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQQ6jMrwTMk5BIj++yBMB1liZSzWDXLOTQaC2LXspZGdoJx4AxkJLXsBf2zFgYvtA
	 AQYk2oCB1nVVUDlLZJZg43uzoIa7gKtj7SXObCmDPQg+niLwmHJc985vcO0iDJNlSv
	 DqIt5+g/iT+7KZ9buOyy6xkXgZjvmlcgwVmT+iGEhHlBlTyb7VdV6/H6+xIpJu0+mm
	 rXHDjiyv+JHe+kdsu17znIZ6ocUbIl0kKa/pQXxTD3QdL2EmtV6wUGy2X3GrAdYw30
	 802/TzffghkF9prHZl3IylMcjh94XEafXZrcwYU21sUw+LCRG2rq15wtA2q9/UQ8fE
	 qFawTKfHYi76Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1ADF2CE0B6D; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/7] rcutorture: Suppress "Writer stall state" reports during boot
Date: Fri, 15 Aug 2025 17:08:34 -0700
Message-Id: <20250816000837.2622858-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
References: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rcutorture is running on only the one boot-time CPU while that CPU
is busy invoking initcall() functions, the added load is quite likely to
unduly delay the RCU grace-period kthread, rcutorture readers, and much
else besides.  This can result in rcu_torture_stats_print() reporting
rcutorture writer stalls, which are not really a bug in that environment.
After all, one CPU can only do so much.

This commit therefore suppresses rcutorture writer stalls while the
kernel is booting, that is, while rcu_inkernel_boot_has_ended() continues
returning false.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7a893d51d02b6a..49e048da4f6810 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2756,7 +2756,8 @@ rcu_torture_stats_print(void)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
 	    rcu_access_pointer(rcu_torture_current) &&
-	    !rcu_stall_is_suppressed()) {
+	    !rcu_stall_is_suppressed() &&
+	    rcu_inkernel_boot_has_ended()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-- 
2.40.1

