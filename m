Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA183CD2;
	Fri, 16 Aug 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781089; cv=none; b=XrgZAG3/ALCS7kis4K8p9hq45RM7cXg36DURtIbX63urUvfNewExtVTq1BqnKnvBDF53n7j+YYMBIjDJIgmw687jG1+WqOSDXxtqGB8r5mN9edAgUkY7Tpe/BigZGIrxqADpE9i50GBEbUDoNxV/sJ2Pb6pUbxTFjUVf4ioq4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781089; c=relaxed/simple;
	bh=7Y5L9kQlhh/suY4IvkdPD01biH3wXCMEYqTW+T86dAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvo2ulKxno1UWcFXx43+YpR8wPkBfFxp4GhEqkGK3mzWGgNiLPkhSW0wAKA8VhbB7MCgVBNAN8dHnqe/kTuuljTV0IgO2PzPXbMnx0SxZxCGp7y8Pp1W0m51GLr6sP893BLjFQN26aIsvNb/npGVgGm/vUqm4H+ugxOtbjyRtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb5sJcYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb5sJcYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D218BC4AF10;
	Fri, 16 Aug 2024 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781088;
	bh=7Y5L9kQlhh/suY4IvkdPD01biH3wXCMEYqTW+T86dAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rb5sJcYbosa1IBgN8WnGGRBd0IXRW6iLl1J9N2jlwrkO+9zdo5balWdKoNVxjQ6dN
	 iok41qibjtjV5nkQruK9Kj2cFLD1D5PkCGW3c6jBLUrWUYwX/9mx6l3mFchAkYS+95
	 W3XiuwJdOWKCRDvr7IzySEsnUUXd3msQ2TXmjSQJtJeHfkIC7bmI4WvYO3BHADT6Ve
	 r6gk3mUaKpd5q5HvH6ScQX1keIXJksjS2XPI1dJxmrrO8TwVHR7qb6a3Vpn7PRoG/g
	 2eEpj+NUCOnbc8ZD4+WuQvtVFRIGlgqFF5Z3Me1n2A8GChBIF4iwrrziYVO45E8mv4
	 TSpZD2lJvD9BA==
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
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 11/26] context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into ct_nmi_nesting_cpu()
Date: Fri, 16 Aug 2024 09:32:26 +0530
Message-Id: <20240816040241.17776-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 8f32fe599c5c..34fd504e53a8 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -92,7 +92,7 @@ static __always_inline long ct_nmi_nesting(void)
 	return __this_cpu_read(context_tracking.nmi_nesting);
 }
 
-static __always_inline long ct_dynticks_nmi_nesting_cpu(int cpu)
+static __always_inline long ct_nmi_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b1d84a4749..ec49f0155bec 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -516,7 +516,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       ct_rcu_watching_cpu(cpu) & 0xffff,
-	       ct_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
+	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.40.1

