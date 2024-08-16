Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B12E1E9;
	Fri, 16 Aug 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787614; cv=none; b=DdrN3eLz1jHaoZQr21CSvO+ONyFM2u/q/AjSaRzGJPxyta3c6KGbtG0XSTNwpKDs+U7QqfKWzp5SLg1eUcj6k3iUONlLUVMZpZaOKG5kg6352hNZ4G9cbjcNylMsgIbMBu6OxKH8fdJeMOOcuPXIDVGyw2+ejgsW/hsyPAqASNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787614; c=relaxed/simple;
	bh=J/SOWYNC0DQ9Ec9glAI6uTGfbMLi8t5ZrCUq3XXmHRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrNNTbWHdLi6cdQBtLUDLyHSkAIxsKQjuN3n0xWL4Zf7ESpR5MGZYnQUXEBScYUxujLG0U/O1JpGNFhxVAW+SEZUAkfAXwkZn+PjUjPasJXrN5lLQlC40GJFV1iaL/nY3NJYBRj6v8T+YTldiAmy042c/jL35gMo4UWI1Q0fA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrHBsr2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrHBsr2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0714DC4AF0B;
	Fri, 16 Aug 2024 05:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787614;
	bh=J/SOWYNC0DQ9Ec9glAI6uTGfbMLi8t5ZrCUq3XXmHRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrHBsr2TkfxYYBPD0iiMJ5J08EY/k8QHLR9ZXf9pV7tuu4rkkhVJxaNW5zR7q/7nj
	 LPQFEu9ZFM8986lrTXnTO8oQNzJK8AndSJZhj/gnbM9bW0VvReyFwTs5UG3382AR6K
	 lLszUpbbr0hhCG2foPlMuXyhxhK/hVPMSKrolBAgxLw7g4tEIylaeI9S5jW5kyqbot
	 xmPYDheZwNa4fcmqLCQ9UojPq22gKX+fJBzY2ePU2kdGNyibfbSLsqA2b+ap4ifObj
	 VJ6v4AX9EfyYjmVVsXpVrYl9pLJ5YPojlRvfEKsMmgUb41gfd1jAtQF3d/5XK+Daq7
	 hvKZsuKb2dwiA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 5/8] rcutorture: Make rcu_torture_write_types() print number of update types
Date: Fri, 16 Aug 2024 11:22:00 +0530
Message-Id: <20240816055203.43784-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit follows the list of update types with their count, resulting
in console output like this:

	rcu_torture_write_types: Testing conditional GPs.
	rcu_torture_write_types: Testing conditional expedited GPs.
	rcu_torture_write_types: Testing conditional full-state GPs.
	rcu_torture_write_types: Testing expedited GPs.
	rcu_torture_write_types: Testing asynchronous GPs.
	rcu_torture_write_types: Testing polling GPs.
	rcu_torture_write_types: Testing polling full-state GPs.
	rcu_torture_write_types: Testing polling expedited GPs.
	rcu_torture_write_types: Testing polling full-state expedited GPs.
	rcu_torture_write_types: Testing normal GPs.
	rcu_torture_write_types: Testing 10 update types

This commit adds the final line giving the count.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index acf9f9945d2b..9a2ecb8b88ec 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1324,6 +1324,7 @@ static void rcu_torture_write_types(void)
 	} else if (gp_sync && !cur_ops->sync) {
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	}
+	pr_alert("%s: Testing %d update types.\n", __func__, nsynctypes);
 }
 
 /*
-- 
2.40.1

