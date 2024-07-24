Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16A156898;
	Wed, 24 Jul 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840836; cv=none; b=CncyXzguzsOx8w5c6WCU8n92HDj/AZrlCxKIHpsKWvYMx+wCmx8FnDXz2myyFkGWxzROyl7yiW02JCW1U3EBvxeRlomL6Y5dwa1uXQCrjAAfWAGwsbbR5fi7PNr3Xi1xkpuo849oXwm44A9+0zGB8wDpTr6YO+sJL2Ak0o0SJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840836; c=relaxed/simple;
	bh=rPZGcmYmRSOMzLi0nNkViwAM1lDiZbC+r0BU2UMwV0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOxmB6V8N+xcet90FAoB2ctW0fRY5M0baaNVTLuIqVEBhsSL0i+UGVHRjS7Ys/kT1DK/0IPMU9S5Ob3U/1Jad0VJOgIpQnHUzQGyyfGMDlt1d3Kc4jCv49odkzmU3cFhGGWGt8mz99bLu7a1E8nI34t11l4X6mL7x0HgITVVPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwcvV7K9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwcvV7K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976FFC32781;
	Wed, 24 Jul 2024 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721840835;
	bh=rPZGcmYmRSOMzLi0nNkViwAM1lDiZbC+r0BU2UMwV0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwcvV7K9RbblZtS62OvkhK3lz/EIvXxolad0Cknf13o7Ku/1afPWaaHiA07vlwVKq
	 ExkFD3A+jAC+emUVzXA26uQia11CxS1YBv+DUDrh+HpKdyOEIt7OKZHUakzOS9rpiz
	 992llqpxhULKpj2N99tRWwzvPpc6Vp4tZjQ0LVYOeFaC3UJqOstH24HGzWYEgfvcnH
	 yNGT27gvijLjBjtKXH6bHb4miJsXQeGWs/igpmTygqrJM7lLOacKoK17zw7ost7avV
	 5HHayyIYoVaq9OGbi0ca992tagp9qtW4du4tdsvXnTqMUezA0qXuPMYW7lQsqpx/2j
	 OthMG3iyZ5LjQ==
From: neeraj.upadhyay@kernel.org
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	neeraj.upadhyay@kernel.org,
	tglx@linutronix.de
Subject: [PATCH v2 4/3] smp: print only local CPU info when sched_clock goes backward
Date: Wed, 24 Jul 2024 22:36:52 +0530
Message-Id: <20240724170652.809939-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722133559.GA667117@neeraj.linux>
References: <20240722133559.GA667117@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

About 40% of all csd_lock warnings observed in our fleet appear to
be due to sched_clock() going backward in time (usually only a little
bit), resulting in ts0 being larger than ts2.

When the local CPU is at fault, we should print out a message reflecting
that, rather than trying to get the remote CPU's stack trace.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index dfcde438ef63..143ae26f96a2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -253,6 +253,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		   csd_lock_timeout_ns == 0))
 		return false;
 
+	if (ts0 > ts2) {
+		/* Our own sched_clock went backward; don't blame another CPU. */
+		ts_delta = ts0 - ts2;
+		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
+		*ts1 = ts2;
+		return false;
+	}
+
 	firsttime = !*bug_id;
 	if (firsttime)
 		*bug_id = atomic_inc_return(&csd_bug_count);
-- 
2.40.1

