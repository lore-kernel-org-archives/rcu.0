Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BB410D3D;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262236; cv=none; b=NpS/9OTTIknlzmg4BfO1qUpfP4Yf2dWbtkhiWTC9wqBQxveCpUloobweH7P4VwBQOLtPSHyXjxSKWYy79VJ4j/ZDpJjDChFv5to4JMjiPNG13mdCdvaJgjKDG9zP0zevWPIzFcSZvisC/zTFpwTWqImuXG9p+c4EU5epAB2MLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262236; c=relaxed/simple;
	bh=/Y++xnjbRpcunrSUKXCI4237l43LWEtuXPunx3ckXv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+IBJpnB6e9eYfjYUkwC9EKUdDgMElWLQaiwAy+vD79+xg+JeDShrLb+lUB0HtbT/LKhXJykMSS76a5ppOikg4pcUknUfOeOY2z3gOgB29HDYvqiLbxqe0bOA1RL0VD3K8ApkeCM6+gf/x6F074/HrpmNlYc++NO5+cugd5iskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tje978lL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tje978lL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96790C2BCF6;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262236;
	bh=/Y++xnjbRpcunrSUKXCI4237l43LWEtuXPunx3ckXv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tje978lLKSftcyBje+2oii3H/okJYfU5doS2t0hHegaB8GZeIzLW+CIX9AIfxKcmb
	 U7gHhyAQaJ15qNf1OcmsQ2d3qV6udNuBHUyjMsZQHcmh7Hodhi97Fq9aQCmnMQbssF
	 4nycc9AiEsLangZl84+8Z11KfoXi/c/PVbkRpLvcXfPre8d1UA5CCuZvwGUd6QfybD
	 FmDXSdXGEfIhALImfC0ynXmugusNfazZ0LCt/gZgxwYR243qDU5rHcopM3GXZMJAd1
	 l8/8GETTs3P2ZoW7Z/rkGjcCrhCUWCGkv6My7EKmjFfRlfyGgF+FT8iL9XIMekAAbb
	 +64O3siEREgpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3DA7ACE0863; Fri,  8 May 2026 10:43:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/6] srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
Date: Fri,  8 May 2026 10:43:49 -0700
Message-Id: <20260508174353.905746-2-paulmck@kernel.org>
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

s/srcu_read_lock_safe()/srcu_read_lock_fast_updown(), there being no
such thing as srcu_read_lock_safe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5d1..a54ce9e808b92c 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -397,7 +397,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
  * and srcu_read_lock_fast().  However, the same definition/initialization
- * requirements called out for srcu_read_lock_safe() apply.
+ * requirements called out for srcu_read_lock_fast_updown() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires_shared(ssp)
 {
-- 
2.40.1

