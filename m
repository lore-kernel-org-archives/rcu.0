Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B25413220;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262237; cv=none; b=g2TlN4oakXFyoJhzeiaXYGT6m1kh+kugoROZ9tObKN6cDH0PbZkKHArUHu2byzbCECDmCjSjI8/S3zC1wmp9XDr0RcImwFbCxWejGQfB8GWOki5KkUNlmUrGfa9cOyv2rOKT+Rm/a8+U+G0AOqC+3kgZ/aa460uRzz7SKsJy9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262237; c=relaxed/simple;
	bh=Ju+wGquknA9vH4d8msEHqAowyOOhmN7jnTkXKOHQ2O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iI7tQG6PDO04xQO8wjDA/pu97BrDCfU0QirJtUIXHpmhrTc4mbjb+8pz5PML/N7bsMzHjQ1BYGleBr4IVpSwgVRgdcKufs8Ru8cAQXyYwwHTMiLXjWSLgLO8gjeR/BLdD3oN3NbSnaj4ZSMqGMsshDSzc49bAJMlw3859PYtEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNFOo/Ng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNFOo/Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BCC2BD00;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262236;
	bh=Ju+wGquknA9vH4d8msEHqAowyOOhmN7jnTkXKOHQ2O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNFOo/NgnJlFtaGTQ8E6ByezEjtaiDmKCNdMOOLo0oWWINjsTfYS30tZGRo0EX0dT
	 BCumnYiLBetPRSGFHBch42qjwDtRSWOvdkNhictc8Da0lbs+NgDzkm3vp64T42fzFB
	 Xf/V3F6YNbabxzLVrkXONzN3zvDvVsHU1WZY5f8PQfD87ISMubieDNWykJ0c/FutaF
	 wTR1Wdc9G3UB2Ix6aXrpeB7gIMn8c6TAR6b0EWLphsIIt0u+/ajJqetPp+HjSNWLdH
	 xIWnyRfPovV5IL0vVmRzMFwHF8id3SXn4SPUj4JpeKhrOz8hjWu33Kifm6U3segIwk
	 9jdXcm/YIALtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 45DD4CE0C96; Fri,  8 May 2026 10:43:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/6] rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
Date: Fri,  8 May 2026 10:43:52 -0700
Message-Id: <20260508174353.905746-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
References: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces a nested ?: sequence with clamp_val().  This does
not reduce the number of lines of code, but it does simplify the line
that it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e46a5124c3eb88..09f0cef5014c7c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -492,7 +492,7 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	int ret = kstrtoul(val, 0, &j);
 
 	if (!ret) {
-		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+		WRITE_ONCE(*(ulong *)kp->arg, clamp_val(j, 1, HZ));
 		adjust_jiffies_till_sched_qs();
 	}
 	return ret;
-- 
2.40.1

