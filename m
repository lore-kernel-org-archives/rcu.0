Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0738FAD;
	Fri, 14 Mar 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963009; cv=none; b=JxBdPWhlMG1WUA5c8UStZOcAtLjDF/d2J3IuTbKVEc9fC1Zs+J+WdpbTgNw8kV0HyW14G8Ciqm2N3sW0GlBI1F4D65VOoIen7FPoVjWIEdxqGkOZieXCY4Y+uQW08pJMTNiXZAN6UNbKUQPognYlbjC8rBnYv5m3QX7gNIiV1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963009; c=relaxed/simple;
	bh=IBlfiPFk2zgPUDOKEjy5xciZhCsVE7i9l2hkdj78FWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCJFNmRA8s5ItXLiNiFZ+B9iahVdTsvJFzi7trs6XaA/Jgo0j9XE/5NgiPPEmX/HZxjqYbG2GY8AbnCVl9XZ2tK3MdUHTdOcXCZX46Wbf+F/Wdd1QdMmDAuQz73nEM1cOrVX6fB+QLZaTNtklmpkT6oXg3pfIgO0zZZ7Bkw/u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1zhEQ0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1zhEQ0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C8BC4CEE3;
	Fri, 14 Mar 2025 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963009;
	bh=IBlfiPFk2zgPUDOKEjy5xciZhCsVE7i9l2hkdj78FWs=;
	h=From:To:Cc:Subject:Date:From;
	b=s1zhEQ0o+dSdlsatsMigzfvQYvxxIkSMj6L+h4RbpvqEbJnVK6COKaLRTXp/RPnqL
	 9v+/ijjJJQEpqVpL4nnz+sX1mnPLRwfl8ulwrAHJsycOQi/7xBKtC6okVE7jP5WsyB
	 1ZatlpAlfsuXyztbcTMr11oJVRn7lkqVMNYi0Vddft8DkdmM0EXTskdX1IDTDnnvuF
	 55Uc90KCO2iQUEYUgZeloNrKPK7ywpFlf0D+S4PIZsJsSwWgr4cK1EO0+xWjwY9Wpy
	 gF3ReTkI+van5V3lYWCwO3hBNoAuUlBmi5VUQQBFsXiwlNsamCj0IxNN7zV2nzO4jK
	 OGFF5O46Syrqg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/5 v2] rcu/exp updates
Date: Fri, 14 Mar 2025 15:36:37 +0100
Message-ID: <20250314143642.72554-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes in this version:

* [1/5] Explain why it's fine if a task unblocks between
  sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), per Paul's
  suggestion.

* [3/5] Add Paul's reviewed-by tag

* [4/5] and [5/5] are new patches after discussion.

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
2.48.1

