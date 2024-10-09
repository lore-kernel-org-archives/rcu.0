Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1291E1A14;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496976; cv=none; b=IXoLV5ZnIJ0rY9orzLrM+uqCMfwz70c8Mn/s+g+5SeS1SJTKnGdJl6BBFfruIoeLcw+yH4hbr7FURBSllZZ3Wy3TGvzV6mCqIS9lPMqXif8oljGM3M6vsVHw5cMP4H9RwONJf6XyUahTu4a5INOqyXBBBLNfINoJHS40qW/YlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496976; c=relaxed/simple;
	bh=8bI82NBJXXQerlOKPpjrxuDV+Y+lBIYfZla/GLPfrVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb24VGbWDvF+DjU00SkNy4KZQlbXzagtbVJPWpEcd7qkBWuovTRq6FBlcwJ4ME2AZh6O/SklHcJocjufOwvUZDh9hsCzkJ6KznSqbqwYn7MXXS8X4p+f4yN4HZIMZW+Fnm926nUzT9yZ78THZy89rmE6WWd/46kb7n37wj3RC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAqYAhVs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAqYAhVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDFC4CED5;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496976;
	bh=8bI82NBJXXQerlOKPpjrxuDV+Y+lBIYfZla/GLPfrVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAqYAhVsgWurbGEIaXzR9RW8pea34iKeT0zxT44wWSI13+xqFWG8yMt7eK/Zp3ULf
	 Ylyy14DqsrJTTxAbJtjVFjGxQbqVv/XmX0VSa9qK2aWhUPhPAwsz4EYntCtAYDob0W
	 IDoR+BX+Pnvmi6CRI7pEJvxHFk+80VfHr00ek0Iedswg8R+X1pZG6H5YPbKK4pA6zr
	 ih+S69AZqRgUgj6WMYokpp9FBCVvppOjsHf6IbmxSspSCCi8syCmDNX3TEDC7gXeP6
	 h+3QuaEmR8i+G928W0XjhBDR6DNQ1ijyUAxlHGKh9ONSSz53RrOlxF39UKbXX0fPDB
	 Vsu+jgCORzG3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CFA38CE0E61; Wed,  9 Oct 2024 11:02:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] rcutorture: Avoid printing cpu=-1 for no-fault RCU boost failure
Date: Wed,  9 Oct 2024 11:02:53 -0700
Message-Id: <20241009180253.777965-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
References: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a CPU runs throughout the stalled grace period without passing
through a quiescent state, RCU priority boosting cannot help.
The rcu_torture_boost_failed() function therefore prints a message
flagging the first such CPU.  However, if the stall was instead due to
(for example) RCU's grace-period kthread being starved of CPU, there will
be no such CPU, causing rcu_check_boost_fail() to instead pass back -1
through its cpup CPU-pointer parameter.

Therefore, the current message complains about a mythical CPU -1.

This commit therefore checks for this situation, and notes that all CPUs
have passed through a quiescent state.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b4cb7623a8bfc..3ac8c69dd5bc9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1061,8 +1061,13 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *star
 			// At most one persisted message per boost test.
 			j = jiffies;
 			lp = READ_ONCE(last_persist);
-			if (time_after(j, lp + mininterval) && cmpxchg(&last_persist, lp, j) == lp)
-				pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			if (time_after(j, lp + mininterval) &&
+			    cmpxchg(&last_persist, lp, j) == lp) {
+				if (cpu < 0)
+					pr_info("Boost inversion persisted: QS from all CPUs\n");
+				else
+					pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			}
 			return false; // passed on a technicality
 		}
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
-- 
2.40.1

