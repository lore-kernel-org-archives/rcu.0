Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52D375F85;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=GM4Ovyt/vHGWaQmXKGhJT3sBXSfEFwu3bkqwH8B/VzzkHObHeHXl4N36yBG7VWlYW/R+ghSWw5piKVPMuBnn6amlKoYpN4aBkj+C0xJInG+fpLBLw96E+/KXxr28XRqy/lN1HLNHr9dJnbB/KJcOxLiVaN3gMZWxTVEbmJklggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=4tMsyWMAYFo2eyVNnuqFXVGyeJ7PQ6C7oWvMZ7xShEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUzoVQOA02y4hGoMMU+veJe8KSZdEte2u0E7agGfZPvgBBoAy76eKhJptS1luemkDdv7TI7qdA8b4Qtr7xj3HGFF7URKtHdi+/ABhZWGy+XwaekdHtbWun5YJtQjpHOqotJm2UKK8yIfedX1sDJf/t/lj2miPydVAG3/TfJVw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgEFo0yk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgEFo0yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE349C4AF0B;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=4tMsyWMAYFo2eyVNnuqFXVGyeJ7PQ6C7oWvMZ7xShEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgEFo0yk0UCLaFWQYQlrgEQy2aNi39A9bWywkF6Hx13k6dHa8LehyD34MtPTd8v85
	 pgaUTbxS4WljOUPLMiLn6BDd+yzawZ8K+XnRkN2r3OtxJYKvS6MxgSZHiY67LTJBc6
	 KObmRbE7QhLgdZLqe+Y/sBcmpVXAc6sEVyMem2ukdo5xwunmEY1axh+qiBBRxeT75Q
	 sPDIoOyMUrHTsJi8yw7vlIWvFwol8dWsVSV53KeL+4Rm8bNkZl7waZqDRuuNGoHlf3
	 b5/UyNVObqm9QWspM2Ha2Jg5r/Ratctp+elQ9C2OFRQnU26GHJv6RlqAT2JaSZuu7t
	 CU+A5sm1wNUpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04260CE11D1; Tue,  3 Mar 2026 15:50:39 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 10/11] srcu: Fix s/they disables/they disable/ typo in srcu_read_unlock_fast()
Date: Tue,  3 Mar 2026 15:50:36 -0800
Message-Id: <20260303235037.1967017-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typo fix in srcu_read_unlock_fast() header comment.

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 958cb7ef41cbb..ad783d4dd3677 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -259,7 +259,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_read_unlock_fast().
  *
  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because
+ * critical sections either because they disable interrupts, because
  * they are a single instruction, or because they are read-modify-write
  * atomic operations, depending on the whims of the architecture.
  * This matters because the SRCU-fast grace-period mechanism uses either
-- 
2.40.1

