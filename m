Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEB39935B;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173040; cv=none; b=SA5vvdsZ+6m78+tGnGYSFj3Rpmh+301qRLnkaO0bplOsEU5P+rWpJhkU+lrENLGGVFVDn6/7HLjh4v16MX7Vi2zf3HlvOwFNZFnOwycXrWrqS4P/DFHTD8qDT1KIzTShJScHs8yrSjgSfJRYJOxZudeOz2khLH6ZHW1gOYYol4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173040; c=relaxed/simple;
	bh=05yST8nGHsQfidjmM4W5Qi1acKqnsiTT56psudEHY4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qf1KbEmCM/KIpJc+oyT5hEiMEkgenzo2sP5jSrkSP7GwVlzotvO63TAlWGAp0EtP9EhAi+LEEsQ3dYCvqZYNGLDnw1FimalZGFyqhvUXNk+5NIYoPPAqCJ9pV30Emp1Dle5pKhSJQAQ0xligPGU+3nNEMcQYsMnlN+OtIBkSjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W87DaE+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W87DaE+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20554C2BCF7;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173040;
	bh=05yST8nGHsQfidjmM4W5Qi1acKqnsiTT56psudEHY4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W87DaE+0u6MXXJzGr7CTMWW4teO2aLalp1tNZs5iKkY3LOYA/90KUhLY8AgzSLMQw
	 /YyJVfizL8ZshPG4TNRREXsu8LFOrP4NZxf6wPT+ZzCmK3amFJpFL/UbLSwimKDYky
	 LIyRInQqKnT6jez+yTbgNKQTgSN60IkdIbSk1PuEG3ZFn0qr5/k25lMgV5Y/DbDl4o
	 2gfcph81OS3oumIn46rlQZJv+Sb3PLW8GY5yC6uE19636XM1EhC36wEwwb/jy2joX/
	 C8dSXpNRM3n+6OlulsOcXKTGLYk6y7us7IlXuMJCDTQ/bnEiQj/PIlF9msAMPYbQr7
	 lRnZeLLA9PV1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7A0ECE0DB9; Thu,  7 May 2026 09:57:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/6] torture: Allow "norm" abbreviation for "normal"
Date: Thu,  7 May 2026 09:57:18 -0700
Message-Id: <20260507165718.2039781-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
References: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds "--do-norm", --do-no-norm", and "--no-norm" synonyms for the
"--do-normal" group of torture.sh command-line arguments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a33ba109ef0b7f..f0083891ee8147 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -184,7 +184,7 @@ do
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
 		;;
-	--do-normal|--do-no-normal|--no-normal)
+	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
 		do_normal=`doyesno "$1" --do-normal`
 		explicit_normal=yes
 		;;
-- 
2.40.1

