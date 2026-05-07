Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1732C21C5;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=iyd4Nr7DixaZpeFHFZ4rF0jbDBZH4uupcrXiPR4qY90Ke/k7gwFu/Kmqtp8RzdlHNmuWoaINf2ZMgLmjOf5gtpHainGSvgRBsF1z4DiV/+5wXg3eOw1sqKgoJIl9gW0/jW0JgKrJap6QUBOJ4w1OCJYDtKH3rsILI0XEwNe4dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=BnQHU3UiLfVgh8EzJY+SASyVRoECPKgyAiZaumt6cvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj+3al/wu/1Eho1x0OKXmnigw4Ef3tLay8rlSQ6E+SG3WsZWaclqJAiOMYsYhpCu2cC4CyuVhvcYB5PaxQreLsEAf7ckPhLuy9XcekOfKsfhBJqNDSUm3/ggxGP4IIrqpxEbVgiQRslJ1EjFJdy7OXqRyg48HbcEDeXWX9cGFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+fMIoTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+fMIoTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128E8C2BCC9;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=BnQHU3UiLfVgh8EzJY+SASyVRoECPKgyAiZaumt6cvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+fMIoTK8+cYw/K12C5AbW97Q21lKJRyLSjMaJY6M1ZF90EvTag7vtXilc0Y13812
	 WV6AzedmGlrUGkll8Tl5tpfJXFPEog+kdbU7iQ97UvghgWNgwepI6upwPES+UEpHJ/
	 07zrt0voUQBWWfCIhE8Zhzx1usxLpYJQdJ5b5GeCDMEcVwP4a+ilM79UMAcsaEpSD2
	 yZwSCPiYMLsJCQe/HUPKI6aXeX0HOX1Ly+0VaZFexwhVbbwNjqeYor1PXyiCH3vX6Q
	 EMccY3AslVgPq1VMRh1MpWCP4Sy7S3p+1fYCnWq3fqJLAMP9/Rev2Mm4xKwsRHeHq6
	 n6dwUXQPpYDIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB2A8CE0C96; Thu,  7 May 2026 10:09:52 -0700 (PDT)
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
Subject: [PATCH 3/7] checkpatch: Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace()
Date: Thu,  7 May 2026 10:09:46 -0700
Message-Id: <20260507170950.2040199-3-paulmck@kernel.org>
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

Reported-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/checkpatch.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0492d6afc9a1fc..7a0aa139a2424a 100755
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
-- 
2.40.1

