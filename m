Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DAC133;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=eT3hYFbiZBHg1ByrS1YkNNZReLBmt9B12HreY7XorwCYNu9HAgIJaiT85vtD2xRcPfmUCxJVCVMU3LPo3xoEdUJp/I+yxl8rFR754QJ3J05rzAVoW2Artc8kSrIUQQ3nyHdeS3crTmV8BotyQtbj/6MlQMFt/KPOMu/6VUwLWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=o0RHpAqGikfODESDcNqT7pVVwVOSWbUKhTNHQn++MVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3CY8MnAH0u0r29qWGCwJaIFAMVTskvMr9we7taNqa/K80h1545jA+P84/Na98b+B5TN7xsPYb6bcBwv5x0Ox9XdJJpWLyTEeTEzBLlVdsRBNcrpG9Y73zNVg2kyh0/K6OyNusW6R6X2WLipQLQSLmUZ2riPfsP4QSbLrcbpayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azk3Iiys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azk3Iiys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FB3C4CEF8;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302919;
	bh=o0RHpAqGikfODESDcNqT7pVVwVOSWbUKhTNHQn++MVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azk3IiysjTqolV3J6YDwq2I7o4DlHtvpZh/bE+SvJckNG9Xro8x5i4wJtgGEvmmex
	 OAawxZcdDYAVysaxqZlgYr4cfQu8g+JBfDHc4eeCyT1JJ/BPTyU88XstP+VRW11PGc
	 H/fhsBoIJ0ylNyc1N6bfls54Ul1blvX6DnYmEkeeIn6eHtDVfpl4XLTdzZje1OVzwL
	 mCPlTqnRs/xilAxF1wSoX2irh86Wyv9ZkMszPI7XUrLJjtKZYCZNkmNr9KilK0Xl1K
	 M4sfgDBAUb7bYFGCzjgCcdnJSu626mL3HCbD8QYZFyNnTtzEG57IhtpzCuV6oJVQhy
	 eERrtF0olIAUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1872DCE0B31; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/7] torture: Announce kernel boot status at torture-test startup
Date: Fri, 15 Aug 2025 17:08:33 -0700
Message-Id: <20250816000837.2622858-3-paulmck@kernel.org>
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

