Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A0236ED6;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057762; cv=none; b=NTj5/DoEoh4gOAFtKwZAHX8uaxk2MlaglR1joAqdQ09mUxB0DXO0HNH8MQdzBJId3kIK6eXx3Vm9ts3MAQ6aXxLmXJmItC6jbaR+HgxSYFAtxY5+WxH70Uv0FkYdc7GIjgHAo6/2WRCDvTVpJwCdhx11ePhDyzcNiffmSxuPr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057762; c=relaxed/simple;
	bh=LxAVjkcceEBX+kWOutmMnZ3hzVxe3HxARfJHuCJyvGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lj4bOkPr1fOaiABobs3P/uxkaMs/YZ7fLKYBdM4Lq6WwxKm0nrKlf/2df66r7NrufXOGLAhNy0ejImS0ntshlPjQoYzQ8p4qDbnALoXYhanECqrcuud2JfYUuIyT1ejhgNovzGyWSsogs6mMPTlO+JpNSQ7nY2bB/75EY/LX1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfPjC6VX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfPjC6VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3346C4CEE8;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=LxAVjkcceEBX+kWOutmMnZ3hzVxe3HxARfJHuCJyvGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfPjC6VX/rGmwBSWAUV1Y0Ly8rV9gU24Jc1nFSlgR3868pqeFppW7Ok2Rr1pyzTD+
	 IusOWW6r8JZx3S3xzfXBEw825bon3yONTOCwX1BgOksQhL6Ajb+w1K0FMOLHvg/cqt
	 E/wRNOOoib789QsLZiCy1JIJDIfpQQ/YgC8xnRxK2LnucKV/YUJmOCXmBZDvI8Qb9H
	 Y4go8Arp7RhmeOpCe6i5UuqLFQZbTMNz3Q3CId4qapA/mU/+NDUgzAV+mQi/URTFFC
	 5xUJpj7QUb6p1lhqkNaLDoKWsthV8Zu4QKe+SXeJ4Hyd8lWQfBwyXM3+5whCRQ7V+m
	 zZJrdg6w4CZbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30408CE37B6; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] srcu: Point call_srcu() to call_rcu() for detailed memory ordering
Date: Thu, 16 Jan 2025 12:02:36 -0800
Message-Id: <20250116200239.3782374-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes the call_srcu() kernel-doc header to reference that
of call_rcu() for detailed memory-ordering guarantees.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0d..f87a9fb6d6bb8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1398,8 +1398,12 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
  * read-side critical sections are delimited by srcu_read_lock() and
  * srcu_read_unlock(), and may be nested.
  *
- * The callback will be invoked from process context, but must nevertheless
- * be fast and must not block.
+ * The callback will be invoked from process context, but with bh
+ * disabled.  The callback function must therefore be fast and must
+ * not block.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
  */
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
-- 
2.40.1

