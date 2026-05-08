Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6D41325B;
	Fri,  8 May 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262237; cv=none; b=Q9qOCzwofmUrJ8CCdoWK35hZK9ZpWNs25jNtbK2w+81rjKslHkCY/hqu4aAo9DXEDf2yfMTcz6m9q4ed2zYzGS+u2egiW3paLL7mqXKvlbb1s1doX3HNDb15Uxja7Q04o9Ec6zNwEHGFvqCQLSGLqDrjsIA4LAj+rjRBr1OvGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262237; c=relaxed/simple;
	bh=wFT/i1ySNxXzoubSoSgzPm8HS2drPU39EeIV8Pogu1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDLHiCRJGxakqlE5M2xgNBarZV1SV817zOkP6dCEzdb0P7qg93pJ4zAu8rHZsJ7BNqd6fhB1C6a+maE1Kc/+e3D0BysvvZIiP2KSr3IzjAUW6m4ZcQ5ffqbvDr6tVFbvWAxMOkeKq6fNtNKYfSTT2vekMnU9+ocCMdGUiGc8geQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToZd2sJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToZd2sJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1473C2BCF7;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262237;
	bh=wFT/i1ySNxXzoubSoSgzPm8HS2drPU39EeIV8Pogu1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToZd2sJKDnT440LoB4BH6H/AehKkL9XjxFstWQY6MrIbbKjnY1KHIzTriZw2fFW7x
	 MUViRX3C1sM8Xy6si62d0Pvrlky4+DWsD+jo/xvGX7VjoGn97YDMfIfplNj+bYWkyo
	 qYJFcxlDMennGwZBmI3AcAFigdli3DXbzRm+KaS3VrK2FxI0P/l1pc+BCeL4DrstZc
	 pgefC3B/dUjoEV+xUJvc8v8r05mWTd4ZbRku541I/lovgIMAf+/HScFzkFJEE8k6FZ
	 yc+mYhQ4+nnqeRnwZ8SYTfHlZk1VDsF8+VLt3sFfLVTiv7I+mcUqSl0sP77wXpTDLp
	 mxu/PkVRFkL9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48445CE0D3B; Fri,  8 May 2026 10:43:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: [PATCH v2 6/6] rcu: Document rcu_access_pointer() feeding into cmpxchg()
Date: Fri,  8 May 2026 10:43:53 -0700
Message-Id: <20260508174353.905746-6-paulmck@kernel.org>
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

This commit documents the rcu_access_pointer() use case for fetching the
old value of an RCU-protected pointer within a lockless updater for use
by an atomic cmpxchg() operation.

Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de858..5e95acc33989b6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -592,11 +592,13 @@ context_unsafe(							      \
  * lockdep checks for being in an RCU read-side critical section.  This is
  * useful when the value of this pointer is accessed, but the pointer is
  * not dereferenced, for example, when testing an RCU-protected pointer
- * against NULL.  Although rcu_access_pointer() may also be used in cases
- * where update-side locks prevent the value of the pointer from changing,
- * you should instead use rcu_dereference_protected() for this use case.
- * Within an RCU read-side critical section, there is little reason to
- * use rcu_access_pointer().
+ * against NULL.  Within an RCU read-side critical section, there is little
+ * reason to use rcu_access_pointer().  Although rcu_access_pointer() may
+ * also be used in cases where update-side locks prevent the value of the
+ * pointer from changing, you should instead use rcu_dereference_protected()
+ * for this use case.  It is also permissible to use rcu_access_pointer()
+ * within lockless updaters to obtain the old value for an atomic operation,
+ * for example, for cmpxchg().
  *
  * It is usually best to test the rcu_access_pointer() return value
  * directly in order to avoid accidental dereferences being introduced
-- 
2.40.1

