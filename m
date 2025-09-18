Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AA2E54D7;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191394; cv=none; b=hznGG/sEyfFnRRNJod5ryp9/3G2VaJytTSXxdZ7r0kVQvRc6oxW/nJPnVe8hPYYhvgllFLLe78ekfRqlOZpTfdDhG9mBnzR/qAXHTZSEp19pa34KBY3YKUXqWbg5gC8pBw2mlRRkp4KdjiykmmSVkePqWnkTNMtyXy0xnf+8KWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191394; c=relaxed/simple;
	bh=o0RHpAqGikfODESDcNqT7pVVwVOSWbUKhTNHQn++MVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+tFth0hOnM+dYF+VTM7+3z7yH6rYaN6albwVxWpQD0eDkAKTMAJR9EA4GwZDKBz5WPHcoYJorRtEAWwIQdNUsvNk9j9ATXXDSq08Zf9vrw/OpAumAa6wjVtauD9oHlBF+OSyeW0gwUc0bmnhCCBW2XHmoX8JCcnfxqu8AKm5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCXJfzoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCXJfzoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E64C4CEF7;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191394;
	bh=o0RHpAqGikfODESDcNqT7pVVwVOSWbUKhTNHQn++MVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCXJfzoYKrKFZMs0Lo8zdGGEHsVVsyem4sEjV+ubWxUpPsyXf1HwZqzblPhl0Ynsa
	 G+8R4LPqX+U2YhB9DdyneKkFfY+MUCJFg/vBBnoLPPyGmhUpcWt7fidY0PSdbl9ISb
	 KPvizJN7Lj6Gai3qjyJ24qbOhk9MufiKHYZW+WfhnYiPlJmRarKx5+EBq9JpCOkwEP
	 42h/mFZBCAB9FhAnMYYQ3kTRr6fn8tgnbyeNikE829y+uXs3qlQSMVAyK7qWVZ562g
	 tnulNNOYzJ0aWwQcYZBm3GKGEqKXbkz6VWpgq9AqHmP7Gu/zz76zXo/Mq++b0RE5xk
	 CmVGIqG9FdFFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2F1BCE0EFF; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 03/11] torture: Announce kernel boot status at torture-test startup
Date: Thu, 18 Sep 2025 03:29:44 -0700
Message-Id: <20250918102952.2593045-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes a given system takes surprisingly long to boot, for example,
in one recent case, 70 seconds instead of three seconds.  It would
be good to fix these slow-boot issues, but it would also be good for
the torture tests to announce that the system was still booting at the
start of the test.  Especially for tests that have a greater probability
of false positives when run in the single-CPU boot-time environment.
Yes, those tests should defend themselves, but we should also make this
situation easier to diagnose.

This commit therefore causes torture_print_module_parms() to print
"still booting" at the end of its printk() that dumps out the values of
its module parameters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 3a0a8cc604010a..5abb4b25d971cc 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -797,8 +797,9 @@ static unsigned long torture_init_jiffies;
 static void
 torture_print_module_parms(void)
 {
-	pr_alert("torture module --- %s:  disable_onoff_at_boot=%d ftrace_dump_at_shutdown=%d verbose_sleep_frequency=%d verbose_sleep_duration=%d random_shuffle=%d\n",
-		 torture_type, disable_onoff_at_boot, ftrace_dump_at_shutdown, verbose_sleep_frequency, verbose_sleep_duration, random_shuffle);
+	pr_alert("torture module --- %s:  disable_onoff_at_boot=%d ftrace_dump_at_shutdown=%d verbose_sleep_frequency=%d verbose_sleep_duration=%d random_shuffle=%d%s\n",
+		 torture_type, disable_onoff_at_boot, ftrace_dump_at_shutdown, verbose_sleep_frequency, verbose_sleep_duration, random_shuffle,
+		 rcu_inkernel_boot_has_ended() ? "" : " still booting");
 }
 
 /*
-- 
2.40.1

