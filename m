Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F722FBE1E;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190472; cv=none; b=JMMZRpi45+cnn2k2NzFrngnu7YNXF+13PlwiGjOpQ2EARk57e5lwHvOBGReG8ZQqPgrC/T2YlLlrV+fgvhf5whyZtYndE2KaeuSPn5xGCkKb7CFrcDaSJXxCmyuWraYkrll133JB5aoIepONtKu8B0bUrE9xAy0pj35jsZGBLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190472; c=relaxed/simple;
	bh=JLNkugHHmXHvirqch5GRg/by6Ae59kNppZL93qAl5PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMWg6jMu8dkSnnogzlESPMXMMCn4LBpDbTs0Ivmejlo9bVUMpNDXQdOrHuDTWLq0zrUOwO/a/0ONaSIGBMDFm3tNfN2U4KkvRmU/iiIIv6y69mGdB1fnmHslnLMJqYTjqI5c00LND7zZ0LnsNG+rJH+WIqHRZLpAk/eAAtZZvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLdfKOH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLdfKOH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F055C4CEF7;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=JLNkugHHmXHvirqch5GRg/by6Ae59kNppZL93qAl5PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLdfKOH9rjQXRBP0g0dMJlJC+1haNJckWDn239hjFGi+S6S+XJDUNy6vpfx92OgxM
	 j6YyJa6RLl3e6Xg4Y1KFuzmthIXvE3JcM+tbYz5UbxS+3sE9/wuUHyLMSlBk3MuLgZ
	 xxkaQI2xPoplswkFCVq8MK7Qahf/6kULm/6KDBaVxsGbo/q375SqEGp2B4tid6McuS
	 5n/Ly589cku5G0D6khDefVlfa/oK4LCRWHIZEQTlfqnYfCKyZx+15bW7XUAxSDpo3r
	 t5cfAd/3aeAupagu7tOFzQxkUsCKxyX+h/90xmoZIFHZsIR4HUS9ghk7qo+EVvhPck
	 bvS3SWN0hmMFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C32EFCE0F82; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 4/8] Documentation: RCU: Wrap kvm-remote.sh rerun snippet in literal code block
Date: Thu, 18 Sep 2025 03:14:26 -0700
Message-Id: <20250918101430.2592294-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
References: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bagas Sanjaya <bagasdotme@gmail.com>

Unlike other kvm*.sh snippets in RCU torture test documentation,
kvm-remote.sh rerun snippet isn't formatted as literal code block,
causing it to be definition list instead in htmldocs output.

Wrap it like the rest.

Fixes: 0c208a793022 ("doc: Update torture.rst")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/RCU/torture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 4b1f99c4181fee..cc57d01ed700ff 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -364,7 +364,7 @@ systems must come first.
 The kvm.sh ``--dryrun scenarios`` argument is useful for working out
 how many scenarios may be run in one batch across a group of systems.
 
-You can also re-run a previous remote run in a manner similar to kvm.sh:
+You can also re-run a previous remote run in a manner similar to kvm.sh::
 
 	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
 		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
-- 
2.40.1

