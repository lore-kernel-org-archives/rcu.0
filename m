Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2923EC2F4;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=mSCX2R1cKH84OhPly1hB1C4YbMU3KzLuQ2I71A1uyzkQstsElEMb+/1juKzv891rgA0Kd5IJo1RGk79E3oCtkuBqau5jaF6/nkIdwJ12kT1n+EziVCSiNRJ8tCHdVaTS5ckmawvEtujwziJrgvqVtFG6uPR/JnMw9lNhXTeaYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=q7b0mu6e3ga1tvOS64w7YkMM35W9E7PHytBUGtM1y8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBeA8m1wdnDc+bsSrVTkvwc45jfcAcgUJUVoSWg0N2nOjtnu/rd7/4ZdJp33ZD2guMqELdrKOUo6JgGLx77TACOFCBNKsKV8T81v91MmsWQ2IjglJ6qRTb9XNHs6JmwviEka1TCWgT5Hwd9BarxaE6MCnzBzCp0dcrfqMlbvmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/TTvBsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/TTvBsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21050C2BCB8;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=q7b0mu6e3ga1tvOS64w7YkMM35W9E7PHytBUGtM1y8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/TTvBsRRYkP4hv7z/jGx6UsKzpJyirv1wMHs2+Y4CHWALUzFj+SYc0QQzOzMP6zn
	 5rEE967a+pElOSbz+mUJsfkEbMColOi3ht1fPOnRutw5XOZ1ncLCFP+bEApx7uusvn
	 ljpQj+9Ol9mHZzO3Vlx2aD+KsGp8wQpUaQZhsrkR26cYQM/3Nd0WhIWLQfOkH5nZXx
	 vtCJcW/+LSjjrviA+5hZztH0+NZlzCO+7GItXRXUlAPwVZ1SbY15s7clmjeRbMkwvh
	 v7S6qWgLlzkL/MYusi0y0zPUopNs++GOHb8DEBMbkl+sGwjgDGJmRb5JLkECGgg7Yj
	 j8i6vsire3MQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADF7BCE0DB9; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/7] checkpatch: Mark rcu_read_lock_tasks_trace() and friend BPF-only
Date: Thu,  7 May 2026 10:09:47 -0700
Message-Id: <20260507170950.2040199-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_read_lock_tasks_trace() and rcu_read_unlock_tasks_trace()
functions are intended for use only by BPF.  Therefore, add them to
the list of functions that checkpatch complains about outside of BPF
(and of course, RCU).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7a0aa139a2424a..cc5bbd70cb843e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7594,12 +7594,15 @@ sub process {
 
 # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
 		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_tasks_trace |
 			rcu_read_lock_trace |
 			rcu_read_lock_trace_held |
 			rcu_read_unlock_trace |
+			rcu_read_unlock_tasks_trace |
 			call_rcu_tasks_trace |
 			synchronize_rcu_tasks_trace |
 			rcu_barrier_tasks_trace |
+			rcu_tasks_trace_expedite_current |
 			rcu_request_urgent_qs_task
 		)};
 		our $rcu_trace_paths = qr{(?x:
-- 
2.40.1

