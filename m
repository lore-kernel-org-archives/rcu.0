Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEA1FCC67;
	Tue, 12 Nov 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422238; cv=none; b=IwiW2g0V4hqb+FkVafdIQnovacNoAxqeHkyuu4J010d5/VH+Fxg8G1sNXm8ELrYbaBgtAVHKmQiRpu3Z1QL5ZPP0pjMvppEyYBMBujGOel2oZES31pgpx8oQXMo9C3edkf3zX1U8uKDmSHsRpHC0huHrwEtZrl8mqeMVz+jFvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422238; c=relaxed/simple;
	bh=zrdxFJoOQf/Hovb8Ais6N5YvTofczOBzLlqv1Yg6UpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmvqcsIYmsmldpQ1/Y0oWgcBTQqKu2C+ibCNVkzVkwiA8dMpIH8Lhl1jFwXwYnpoBKJ5zK7+yQDor+9hAnHCiHu6eOobAynQqbcQZ9Wbqv6jM9YvkhwQs7MOnTn5Yiv4Qt+q8QKcAxPNibmw6pomC8pVXFjs32wehFl8EbPhJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjQj09tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjQj09tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5BAC4CECD;
	Tue, 12 Nov 2024 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422237;
	bh=zrdxFJoOQf/Hovb8Ais6N5YvTofczOBzLlqv1Yg6UpE=;
	h=From:To:Cc:Subject:Date:From;
	b=GjQj09tkKWdfuOsLLNsJ5aa1OWiQZWHTv7x6MGy8BxdlBsW0KOz97YL4Up1daKd5p
	 WEXRhzcYgGGYNNL8c7NKzmGskakyJJym2sOG6k8trPYfD9xehm9SKAoarB8OwbHlzH
	 ytXF89GyaGL1ppH8LE021lOrQge0N/oDjURIgvz9aO6at3xSj5KMlbLx84HFTBCdrY
	 4dGA35+ZOAN5cRZvh6kglCkejm2q2MU+TgSf818eF9oSuBMDZ3FCJkPE8+AgSSS8xU
	 X+3TcIGNQkyhtkhKR8VHLKMvi5TbvW7pSEFn77ZEW6fUT5+C/xNJ8PLL+xr/oOrpcO
	 lDXgQg0ty8T/A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/3] RCU stall for v6.13
Date: Tue, 12 Nov 2024 15:37:08 +0100
Message-ID: <20241112143711.21239-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please find below the RCU stall patches targeted for the upcoming
merge window.

Paul E. McKenney (3):
  rcu: Delete unused rcu_gp_might_be_stalled() function
  rcu: Stop stall warning from dumping stacks if grace period ends
  rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()

 include/linux/rcutiny.h |  1 -
 include/linux/rcutree.h |  1 -
 kernel/rcu/tree_stall.h | 57 +++++++++++++----------------------------
 3 files changed, 18 insertions(+), 41 deletions(-)

Thanks.
-- 
2.46.0

