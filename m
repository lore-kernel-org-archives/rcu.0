Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478A407573;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262236; cv=none; b=O2XH73xzUSzCfJA6zSYOt1z9Qj9xPKvL4XMoF7K6tqhNyK7lfBGYcd/11Aetx82CHCCKa2VewFeygMUu5ZF5xDew29AMX405CjU9GLLoE+Zc8BBCcKLd20W3Np7wU+qzCglnTN/aPt3lGSbhwXiGwEBIIxtrG6h9SANFJOrtBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262236; c=relaxed/simple;
	bh=bK0caIrz9kRi5yHZgG08qzzOGCM4PuqQ6vEGFPiFY94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD721CkU9k4TPGNPMsjv1GLHK0T5SO02dlo2Gn40cgxaiAge6x/rqHAjVSwJEgD4RmIWrFXlaMKV8SyKH5ug8jHmfmuzWJtSYwb0IydIMzrkcrh4pNr/8uHHYZKMgDknYEu9IlidnaukvTtVC36fBgcLRds78EPqw7q1tdCCG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR405yhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR405yhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C096C2BCFA;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262236;
	bh=bK0caIrz9kRi5yHZgG08qzzOGCM4PuqQ6vEGFPiFY94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LR405yhbrTwoAbgoQ/1yGIBGb21tLPLKpMu8BPmGAtCnntetoigYmlUTUX0lxVAN7
	 0x+x8wgzjoHkurCh77DTdDcSxSKAmmV0szoUi77ND4NA9b5OpUTNHlF3cIQrA8Sqlm
	 Dk3F9TiqZQ8RpSE7v13JfAlu7YpHUWLpRIl4CWjvpu8zpDli4h+KI2Z8lMLexw/fAR
	 EtV2T0kJ6Hh0Vmf8HEhA3dP5pmmvN1JG/wkSVN6J2mKusGUZbyBXFWaggAmt3AFZtJ
	 XPgjlDhd9nFsqhjDSqJ0NVZmdeoNSpQPlBUQqXstT1EG94T4xI51iefdD6ka8g++8F
	 yZ0onPh36yy3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40DA6CE08B6; Fri,  8 May 2026 10:43:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 3/6] checkpatch: Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace()
Date: Fri,  8 May 2026 10:43:50 -0700
Message-Id: <20260508174353.905746-3-paulmck@kernel.org>
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

It turns out that there are BPF use cases that rely on nesting RCU
Tasks Trace readers.  These use cases are well-served by the old
rcu_read_lock_trace() and rcu_read_unlock_trace() functions that maintain
a nesting counter in the task_struct structure.  But these use cases incur
a performance penalty when using the shiny new rcu_read_lock_tasks_trace()
and rcu_read_unlock_tasks_trace() functions, which nest in the same way
that SRCU does.

This means that rcu_read_lock_trace() and rcu_read_unlock_trace()
will be with us for some time.  Therefore, remove the checkpatch.pl
deprecation.

Also, the rcu_read_lock_tasks_trace() and rcu_read_unlock_tasks_trace()
functions are intended for use only by BPF.  Therefore, add them to
the list of functions that checkpatch complains about outside of BPF
(and of course, RCU).

Reported-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0492d6afc9a1fc..cc5bbd70cb843e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -865,8 +865,6 @@ our %deprecated_apis = (
 	"DEFINE_IDR"				=> "DEFINE_XARRAY",
 	"idr_init"				=> "xa_init",
 	"idr_init_base"				=> "xa_init_flags",
-	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
-	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
@@ -7596,12 +7594,15 @@ sub process {
 
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

