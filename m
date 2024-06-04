Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C7140366;
	Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539448; cv=none; b=q1AwsXo0gOIPvl4TMz93zTQQtZgxXf4bUITXtoTSUzIoVUfgwa6r5SNa3YzEBwgOjr86zB7ylYsQh867KBLGWf9tA4IPo4F6ULeb/j+t08cSDgVmKawQ0tOthb+7kuwJJcNwoGuRIm4njDMC4rsyCgz6wVfGqYxzmADrlij2xK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539448; c=relaxed/simple;
	bh=3sTuhEIqki7FaL4kwzJkR9X049T4EZBPLj2WC4tkn4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOoXpr5Di8ug9mRapn5PFdd4qfJfb3ddEupjrF7AriiRgF2G/rnjfoAVqsW1E/MnNu5M7p/CXeN3NnmCOsem9/cI0khrdUaUd3g+l2sIiGywcViAChC1n6mZ1yvXfsV6FW/DwVKRV8SXZ9avW2cDaFhY7aw6mbFzohR64dguNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEpQweZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEpQweZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE74C4AF08;
	Tue,  4 Jun 2024 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539448;
	bh=3sTuhEIqki7FaL4kwzJkR9X049T4EZBPLj2WC4tkn4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEpQweZ4QVm5yucgSuujvq4aP7PN3Mak2dmbpmT+ye6PHkoDZ/uZTU4qBY3C51sYr
	 YXHD5CC6aE2hEA8OWiPq2ETReSvM5REP6IcDDd5KsPt4Q84iKsa0PW8os7z1ahjbi2
	 0NqbJWBNsUy20o54YPIFTCJd59SQql2Y1Wc99OlrUOrhLpd/kD0Yz2sizRiWNPq3UM
	 9zHboM7s/t5VBeBYEo/S4damtUqcGvGURTr7iaGR1BKLWeCKYdDsQjmpoLagVKXfT9
	 c5ldU2cClHpQu1dY0shfXKWo/+JqRdcvqlqiI2pc1NFcli0Aszh63Y78fESMvoEA4+
	 Po3/xBQaBtodw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 940B1CE3F26; Tue,  4 Jun 2024 15:17:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH torture 3/4] scftorture: Add MODULE_DESCRIPTION()
Date: Tue,  4 Jun 2024 15:17:25 -0700
Message-Id: <20240604221726.2370316-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
References: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/scftorture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 59032aaccd183..c20c6eb8389d2 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -43,6 +43,7 @@
 
 #define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
 
+MODULE_DESCRIPTION("Torture tests on the smp_call_function() family of primitives");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 
-- 
2.40.1

