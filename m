Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37E26290;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=cYij2NLc4Frl2AZInQdudpUP8DbIgM6ZPBHBKhi20gH1GKOKQs0QL3sYqJuDbgHgBYWbmzwOSyuZ0RgSKWhFyuI6o/TVnavxhsVTs/6b/AQIDJ7kW89n6M68A1rA8na0LkpLimRJqBOLKXr/FhvKR0qohzsGmDzY568nvK1LKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=jJfIUtEDWjKmTQ75RA/L6ODvVHBRzgs6f1hgAtKNxGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X15bSnRa2tija7xMck5/VOj4P5Jw04J1JvMzAkvuyRd5/hiOx9RQy1Fbxq8k3ah5WWWOREnqrsswDanaEakwVnC8oTWLuk3JJfgLFblN0JUO8QBuqYq8ZSiFQrkZy8QOuCZDX/nGhOtBgmFJCu81+UrenqdaUBSQCQiUtpQXKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6qmXdU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6qmXdU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B2C4CEF6;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302920;
	bh=jJfIUtEDWjKmTQ75RA/L6ODvVHBRzgs6f1hgAtKNxGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6qmXdU26VDBD09o87aHK84Z0pHZdW7IJEg6XF3nqO6bfo/aEPEZuA2BWuFaDPHqN
	 cTWaK0wmYLJvq40LWIBVZ8e9lOk06QXqljzOBn6b7MJxhnU5zNBlCLlzi693urnm1/
	 LC+0/LFKZ9xXXfYsuIp6Y9C+03TIdUyw9SaDypG6Fp0GXEVCTArt+iC4Qi1EPFsGr/
	 tJfCPxsNbNYfr4vlwaFZWD5JwdVWbHpae8RRFBTy76kMROTTOlWVZEnId4wBslmWRO
	 xqaUtdYQmPJ++/WNj6YUMDOnUAtX2dm0z9Lq3ZsJC8X/aIdW6jEenJd4UGvA+Iprsd
	 9x/vFpUoaZYbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1FCE1CE0EA9; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/7] torture: Delay CPU-hotplug operations until boot completes
Date: Fri, 15 Aug 2025 17:08:36 -0700
Message-Id: <20250816000837.2622858-6-paulmck@kernel.org>
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

CPU-hotplug operations invoke stop-machine, which can hog CPUs, which is
not a great thing to do before boot has completed.  This commit therefore
makes the CPU-hotplug operations hold off until boot has completed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index 5abb4b25d971cc..1ea9f67953a766 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -359,6 +359,8 @@ torture_onoff(void *arg)
 		torture_hrtimeout_jiffies(onoff_holdoff, &rand);
 		VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
 	}
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
 	while (!torture_must_stop()) {
 		if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
 			torture_hrtimeout_jiffies(HZ / 10, &rand);
-- 
2.40.1

