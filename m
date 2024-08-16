Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27313D61A;
	Fri, 16 Aug 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791905; cv=none; b=PTHinGHUCBvsoaJbSg38uufj5wXxBB1tCZdKTMMJPAdVJdO4SPrLRZBvTNu0h/HeE0Ub3PF1gm4r6DL15tD+i/SvJzdRm5Aak9R5a8sa95S96k68l1bFZYap3HYMLxvkK9X5PSd1d/wgxxdmIiryxhMFF5V+KsLN9GRhFVCK59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791905; c=relaxed/simple;
	bh=LLMOR7Lho0MmgHN1fCBe5uVw2BOnsaGjuDnrIUmfdsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVeG3WE2adeLi4dtcEPEzmbHp03lvfuIt81AHLmxxB+43/RWBA8PaQTFNLu81GKAnn3O2Ghbh+PyKUwNOLQyaEHW8rcohpxpei11iEbuvNEtI182TVXP+ZRua8cgWUc6CFwGudu61YTXckq1SUVTPsu1P1CqM/UBmAAHMstGpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcuzodBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcuzodBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC2C4AF12;
	Fri, 16 Aug 2024 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791904;
	bh=LLMOR7Lho0MmgHN1fCBe5uVw2BOnsaGjuDnrIUmfdsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcuzodBp6qop+A+/AgZb5spP+GIxDSdZ8Xnu93CwDSL1fUdTb966t/gM2+Lq4Myhw
	 2e8Mk7P4i/XeY4oI4PzNP3pH6DipsYkxIhE8FACq+hQL3xC+nmBmAXBrs8wY3aISDm
	 VRLnQCuV2eudJDqnJy/wxgZsqzAJSh3iHQOEvqlbsTwqRADgqnhLPwRnOWXUUGtCFW
	 s3ss/tdOu9kYh43Wi3nrOOzQX4Tv26whA7MgxHFZLJwkb3beUwwujQGxzZzCrExqoI
	 W+KPmbLmzGZJQqatiJeTANW2nxjaRRLSPTU7HUfvVcn+7LpJqApcJr0c8PmSz8Z3Ms
	 5DQEopW6ujKCQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 12/14] rcuscale: NULL out top-level pointers to heap memory
Date: Fri, 16 Aug 2024 12:32:54 +0530
Message-Id: <20240816070256.60993-12-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if someone modprobes and rmmods rcuscale successfully, but
the next run errors out during the modprobe, non-NULL pointers to freed
memory will remain.  If the run after that also errors out during the
modprobe, there will be double-free bugs.

This commit therefore NULLs out top-level pointers to memory that has
just been freed.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index bc7cca979c06..61a178914256 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -819,6 +819,7 @@ kfree_scale_cleanup(void)
 			torture_stop_kthread(kfree_scale_thread,
 					     kfree_reader_tasks[i]);
 		kfree(kfree_reader_tasks);
+		kfree_reader_tasks = NULL;
 	}
 
 	torture_cleanup_end();
@@ -987,6 +988,7 @@ rcu_scale_cleanup(void)
 			torture_stop_kthread(rcu_scale_reader,
 					     reader_tasks[i]);
 		kfree(reader_tasks);
+		reader_tasks = NULL;
 	}
 
 	if (writer_tasks) {
@@ -1043,8 +1045,11 @@ rcu_scale_cleanup(void)
 			}
 		}
 		kfree(writer_tasks);
+		writer_tasks = NULL;
 		kfree(writer_durations);
+		writer_durations = NULL;
 		kfree(writer_n_durations);
+		writer_n_durations = NULL;
 		kfree(writer_done);
 		writer_done = NULL;
 		kfree(writer_freelists);
-- 
2.40.1

