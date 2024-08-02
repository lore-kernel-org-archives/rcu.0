Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF17C95;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=RnnBJIca0HFqgP8qYkSkDI93aHhZq61sZ+jnvD8YsR49CNZMSLWF+W0/vki9LpmW0T9/1ZmdtTdzNgwWPVuBJx/+lotT33WqwysSV+FLO0G91tWaha8+CEjHJrfZprOOaQzk/eXxtj0H55I4osMfwLfSL/0AkbYBh8QQF2KRVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=Touz5IJtnmv5BN3ovY+yPXkt+2bTcKDGka/zHv5HyVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQYwMBVfylzsTQXTZThZX7JCU23m1SqJscryn2s0FJ8WSIatREnX6vl015qHpuILAbEg7uLGuos8HHe4us+m8e2wnrMja34dT1nvGXQtwasL5+QwBVe5JH4WATJOm65KffScwGuxxUTezmcBUMaClLu2ei1tgnPWfGWAMhfWDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtQAd0xE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtQAd0xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED2BC4AF19;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=Touz5IJtnmv5BN3ovY+yPXkt+2bTcKDGka/zHv5HyVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtQAd0xE/H0Wz0rg2pZtEAxWDGcqxYEDhrLfq12j3EhM5cyiXqRbmcyTFiI2ruUrd
	 3ulvPmC3rpbArtKxtGRgkuiU/OjNh7J0Zf1BeYoEdCfe4dZaOKJLMTIolhy2kA/Wlu
	 qVtVaZ5eH9TVqh1mK0GYwL7RBiXIJBLoxeagAPnfW1rWzi1zWYb9SsZ//wGxMjN5YQ
	 juzqsHrGPR0W4pgx9snWqCm7TanSDDIQeiv5p+rkNr9WVEn7iHVBihWyabl2Fa2X3O
	 ttWpPAsgpqnYUuFcvQTCvTDv4S3UpEDpv64M6+ntzNMK8j/W4B73aiETiYWtyfNPZb
	 +EwFnjvDUoYNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6443CE10F9; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/11] rcuscale: NULL out top-level pointers to heap memory
Date: Thu,  1 Aug 2024 17:43:07 -0700
Message-Id: <20240802004308.4134731-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if someone modprobes and rmmods rcuscale successfully, but
the next run errors out during the modprobe, non-NULL pointers to freed
memory will remain.  If the run after that also errors out during the
modprobe, there will be double-free bugs.

This commit therefore NULLs out top-level pointers to memory that has
just been freed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index f945f8175e859..13d379c179248 100644
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
 		kfree(writer_freelists);
 		writer_freelists = NULL;
 	}
-- 
2.40.1

