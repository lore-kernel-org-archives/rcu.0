Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F079D0
	for <rcu@vger.kernel.org>; Tue, 28 Jan 2025 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022866; cv=none; b=MkgSwt+nOkwxqSrp1t7nsFuYdi92fOag9ZH/qrJi4ournSto2UZR7PtTi7PPyTM1CQO0kqzEGox5FsNcOxAaFqLeiN1PBQqLdo+b9PN86rrxSETN2J9hJIV/RSnNTStVXRJDJN4i2uTNaGJuLN63ObJXVACETLJ3WI3Ev3xwreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022866; c=relaxed/simple;
	bh=UTczKcONvZh/jGTUp0GZFdCgUV1wMm0HAuYY32kDouM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orhzXs+v6vUKYtZtghhZ5xbU22/076srqmmhqyBoM09Xv2dla48rUKg3u25FHaF/HfG8MqAQQoQQxF+cM7PZKFSigNQaouWJkNA70EHgbBHqPfk9GIA3EpL599XFzJVRu6d3z6iJYF6zQwrjTHM4WLU03J/8WlLhAmkJ8rpHI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=MEecC1SK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MEecC1SK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6eb531e13so289240785a.0
        for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 16:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738022864; x=1738627664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FuyO7GNMVge+u4qbg2Gk2zbeJcR8FanWKYbbXzJK3lU=;
        b=MEecC1SK3AUOWv2JTzS/eabNJzcsKqNEwrdJZHFSF0YbGIeNNMN2tEiEAY/dMjjDP2
         UtODN7tPxpb6uJuPbDtdYwOJW7MpOUZkuK9NBoz9WMVjcHZPeQmNvzA8D1pgyfvN5Z8B
         BM4mQVHHpeUAvNgxGCwjb1sAS4w1aW2zd9yQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738022864; x=1738627664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuyO7GNMVge+u4qbg2Gk2zbeJcR8FanWKYbbXzJK3lU=;
        b=cH05uBXM2zbnP3HxIC4AQjdkiTHMgbsz46OpgRRhkdTSG2o6GKdgmUle6PLdbXhMcf
         3Qp7a6JaLg2NyIiyKOSm6e/KTMklIVJgN7C/5h/YTNxNYNa59vtn442Y8V9DJmdBwP6l
         WdVemJmf4gsGcWq5A8aatf6tlMVCaKYySImyDcBzCq+GFj9I8VlPCHXh6rQBuxavGjOH
         4e4NBgzLt8SEMurv95fh9baHOYOgnCQ8AjZJ6iAcqOEocIaX8OBEyLbp4TR7zxaQwb+A
         xl3JR36NaEbGq5MMOhiUynd8PC9ScGgWhBO/sDF1dmmnYUWkkLlSBLSlDgA3txoexYIU
         E0rg==
X-Gm-Message-State: AOJu0YxyJY7HYNamytKf9PgMo8hwK9cfrAjlJN8QVoaNzETQnm6bTJKe
	RBgnltgTzhkEWsrPud2gKeN3bcqbU0ks97qYODkv073JquUcIhKo+IXAwcNBPBg=
X-Gm-Gg: ASbGncuuQUAT6smljMvhcLFWGQ9lptzmqHqOxDyBLzcspH19N25lNoCmtqgdo41vzAa
	uAao/+i1ajsVdn+0VoKcqed4KKqrgU0IToxMtS6LZW4GqdFeGLps0YjpcTWExgVg1Unu4TtHKlb
	UXhNgv9hyJGe3TRjjwC4EnLT3O/RKP56TrSuhhNB9T6VKTOycY/mpluM7GbVVtIAvzYgVvVGkd7
	9zPrJeeh+Anqtc3OP4DWy1jDrs1dlG0QCaqonocOjKD3piTlFXWQ8PHbODawJNDKby3dA28SI2u
	bF78/t8AFymVZ37Ib6PFY2UJLPAmQg8Q7CwpVslbHXQ8cFU=
X-Google-Smtp-Source: AGHT+IEYYDHxYq1V+wWx1NqoIrzeQKj7bfGh/wx10Ln9S5AuMl/tA1CP17NZvP0b2aFPjeXsyH7/qg==
X-Received: by 2002:a05:620a:2452:b0:7a9:bd5b:eb61 with SMTP id af79cd13be357-7be6320cc4bmr6633450785a.27.1738022863860;
        Mon, 27 Jan 2025 16:07:43 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedf6esm446049885a.76.2025.01.27.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 16:07:42 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org
Subject: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Date: Mon, 27 Jan 2025 19:07:36 -0500
Message-Id: <20250128000737.1264218-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_seq_done() API has a large "false-negative" windows of size
ULONG_MAX/2, where after wrap around, it is possible that it will think
that a GP has not completed if a wrap around happens and the delta is
large.

rcu_seq_done_exact() is more accurate avoiding this wrap around issue,
by making the window of false-negativity by only 3 GPs. Use this logic
for rcu_seq_done() which is a nice negative code delta and could
potentially avoid issues in the future where rcu_seq_done() was
reporting false-negatives for too long.

rcutorture runs of all scenarios for 15 minutes passed. Code inspection
was done of all users to convince the change would work.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h  | 13 ++-----------
 kernel/rcu/tree.c |  6 +++---
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..c2ca196907cb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned long *sp, unsigned long s)
 
 /*
  * Given a snapshot from rcu_seq_snap(), determine whether or not a
- * full update-side operation has occurred.
+ * full update-side operation has occurred while also handling
+ * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard-band.
  */
 static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
-{
-	return ULONG_CMP_GE(READ_ONCE(*sp), s);
-}
-
-/*
- * Given a snapshot from rcu_seq_snap(), determine whether or not a
- * full update-side operation has occurred, but do not allow the
- * (ULONG_MAX / 2) safety-factor/guard-band.
- */
-static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b77ccc55557b..835600cec9ba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
 	if (oldstate == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
+	    rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
@@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 
 	smp_mb(); // Order against root rcu_node structure grace-period cleanup.
 	if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
+	    rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
 	    rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
+	    rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
-- 
2.34.1

