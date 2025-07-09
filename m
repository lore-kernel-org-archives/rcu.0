Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7928D85A;
	Wed,  9 Jul 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057574; cv=none; b=mhHcAqh0rJUEXy67M4FM73AKFuX8VXNqRxI2olElCZ4uG+WQ7qgwMzF8x0A+yLXwo9cjxqVjoLlraxMxqoR+q1U1ZXyUjSmLZUGdjs00CPFcKqlQmt+uB3HiZpDGZwLg74dK/2YAr2mXNCSVac9Ns02reAieCGvkMa8xoZnBwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057574; c=relaxed/simple;
	bh=bgnOqIsaKdvrhLSAXS+Qh617bRsj8kZXkOFBQC3gxy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLa4/JXTrvX6iWz/Pckv7CU7r8NPInqxDgiASTIyORnTYAxuqrVIItemFbvWra3z9yma15ryAzdz8x18qNsezoHw0tlqwQLqte9aU23xbi3KzkXgkRUHS6p7tqrsFXxxBhYm2z7GSJRvOSTEM0c0H/QOpEkxG2Sxx2vRSKXK+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOW09LQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOW09LQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF4CC4CEF4;
	Wed,  9 Jul 2025 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057574;
	bh=bgnOqIsaKdvrhLSAXS+Qh617bRsj8kZXkOFBQC3gxy8=;
	h=From:To:Cc:Subject:Date:From;
	b=KOW09LQbBFg9693+YvdTxAukZCjesUj+nLFIiwkQJh1s8SJRdeS9xVPI8XBVRMFBq
	 Obs8AoxILT2+BfyYKsFpzRrhhvn8bzO4k8gudv7mdWw8glgfQVZ9B7+ufEn9wRxX/Q
	 7IJDTqjnlTzyihzIix+kaRQsbGdFjyx9ZIDZEAyuXfJt0OAyaihYJjEndaR2yOWDh6
	 T7QZ/g4ESwEvDw0iRSCmB/b7Mqy6wabhnhTVeV9Y7A8CGOzvhi6Bmi8ma+pGmLSdGC
	 LCt4tEIZ/Fapyq6PHwS86IErrR8y6oumVnY1hs1jGVCeEGgdAGB5XqfYemjGLYZRlE
	 tJSgyFJfpRJUw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 0/5] Expedited RCU changes for v6.17
Date: Wed,  9 Jul 2025 16:09:04 +0530
Message-Id: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the expedited RCU
code (rebased on v6.16-rc3):

Frederic Weisbecker (5):
  rcu/exp: Protect against early QS report
  rcu/exp: Remove confusing needless full barrier on task unblock
  rcu/exp: Remove needless CPU up quiescent state report
  rcu/exp: Warn on QS requested on dying CPU
  rcu/exp: Warn on CPU lagging for too long within hotplug IPI's
    blindspot

 kernel/rcu/tree.c        |  8 +++--
 kernel/rcu/tree_exp.h    | 69 +++++++++++-----------------------------
 kernel/rcu/tree_plugin.h |  1 -
 3 files changed, 25 insertions(+), 53 deletions(-)

-- 
2.40.1

