Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E0288C2C;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459716; cv=none; b=ttPykrrfVd7xC1mJgB22GsbIyzwopFIqjXHHvmmxccJxzKMEeISpF2oJ26HQWtAzOqD1VIVRa2EAVid+lGgSrkaZ06WgCGuzFHZh3kRZUZAU+/mqYd/R/tuvLL+X6LofVhRIp+sAG9R9BFnwBqSS8VxruB2LWwsaUWH3kojxQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459716; c=relaxed/simple;
	bh=Yl88lflJiv8h6fgZKJ4Y2kkrLo395TLzV3PY6LBaolk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOTlqHJd19Hw6IV7mXA3oLO6HSmQ82fr2ZHltVIe8RLaEvkZJ/saK9fYKoQqrpHK6L81yF1cvHkO2EMXWiVLsJBE7qKA5hg4Ce/xUs/9+c5RApqW2+5CYA95tS83SzuCTP6aXGgcd+S5pckFImKGJMl0aeGQd0FfgxnNDUbbAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jczWSYcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jczWSYcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCEB1F00A3A;
	Fri, 31 Jul 2026 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459714;
	bh=GwXWaesWDGtEGGBh/9BmcgoD/ocnRp5Yoj+6V8USxfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jczWSYcTlRJK7Z1iKi8oiE8NDVe5SwbpH+CeU7pGz2v7DvoowAezbttaljzxwkGgd
	 f94IA8v0Ut01L5GN27ZmyZBXlJTc+iVc4L63mJuUaBrVDWhh0lBWdAEOUMo4nR+368
	 SZNjDtdjAZvXlC/rdcQCUNgs1JmvwBLAujFmrylKB6u4o0yiDonsxDAAvS0iaUdz6h
	 zZ5cQA2u5NsaaG0sfx3Fw/4GqsCejtzNIy8vSV/ybOhx4AXnZCa5d0a8HG9Am4mFIj
	 VQCMyLs2GszzdcZvTVKnJ6OT2OyWYGcTGykmdxd95GZiIXIXVYImoi+xmax4pL18V1
	 /kHuEDbbN7kjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A54E6CE0F6A; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH RFC 02/16] rcu: Mark __rcu_access_pointer() as context_unsafe()
Date: Thu, 30 Jul 2026 18:01:39 -0700
Message-Id: <20260731010153.3531313-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple comparison of a pointer returned by rcu_access_pointer() results
in a context-analysis warning for lockless inspection of the RCU-protected
(also known as __rcu-protected) pointer.  This can be suppressed by
placing context_unsafe() calls around calls rcu_access_pointer(),
but this is messy and distracting.  This commit therefore wraps the
underlying __rcu_access_pointer() macro with a call to context_unsafe(),
thereby informing the context-analysis code that rcu_access_pointer()
may safely be invoked outside of an RCU read-side critical section.

Reported-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e95acc33989b6..e40dc2e20c5b1f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -490,12 +490,12 @@ context_unsafe(								\
  */
 #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, local, space) \
+#define __rcu_access_pointer(p, local, space) context_unsafe( \
 ({ \
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(local)); \
-})
+}) )
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-- 
2.40.1

