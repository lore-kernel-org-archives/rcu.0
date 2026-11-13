Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531490;
	b=Y+YBd/xq7Hgz/UnaCJLK5IgwRetZBMXt430bjPdQQDmSMJK2DTtc1HDccMGD4rJgXYJ2
	 Wl81XGvR3D3qup9FPgusjaZ5bzcoE5wZih1b3a+dhiMjnFMXdwh1Q6DJ6s/1jqdEBYu7N
	 xWO4Gi2i9hwYsV4xtyudeMVhXmDogJpHWoG+/NA1Y9SCVbzPS0gaEAAP+NZ+zUziADhbF
	 YPfXgg9AZKp7MfLWOtpEgS1zZZiX8EEUDm29UWMCSyNxE/BKLFT9QeyUs/1sIUHjW8orl
	 LxVUukdw6JCU9xNrk3DadRUlulLbLBNTpWvDs3J0tplS7jJ1bG8Tns1vsLsCKn7eXCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uRRAf3AQkNKd4Tp8uLsmM8FqpKIe7hGQwxP7ypFTuT8=;
	b=ARQHJLTspjFucWp9I1yibitRMpRi9yN5LS1xg66C7uESx2pkhAaNnsPpCitMJljl/vAs
	 Hwp7LlqgZvDjkZIKBw1g8c7lNtowr8ZaIxq/scph92IVWJcovowPSp8ySWRIN3LRDOeRo
	 lpY1HQmzNRB1lJgGSSnRh1knCa0pmswgdnR+vunXOXkJkuR6QGgBgcfHMW74V+bg7s0bk
	 kz/frlbEbFwIxj9hL0pI3W/x4b979siTXEj9MYK7SYiNCtGuqRjIhV6pED07ec82DKaka
	 7FRXFChnfdKrBwlJTaKlV5Q8Way/OyqC6/pLNrmxlnwNDkktRdlBFjakj6sJFsJJzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMnWLbx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A8C8C606A893;
	Fri, 13 Nov 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMnWLbx8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 373891F000C4;
	Fri, 13 Nov 2026 00:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531490;
	bh=uRRAf3AQkNKd4Tp8uLsmM8FqpKIe7hGQwxP7ypFTuT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMnWLbx8U30mcI5d7I5UvJRkQEcGxNAaCCS1evaFSNDMVNYgLi/4KKXKlUEl8LEf4
	 mapkmqsAhpVPg9Gx5VqDK1NbTFrr933R6pgUHXct/TQnZXS3ypsLBon1duuRYYwd10
	 YdOQ8zKDMoA5lQQzUOXogKXFeNnbVcydpvOCVOTY/3Sqk76VCVEz+Z1jlga8wBZXy+
	 wF1UgtLiZmSDnRC/E7Gbc0TxLfULOsuQSNMDe6Ztaa2o2fIKiEHI96DupIi8/JSsPi
	 KHS4+7ffmaA7viSrtwERHjUZ+qj4ziD715fHAkI162DdzOU5YciLoPCyiI5Z3WhZfU
	 R8HNVHdE8oTJA==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 10/14] scftorture: Reject empty workloads before starting helpers
Date: Thu, 12 Nov 2026 19:57:37 -0500
Message-ID: <20261113005747.2977123-11-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A module loaded with nthreads=0 starts its statistics task, but cleanup
skips stopping that task. Unloading the module then leaves it executing
freed module text. Reject a zero thread count before starting helpers;
negative counts still select the online CPU count.

Also, when built as a module with reschedule-only, this leaves the
selector empty because resched_cpu() is unavailable to modules. It warns
while selecting an operation, invokes no callbacks, and can nevertheless
report SUCCESS.  Reject an empty effective selector after filtering
unsupported operations.

Both failures were reproduced in a guest without the patches.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 603b2dba1536..ff9a8271a464 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -588,6 +588,12 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
+	if (!nthreads) {
+		SCFTORTOUT_ERRSTRING("nthreads must be nonzero");
+		firsterr = -EINVAL;
+		goto unwind;
+	}
+
 	if (weight_resched <= 0 &&
 	    weight_single <= 0 && weight_single_rpc <= 0 && weight_single_wait <= 0 &&
 	    weight_many <= 0 && weight_many_wait <= 0 &&
@@ -636,6 +642,11 @@ static int __init scf_torture_init(void)
 	scf_sel_add(weight_many_wait1, SCF_PRIM_MANY, true);
 	scf_sel_add(weight_all1, SCF_PRIM_ALL, false);
 	scf_sel_add(weight_all_wait1, SCF_PRIM_ALL, true);
+	if (!scf_sel_array_len) {
+		SCFTORTOUT_ERRSTRING("no supported operations selected");
+		firsterr = -EINVAL;
+		goto unwind;
+	}
 	scf_sel_dump();
 
 	if (onoff_interval > 0) {
-- 
2.54.0

