Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1F2753F5;
	Thu, 13 Feb 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489168; cv=none; b=M+F/Z4IOBymLKER9CaRkHptcD4Vl9pC9Nh8G+vZZ9kwKpsbCoP6+ancKbshLNYC2C2Gr9fF7ykUZg0Xh4+opVCa2OOucOMYvAY+f4T3WMdkeG3pooVDCVAiAsoDoUogsC0eE0KfSQVX/h9rOuJvB/qGz8+/GOjgJWDm0fY2pEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489168; c=relaxed/simple;
	bh=m4SkwGBwuYNWHHghN05gTZyhGsaid8y/tuhX8kpSUHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeD9Q6vsHlAcUY8PDAMXVunNF+jBw4OEd8BPFTDOWy/jZJzX0u7IUhoNYTrBdD0Rbsh4f913DV3VmFnoNANKYvfLoK/ZWuQiPy2QWqge6dsOusqmvL2YtvEsiaOmRREsoIw9AnH3NRel2oFh7mCbXi3J7/EMZVnidcvihFbe/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le6W/jI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le6W/jI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86329C4CED1;
	Thu, 13 Feb 2025 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489167;
	bh=m4SkwGBwuYNWHHghN05gTZyhGsaid8y/tuhX8kpSUHA=;
	h=From:To:Cc:Subject:Date:From;
	b=Le6W/jI2Wia46u7sJKLUgWO5LLTve/tBrHQ2wDMj10/HFNW6b24quZ8F2KYa/io6G
	 Qll39gEiN+mz+OA40VCZ6ITvjC6RXCoHJWwVo1GKjLzNxyAB94R7CgEhx9jLsFEo2r
	 hPLXcxMfqAEc3xRcmRNhNAcNkBL17WXFiagUs31bM7XLb6uXMuqXvkD8aHwITTa2Ae
	 Bzx9A2pLm6VFWkoB+RYJpJa9T62IONWZlRnjz2ZyYQfw+MpHq7lbIlqh/GRzXM0dCp
	 qmOdeWflX1cA/ebR+6fhSyV5aCex4eVPvQRBII0cZBhNzKzRWDDYfWhSivdSAyVC+0
	 ryDlFiu46/iHA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/3] rcu/exp updates
Date: Fri, 14 Feb 2025 00:25:56 +0100
Message-ID: <20250213232559.34163-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a few updates for expedited RCU. Some were inspired by debates
with Paul while he was investigating the issue that got eventually
fixed by "rcu: Fix get_state_synchronize_rcu_full() GP-start detection".

Frederic Weisbecker (3):
  rcu/exp: Protect against early QS report
  rcu/exp: Remove confusing needless full barrier on task unblock
  rcu/exp: Remove needless CPU up quiescent state report

 kernel/rcu/tree.c        |  2 --
 kernel/rcu/tree_exp.h    | 59 ++++++----------------------------------
 kernel/rcu/tree_plugin.h |  1 -
 3 files changed, 9 insertions(+), 53 deletions(-)

-- 
2.46.0

